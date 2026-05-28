#!/usr/bin/env bash

# Runs after bootstrap3 - as user cr0xd, with the user systemd manager alive
# (i.e. after first login, so XDG_RUNTIME_DIR exists).

#===================
# ssh-agent
#===================
# Socket-activated user service. Starts on demand when SSH_AUTH_SOCK is hit;
# auto-starts on login after this enable.
#
# After reboots, load your key into the agent once per session:
#   ssh-add ~/.ssh/id_ed25519

systemctl --user enable --now ssh-agent.socket
