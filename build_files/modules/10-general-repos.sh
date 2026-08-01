#!/bin/bash
set -ouex pipefail

# General applications repository setup
# Example: Adding Brave Browser GPG key and repo

# 1. Import GPG key
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# 2. Add Brave Browser repository
dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
