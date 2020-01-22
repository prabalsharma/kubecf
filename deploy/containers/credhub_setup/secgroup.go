package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net"
	"net/http"
	"net/url"
)

type ccEndpointLinkData struct {
	CC struct {
		InternalServiceHostname string `json:"internal_service_hostname"`
		PublicTLS               struct {
			CACert string `json:"ca_cert"`
			Port   int    `json:"port"`
		} `json:"public_tls"`
	} `json:"cc"`
}

type securityGroupRule struct {
	Protocol    string `json:"protocol"`
	Destination string `json:"destination"`
	Ports       string `json:"ports"`
	Log         bool   `json:"log"`
	Description string `json:"description"`
}

type securityGroupDefinition struct {
	Metadata struct {
		GUID string `json:"guid"`
	} `json:"metadata"`
	Entity struct {
		Name  string              `json:"name"`
		Rules []securityGroupRule `json:"rules"`
	} `json:"entity"`
}

func buildSecurityGroup(addrs []string, port string) map[string]interface{} {
	entries := make([]securityGroupRule, 0, len(addrs))
	for _, addr := range addrs {
		entries = append(entries, securityGroupRule{
			Protocol:    "tcp",
			Destination: addr,
			Ports:       port,
			Description: "CredHub service access",
		})
	}
	return map[string]interface{}{
		"name":  securityGroupName,
		"rules": entries,
	}
}

const securityGroupName = "credhub-internal"

// getExistingSecurityGroup returns the GUID of the existing security group, if
// there is one; otherwise, returns the empty string.
func getExistingSecurityGroup(ctx context.Context, client *http.Client, baseURL *url.URL) (string, error) {
	existingURL := &url.URL{
		Path: "/v2/security_groups",
	}
	existingURL = baseURL.ResolveReference(existingURL)
	query := existingURL.Query()
	query.Set("q", fmt.Sprintf("name:%s", securityGroupName))
	existingURL.RawQuery = query.Encode()
	fmt.Printf("Checking for existing groups via %s\n", existingURL)
	resp, err := client.Get(existingURL.String())
	if err != nil {
		return "", fmt.Errorf("could not get existing security groups: %w", err)
	}

	var responseData struct {
		Resources []securityGroupDefinition `json:"resources"`
	}
	err = json.NewDecoder(resp.Body).Decode(&responseData)
	if err != nil {
		return "", fmt.Errorf("could not read existing security groups: %w", err)
	}

	fmt.Printf("Got security groups: %+v\n", responseData)
	for _, resource := range responseData.Resources {
		if resource.Entity.Name == securityGroupName {
			return resource.Metadata.GUID, nil
		}
	}

	return "", nil
}

func createOrUpdateSecurityGroup(ctx context.Context, client *http.Client, baseURL *url.URL, contentReader io.Reader) (string, error) {
	groupID, err := getExistingSecurityGroup(ctx, client, baseURL)
	if err != nil {
		return "", err
	}
	var updateURL *url.URL
	var method string
	if groupID == "" {
		updateURL = &url.URL{
			Path: "/v2/security_groups",
		}
		method = http.MethodPost
	} else {
		updateURL = &url.URL{
			Path: fmt.Sprintf("/v2/security_groups/%s", groupID),
		}
		method = http.MethodPut
	}
	updateURL = baseURL.ResolveReference(updateURL)
	req, err := http.NewRequestWithContext(ctx, method, updateURL.String(), contentReader)
	if err != nil {
		return "", fmt.Errorf("could not create update request: %w", err)
	}
	resp, err := client.Do(req)
	if err != nil {
		return "", fmt.Errorf("could not submit update request: %w", err)
	}

	if resp.StatusCode < 200 || resp.StatusCode >= 400 {
		return "", fmt.Errorf("got response %s", resp.Status)
	}

	var resultingSecurityGroup securityGroupDefinition
	err = json.NewDecoder(resp.Body).Decode(&resultingSecurityGroup)
	if err != nil {
		return "", fmt.Errorf("updated security group (%s) but failed to read response: %w", resp.Status, err)
	}
	fmt.Printf("Succesfully updated security group: %s / %+v\n", resp.Status, resultingSecurityGroup)

	return resultingSecurityGroup.Metadata.GUID, nil
}

func bindDefaultSecurityGroup(ctx context.Context, phase, groupID string, client *http.Client, baseURL *url.URL) error {
	bindURL := baseURL.ResolveReference(&url.URL{
		Path: fmt.Sprintf("/v2/config/%s_security_groups/%s", phase, groupID),
	})
	req, err := http.NewRequestWithContext(ctx, http.MethodPut, bindURL.String(), nil)
	if err != nil {
		return fmt.Errorf("failed to create %s security group request: %w", phase, err)
	}
	resp, err := client.Do(req)
	if err != nil {
		return fmt.Errorf("could not set %s security group: %w", phase, err)
	}
	if resp.StatusCode < 200 || resp.StatusCode >= 400 {
		return fmt.Errorf("error setting %s security group: %s", phase, resp.Status)
	}
	fmt.Printf("Successfully bound %s security group: %s\n", phase, resp.Status)
	return nil
}

func setupCredHubApplicationSecurityGroups(ctx context.Context, client *http.Client, addrs []string, port int) error {
	var link ccEndpointLinkData
	err := resolveLink("cloud_controller_https_endpoint", &link)
	if err != nil {
		return fmt.Errorf("could not get CC link: %w", err)
	}
	baseURL := &url.URL{
		Scheme: "https",
		Host: net.JoinHostPort(
			link.CC.InternalServiceHostname,
			fmt.Sprintf("%d", link.CC.PublicTLS.Port),
		),
	}

	contents := buildSecurityGroup(addrs, fmt.Sprintf("%d", port))
	contentBytes, err := json.Marshal(contents)
	if err != nil {
		return fmt.Errorf("could not build security group definition: %w", err)
	}
	contentReader := bytes.NewReader(contentBytes)

	groupID, err := createOrUpdateSecurityGroup(ctx, client, baseURL, contentReader)
	if err != nil {
		return err
	}

	for _, phase := range []string{"staging", "running"} {
		err = bindDefaultSecurityGroup(ctx, phase, groupID, client, baseURL)
		if err != nil {
			return err
		}
	}

	return nil
}
