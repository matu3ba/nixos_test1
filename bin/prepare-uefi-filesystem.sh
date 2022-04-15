#!/bin/sh

set -eux

# size of boot partition.
BOOT_SIZE=512MiB

# UEFI requires partition to use gpt.
sudo -i parted $INSTALL_DRIVE_NAME -- mklabel gpt
# boot partition
sudo -i parted $INSTALL_DRIVE_NAME -- mkpart ESP fat32 1MiB $BOOT_SIZE
# root partition
sudo -i parted $INSTALL_DRIVE_NAME -- mkpart root $BOOT_SIZE 100%
# enable boot partition.
sudo -i parted $INSTALL_DRIVE_NAME -- set 1 boot on

# setup encryption on the root partition.
sudo sh -c "echo $INSTALL_DRIVE_PASSWORD | cryptsetup luksFormat /dev/disk/by-partlabel/root"
# mount a decrypted version of the encrypted root partition.
sudo sh -c "echo $INSTALL_DRIVE_PASSWORD | cryptsetup luksOpen /dev/disk/by-partlabel/root nixos-decrypted"

# format boot partition.
sudo -i mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/ESP
# format decrypted version of root partition.
sudo -i mkfs.ext4 -L root /dev/mapper/nixos-decrypted

# wait for disk labels to be written
sleep 4

# mount root & boot partitions.
sudo -i mount -o noatime /dev/disk/by-label/root /mnt
sudo -i mkdir /mnt/boot
sudo -i mount -o noatime /dev/disk/by-label/boot  /mnt/boot

# prepare directory to place dotfiles.
sudo -i mkdir -p /mnt/etc/dotfiles/nixos
sudo -i chown -R nixos /mnt/etc/dotfiles/nixos

# prepare directories to place nix configuration.
sudo -i mkdir -p /mnt/etc/nixos
sudo -i chown -R nixos /mnt/etc/nixos
