#!/bin/bash

set -ouex pipefail

# 1. Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

# 2. Execute module scripts (repository setups, GPG keys, systemd unit configs)
if [ -d "/ctx/modules" ]; then
    for script in $(ls /ctx/modules/*.sh 2>/dev/null | sort); do
        if [ -f "$script" ]; then
            echo "=== Executing module: $script ==="
            bash "$script"
        fi
    done
fi

# 3. Remove packages specified in 00-remove.txt (if present)
if [ -f "/ctx/packages/00-remove.txt" ]; then
    echo "=== Removing packages listed in 00-remove.txt ==="
    remove_pkgs=$(grep -v '^#' "/ctx/packages/00-remove.txt" | grep -v '^$' || true)
    if [ -n "$remove_pkgs" ]; then
        echo "$remove_pkgs" | xargs dnf5 remove -y
    fi
fi

# 4. Install packages defined in package manifest text files
if [ -d "/ctx/packages" ]; then
    for pkg_file in $(ls /ctx/packages/*.txt 2>/dev/null | sort); do
        if [ "$pkg_file" != "/ctx/packages/00-remove.txt" ] && [ -f "$pkg_file" ]; then
            echo "=== Installing packages from manifest: $pkg_file ==="
            pkgs=$(grep -v '^#' "$pkg_file" | grep -v '^$' || true)
            if [ -n "$pkgs" ]; then
                echo "$pkgs" | xargs dnf5 install -y
            fi
        fi
    done
fi

# 5. Install standalone .rpm packages placed in /ctx/rpms/
if ls /ctx/rpms/*.rpm 1>/dev/null 2>&1; then
    echo "=== Installing standalone RPM packages from /ctx/rpms/ ==="
    dnf5 install -y /ctx/rpms/*.rpm
fi

# 6. Clean DNF metadata caches to keep container image minimal
dnf5 clean all
