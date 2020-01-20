// credhub_setup is a command used to set up CF application security groups so
// that applications can communicate with the internal CredHub endpoint.
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"time"
)

// getDeploymentName returns the deployment name, which is embedded in some
// names and paths.
func getDeploymentName() (string, error) {
	deploymentNameBytes, err := ioutil.ReadFile("/run/pod-info/deployment-name")
	if err != nil {
		return "", fmt.Errorf("could not read redeployment name: %w", err)
	}
	return string(deploymentNameBytes), nil
}

// resolveLink reads the quarks entanglements (BOSH links) data.
func resolveLink(name string, data interface{}) error {
	deploymentName, err := getDeploymentName()
	if err != nil {
		return err
	}
	linkPath := filepath.Join("/quarks/link", deploymentName, name, "link.yaml")
	linkFile, err := os.Open(linkPath)
	if err != nil {
		return fmt.Errorf("could not read link data %s: %w", linkPath, err)
	}
	decoder := json.NewDecoder(linkFile)
	err = decoder.Decode(&data)
	if err != nil {
		return fmt.Errorf("could not read links: %w", err)
	}
	fmt.Printf("Successfully resolved link: %+v\n", data)
	return nil
}

type securityGroupEntry struct {
	Protocol    string
	Destination string
	Ports       string
	Code        int `json:",omit_empty"`
	Type        int `json:",omit_empty"`
	Log         bool
	Description string
}

func buildSecurityGroupList(addrs []string, port int) []securityGroupEntry {
	entries := make([]securityGroupEntry, 0, len(addrs))
	for _, addr := range addrs {
		entries = append(entries, securityGroupEntry{
			Protocol:    "tcp",
			Destination: addr,
			Ports:       fmt.Sprintf("%d", port),
			Description: "CredHub service access",
		})
	}
	return entries
}

func setupCredHubApplicationSecurityGroups(ctx context.Context) error {
	addrs, err := resolveCredHubAddrs(ctx)
	if err != nil {
		return fmt.Errorf("could not resolve credhub address: %w", err)
	}

	fmt.Printf("%v\n", addrs)

	repo, err := getRepository()
	if err != nil {
		return fmt.Errorf("could not get API connection: %w", err)
	}
	fmt.Printf("Got repo: %+v\n", repo)
	//secGroups := buildSecurityGroupList(addrs, link.CredHub.Port)
	return nil

}

func main() {
	ctx := context.Background()
	err := setupCredHubApplicationSecurityGroups(ctx)
	if err != nil {
		fmt.Printf("Could not set up CredHub application security groups: %v", err)
		os.Exit(1)
	}
	for {
		time.Sleep(24 * time.Hour)
	}
}
