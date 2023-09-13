#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

check "neovim" nvim --version

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
