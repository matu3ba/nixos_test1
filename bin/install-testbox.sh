#!/bin/sh

set -ex

export INSTALL_DRIVE_NAME=?
export INSTALL_DRIVE_PASSWORD=?

./install-channels.sh
./prepare-uefi-filesystem.sh

# select machine to install.
#ln -s /tmp/nixos_test1/nixos/machines/testbox.nix /mnt/etc/nixos/configuration.nix
#sudo -i nixos-install --no-root-passwd
