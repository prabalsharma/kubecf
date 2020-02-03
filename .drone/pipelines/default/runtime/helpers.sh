#!/usr/bin/env bash

# This file contains helper functions for the rest of the pipeline.

# Given a bazel target, output the file name it generates.
get_output_file() {
  local package="${1}"
  awk '
    BEGIN { wanted_action = false }
    wanted_action && match($0, /^  Outputs: \[(.*)\]/, output) {
      print output[1];
    }
    /^[^ ]/ { wanted_action = 0 }
    /^action.*\.tgz'"'"'$/ {
      wanted_action = 1
    }
  ' <(bazel aquery "${package}:all" 2>/dev/null)
}
