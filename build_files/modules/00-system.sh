#!/bin/bash
set -ouex pipefail

# System configuration module
# Place systemd unit activations, udev rules, or system tweaks here

# Enable Podman socket
systemctl enable podman.socket
