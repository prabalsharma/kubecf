#!/usr/bin/env bash

set -o errexit -o nounset

# shellcheck disable=SC1091
source ".drone/pipelines/default/runtime/config.sh"
# shellcheck disable=SC1091
source ".drone/pipelines/default/runtime/helpers.sh"

mkdir -p output
extension="tgz"
describe="$(git describe --match='$^' --dirty --always)"

# Build the kubecf helm chart
bazel build "${KUBECF_CHART_TARGET}"
built_file="$(get_output_file "${KUBECF_CHART_TARGET%:*}")"
release_filename="$(basename "${built_file}" ".${extension}")-${describe}"
cp "${built_file}" "output/${release_filename}.${extension}"
chmod 0644 "output/${release_filename}.${extension}"

# Build the install bundle (kubecf chart + cf-operator chart)
bazel build "${KUBECF_BUNDLE_TARGET}"
built_file="$(get_output_file "${KUBECF_BUNDLE_TARGET%:*}")"
bundle_filename="$(basename "${built_file}" ".${extension}")-${describe}"
cp "${built_file}" "output/${bundle_filename}.${extension}"
chmod 0644 "${built_file}" "output/${bundle_filename}.${extension}"
