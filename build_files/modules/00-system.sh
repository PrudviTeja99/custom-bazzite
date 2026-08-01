#!/bin/bash
set -ouex pipefail

# System configuration module
# Place systemd unit activations, udev rules, or system tweaks here

# Add rpm fusion repo
dnf5 install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Enable Podman socket
systemctl enable podman.socket
