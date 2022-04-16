# nixos_test1

0. download qemu (virtual machine), ovmf (uefi support), nixos minimal installer
1. efi stubs:
   * `cp pathto/OVMF.fd pathto/qemu_imagedir/`
   * `cp pathto/OVMF_VARS.fd pathto/qemu_imagedir/`
2. qemu image creation inside `qemu_imagedir/`:
   * `qemu-img create -f qcow2 nixos-encrypted.img 20G`
3. directory structure should be now the following:
```txt
qemu_imagedir/
qemu_imagedir/OVMF.fd
qemu_imagedir/OVMF_VARS.fd
qemu_imagedir/nixos-encrypted.img
```
4. qemu run installer in `qemu_imagedir/`:
```sh
qemu-system-x86_64 -enable-kvm -boot d \
-cdrom ../nixos-minimal.iso \
-serial mon:stdio \
-net user \
-net nic \
-drive if=pflash,format=raw,unit=0,readonly=on,file=OVMF.fd \
-drive if=pflash,format=raw,unit=1,file=OVMF_VARS.fd \
-m 2G -cpu host -smp 2 -hda nixos-encrypted.img
# to work from in host shell for efi image (in dos one can select ttyS0 from grub)
# run the following after nixos was booted:
sudo systemctl start serial-getty@ttyS0
```
5. setting up harddrive: run install-testbox.sh
6. TODO: minimal user config for testing uefi:
```sh
sudo nixos-generate-config --root /mnt
curl -LO github.com/matu3ba/nixos_test1/archive/master.zip
#wget github.com/matu3ba/nixos_test1/archive/master.zip # wget not installed
unzip master.zip
mv nixos_test1-master/ nixos_test1/ # github archiver being annoyoing
```
7. `sudo nixos-install --no-root-passwd`
7. qemu run user
8. TODO: minimal user config for testing ssh
9. TODO: minimal user config for automatic sending of commands via ssh
10. TODO: zig fun: fetch+build stuff from source to test, if setup works
11. TODO: make stuff OS agnostic?

side tasks
* TODO usable user config
* TODO enable logging for sshd
* TODO fix ssh in nixos user `ssh nixos@localhost -p 2022` in qemu (connection refused) ?

#### sources

* https://dzone.com/articles/nixos-native-flake-deployment-with-luks-and-lvm
* https://joonas.fi/2021/02/uefi-pc-boot-process-and-uefi-with-qemu/
* https://www.reddit.com/r/NixOS/comments/f7jzmt/is_there_a_way_to_script_the_installation_of/
* https://github.com/compactcode/dot-files
* https://github.com/NixOS/nixpkgs/issues/58198#issuecomment-701265223
