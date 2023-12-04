#!/usr/bin/env bash

partition_boot=/dev/nvme0n1p1
partition_prim=/dev/nvme0n1p2
partition_secd=/dev/nvme0n1p3

echo "===================="
echo "Configure Arch Linux :: timezone && locales"
echo "===================="
#
# To get list of available time zones:
#   timedatectl list-timezones
#
timedatectl set-timezone Europe/Warsaw

echo en_GB.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=en_GB.UTF-8 > /etc/locale.conf
export LANG=en_GB.UTF-8

echo "===================="
echo "Configure Arch Linux :: network"
echo "===================="

echo friday > /etc/hostname

touch /etc/hosts
echo "127.0.0.1	  localhost" > /etc/hosts
echo "::1         localhost" >> /etc/hosts
echo "127.0.1.1	  friday" >> /etc/hosts

echo "===================="
echo "Configure Arch Linux :: users && passwords"
echo "===================="

passwd
useradd -m cr0xd
passwd cr0xd
chmod cr0xd: /home/cr0xd
chown -R cr0xd: /home/cr0xd
usermod -aG wheel cr0xd
visudo

systemctl enable NetworkManager

echo "===================="
echo "Configure Arch Linux :: GRUB bootloader"
echo "===================="

#
# To validate boot order:
#   efibootmgr
# BIOS UEFI may not match boot order from command above.
#   In that case `--removable` option helped
#

pacman -S --noconfirm intel-ucode
pacman -S --noconfirm grub efibootmgr
pacman -S --noconfirm os-prober

mkdir /boot/efi
mount $partition_boot /boot/efi

grub-install --target=x86_64-efi --bootloader-id=arch --removable
echo GRUB_DISABLE_OS_PROBER=false >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
