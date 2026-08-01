#!/bin/bash
set -ouex pipefail

# Developer tools repository setup
# Example: Adding VS Code GPG key and repo

# 1. Import GPG key
rpm --import https://packages.microsoft.com/keys/microsoft.asc

# 2. Add VS Code repository
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo
