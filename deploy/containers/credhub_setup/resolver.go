package main

import (
	"context"
	"errors"
	"fmt"
	"net"
	"net/url"
	"sync"
	"time"
)

// getDNSResolver returns a custom DNS resolver that uses the BOSH-DNS service.
func getDNSResolver() (*net.Resolver, error) {
	deploymentName, err := getDeploymentName()
	if err != nil {
		return nil, err
	}
	nameServer := fmt.Sprintf("%s-bosh-dns", deploymentName)
	addrs, err := net.LookupHost(nameServer)
	if err != nil {
		return nil, fmt.Errorf("could not look up DNS server %s: %w", nameServer, err)
	}
	mut := sync.Mutex{}
	i := 0
	return &net.Resolver{
		PreferGo: true,
		Dial: func(ctx context.Context, network, address string) (net.Conn, error) {
			mut.Lock()
			defer mut.Unlock()
			overrideAddress := net.JoinHostPort(addrs[i], "53")
			i++
			if i >= len(addrs) {
				i = 0
			}
			dialer := net.Dialer{}
			return dialer.DialContext(ctx, "udp", overrideAddress)
		},
	}, nil
}

// credhubLinkData is the quarks entanglement data structure for the credhub link
type credhubLinkData struct {
	CredHub struct {
		InternalURL string `json:"internal_url"`
		Port        int    `json:"port"`
	} `json:"credhub"`
}

// resolveCredHubAddrsGiven returns the IP addresses of the credhub service.
func resolveCredHubAddrsGivenLink(ctx context.Context, link credhubLinkData) ([]string, error) {
	credhubURL, err := url.Parse(link.CredHub.InternalURL)
	if err != nil {
		return nil, fmt.Errorf("could not parse credhub link URL %s: %w",
			link.CredHub.InternalURL, err)
	}
	resolver, err := getDNSResolver()
	if err != nil {
		return nil, fmt.Errorf("could not get DNS resolver: %w", err)
	}
	var addrs []string
	fmt.Printf("Looking up credhub service %s", credhubURL.Hostname())
	for {
		addrs, err = resolver.LookupHost(ctx, credhubURL.Hostname())
		var dnsError *net.DNSError
		if !errors.As(err, &dnsError) {
			break
		}
		if !(dnsError.Temporary() || dnsError.IsNotFound) {
			// Unexpected DNS error; report and die
			return nil, fmt.Errorf("error looking up host %s: %w", credhubURL.Hostname(), err)
		}
		fmt.Printf(".")
		time.Sleep(10 * time.Second)
	}
	if err != nil {
		return nil, fmt.Errorf("could not lookup credhub host %s: %w",
			credhubURL.Hostname(), err)
	}
	fmt.Printf("\nFound credhub service address: %v\n", addrs)

	return addrs, nil
}

// resolveCredHubAddrs returns the IP addresses of the CredHub service.
func resolveCredHubAddrs(ctx context.Context) ([]string, error) {
	var link credhubLinkData
	err := resolveLink("credhub", &link)
	if err != nil {
		return nil, err
	}
	addrs, err := resolveCredHubAddrsGivenLink(ctx, link)
	if err != nil {
		return nil, fmt.Errorf("could not resolve credhub address: %w", err)
	}
	return addrs, nil
}
