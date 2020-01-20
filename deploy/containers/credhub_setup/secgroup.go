package main

import (
	"fmt"
	"net/url"

	"code.cloudfoundry.org/cli/cf/configuration/coreconfig"
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

// getRepository creates a connection to the CF API
func getRepository() (coreconfig.ReadWriter, error) {
	repo := coreconfig.NewRepositoryFromFilepath(
		"/dev/null",
		func(err error) {
			fmt.Printf("%v\n", err)
		},
	)
	if repo == nil {
		return nil, fmt.Errorf("could not create configuration")
	}

	var link ccEndpointLinkData
	err := resolveLink("cloud_controller_https_endpoint", &link)
	if err != nil {
		return nil, fmt.Errorf("could not get link: %w", err)
	}

	endpointURL := url.URL{
		Scheme: "https",
		Host: fmt.Sprintf("%s:%i", link.CC.InternalServiceHostname, link.CC.PublicTLS.Port)
	}
	repo.SetAPIEndpoint(endointURL.String())

	fmt.Printf("Got link data: %+v\n", link)

	return repo, nil
}
