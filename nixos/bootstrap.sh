#!/usr/bin/env bash

disk_nvme="/dev/nvme0n1"

parted $disk_nvme -- mklabel gpt

parted $disk_nvme -- mkpart ESP fat32 1MiB 512MiB
parted $disk_nvme -- mkpart primary 512MiB 512GB
parted $disk_nvme -- mkpart primary 512GB 768GB
parted $disk_nvme -- mkpart primary 768GB 100%
parted $disk_nvme -- set 1 boot on
#parted $disk_nvme -- mkpart primary linux-swap 233293824s 100%

#parted $disk_hdd -- mklabel gpt
#parted $disk_hdd -- mkpart primary 0% 100%

mkfs.fat -F 32 -n boot ${disk_nvme}p1        # (for UEFI systems only)
mkfs.ext4 -L nvme1 ${disk_nvme}p2
mkfs.ext4 -L nvme2 ${disk_nvme}p3
mkfs.ext4 -L nvme3 ${disk_nvme}p4
#mkswap -L swap ${disk_nvme}p2
#swapon ${disk_nvme}p2
#mkfs.ext4 -L hdd ${disk_hdd}1

echo "===================="
parted $disk_nvme -- print
echo "===================="
read -p "Press enter to continue"

mount /dev/disk/by-label/nvme1 /mnt
mkdir -p /mnt/boot                      # (for UEFI systems only)
mount /dev/disk/by-label/boot /mnt/boot # (for UEFI systems only)

nixos-generate-config --root /mnt
nixos-install

echo "Completed. Please reboot"
