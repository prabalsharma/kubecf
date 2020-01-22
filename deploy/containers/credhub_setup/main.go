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
	fmt.Fprintf(os.Stderr, "Successfully resolved link: %+v\n", data)
	return nil
}

func process(ctx context.Context) error {
	err := setupResolver()
	if err != nil {
		return fmt.Errorf("could not set up custom DNS resolver: %w", err)
	}
	addrs, port, err := resolveCredHubInfo(ctx)
	if err != nil {
		return err
	}
	client, err := authenticate(ctx)
	if err != nil {
		return err
	}
	fmt.Printf("Got client: %+v\n", client)
	err = setupCredHubApplicationSecurityGroups(ctx, client, addrs, port)
	if err != nil {
		return fmt.Errorf("error setting security groups: %w", err)
	}
	return nil
}

func main() {
	ctx := context.Background()
	err := process(ctx)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Could not set up CredHub application security groups: %v", err)
		os.Exit(1)
	}
	for {
		time.Sleep(24 * time.Hour)
	}
}
