# Restoring from backup

Backups are made with `restic` by `scripts/friday--backup`. Two repos exist:

- **USB** (label: `backup`) — latest snapshot only. Use after a fresh install.
- **Hetzner Storage Box** — full history (7d / 4w / 12m / 3y). Use when the USB is also gone.

Both repos are encrypted with the same passphrase. Same restore commands, different `-r` flag.

---

## Restore from USB (normal case — fresh install)

1. **Mount the USB:**
   ```
   sudo mkdir -p /media/usb
   sudo mount /dev/disk/by-label/backup /media/usb
   ```

2. **List snapshots** — also confirms passphrase + repo are valid:
   ```
   restic -r /media/usb/restic/friday snapshots
   ```

3. **Restore the latest snapshot to a staging dir:**
   ```
   mkdir -p ~/restored
   restic -r /media/usb/restic/friday restore latest --target ~/restored
   ```
   Files land at `~/restored/home/cr0xd/main/...` etc.

4. **Move what you want into place, then unmount:**
   ```
   sudo umount /media/usb
   ```

### Restore one file/dir instead of everything

```
restic -r /media/usb/restic/friday restore latest \
  --target ~/restored \
  --include /home/cr0xd/main/some-project
```

### Browse the snapshot like a filesystem (no restore needed)

```
mkdir /tmp/snapshots
restic -r /media/usb/restic/friday mount /tmp/snapshots
# in another terminal:
ls /tmp/snapshots/snapshots/latest/
# Ctrl+C the mount command when done
```

---

## Restore from Hetzner (disaster — USB also lost)

You need:
- Access to Hetzner Console (`console.hetzner.com`)
- The restic passphrase (memorized + sealed copy off-site)

1. **Install restic and SSH:**
   ```
   sudo pacman -S restic openssh
   ```

2. **Generate a new SSH key on the new machine:**
   ```
   ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
   ```

3. **Add the public key to the Storage Box** via Hetzner Console:
   - Log in -> Storage Box -> SSH keys -> paste `~/.ssh/id_ed25519.pub`.

4. **Add the host alias to `~/.ssh/config`:**
   ```
   Host backup
       HostName u603365.your-storagebox.de
       User u603365
       Port 23
       IdentityFile ~/.ssh/id_ed25519
       IdentitiesOnly yes
   ```

5. **Verify SSH works:**
   ```
   ssh backup
   ```
   Should drop you into the SFTP shell. Exit with `exit`.

6. **List + restore** (same commands as USB, different repo URL):
   ```
   restic -r sftp:backup:restic/friday snapshots
   mkdir -p ~/restored
   restic -r sftp:backup:restic/friday restore latest --target ~/restored
   ```

---

## Notes

- **UID mismatch:** if the new user's UID differs from the old (rare — usually 1000 on Arch), restored files will have the old ownership. Fix with `chown -R cr0xd:cr0xd ~/restored`.
- **Forgotten passphrase = data is gone.** Restic has no recovery mechanism by design. The passphrase must be memorized AND written down somewhere physical.
- **Hetzner access matters as much as the passphrase.** If you lose Hetzner Console access (email + 2FA gone), you can't add an SSH key, can't reach the repo. Keep recovery codes off-laptop.
