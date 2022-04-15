#!/bin/sh

set -ex

# base channel.
sudo -i nix-channel --add https://nixos.org/channels/nixos-unstable nixos
# home manager to set up user environments.
sudo -i nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# load new channels.
sudo -i nix-channel --update
