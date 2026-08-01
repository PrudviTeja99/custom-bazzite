#!/bin/bash
set -ouex pipefail

# Developer tools repository setup
# Example: Adding VS Code GPG key and repo

# 1. Import GPG key
rpm --import https://packages.microsoft.com/keys/microsoft.asc

# 2. Add VS Code repository
cat <<EOF > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
