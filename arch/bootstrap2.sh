#!/usr/bin/env bash

partition_boot=/dev/nvme0n1p1

echo "===================="
echo "Configure Arch Linux :: pacman"
echo "===================="

sed -i 's|^#ParallelDownloads.*|ParallelDownloads = 5|' /etc/pacman.conf
sed -i 's|^#Color$|Color|' /etc/pacman.conf

pacman -Sy --noconfirm reflector
reflector --country Poland,Germany --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

# Recurring mirror refresh — reflector.timer reads /etc/xdg/reflector/reflector.conf.
# Override the upstream defaults to match how we run it in this script.
cat > /etc/xdg/reflector/reflector.conf <<'EOF'
--save /etc/pacman.d/mirrorlist
--protocol https
--country Poland,Germany
--latest 20
--sort rate
EOF
systemctl enable reflector.timer

# Package cache cleanup — keep last 3 versions of each installed package.
pacman -S --noconfirm pacman-contrib
systemctl enable paccache.timer

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

systemctl enable systemd-resolved
systemctl enable NetworkManager

# Prefer IPv4 over IPv6 in getaddrinfo result ordering. This ISP's IPv6 path
# beyond the gateway is broken, so apps that try v6 first hang.
sed -i 's|^#precedence ::ffff:0:0/96  100|precedence ::ffff:0:0/96  100|' /etc/gai.conf

echo "===================="
echo "Configure Arch Linux :: performance && services"
echo "===================="

# CPU governor — default is powersave; pin to performance on this desktop.
pacman -S --noconfirm cpupower
echo 'governor="performance"' > /etc/default/cpupower
systemctl enable cpupower

# Weekly SSD TRIM.
systemctl enable fstrim.timer

# Cap journald disk usage — default lets it grow to ~10% of fs.
sed -i 's|^#SystemMaxUse=.*|SystemMaxUse=500M|' /etc/systemd/journald.conf

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
