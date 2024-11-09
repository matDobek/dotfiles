#!/usr/bin/env bash

partition_boot=/dev/nvme0n1p1

echo "===================="
echo "Configure Arch Linux :: timezone && locales"
echo "===================="
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc

echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
echo en_GB.UTF-8 UTF-8 >> /etc/locale.gen
echo pl_PL.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=pl > /etc/vconsole.conf

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

echo "root password:"
passwd

useradd -m cr0xd
echo "cr0xd password:"
passwd cr0xd

chmod cr0xd: /home/cr0xd
chown -R cr0xd: /home/cr0xd
usermod -aG wheel cr0xd
visudo

systemctl enable NetworkManager

echo "===================="
echo "Configure Arch Linux :: GRUB bootloader"
echo "===================="

pacman -S --noconfirm intel-ucode
pacman -S --noconfirm grub efibootmgr
pacman -S --noconfirm os-prober

mkdir /boot/efi
mount $partition_boot /boot

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB2 --removable
echo GRUB_DISABLE_OS_PROBER=false >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
