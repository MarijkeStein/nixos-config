#!/usr/bin/env bash

set -euxo pipefail

export HOSTNAME=$(hostname)
export REPO_PATH="/pub/backup/snapshots/borg/${HOSTNAME}"
export KEY_PATH="/pub/backup/LTS/Core/Passwords/borg-${HOSTNAME}.key"

mkdir "${REPO_PATH}"
chmod 0700 "${REPO_PATH}"

borg init --encryption=repokey-blake2 "${REPO_PATH}"
bat "${KEY_PATH}"
borg key export "${REPO_PATH}" > "${KEY_PATH}"

sudo mkdir /etc/borgmatic
sudo cd /etc/borgmatic
sudo ln -s "/home/marijke/code/nixos-config/hosts/${HOSTNAME}/borgmatic.config.yaml" config.yaml
sudo cd

# then:
#
# cat > "/root/.borg-passphrase-${HOSTNAME}"
# chmod 0600 "/root/.borg-passphrase-${HOSTNAME}"
#
#
# borgmatic create --verbosity 1
# borgmatic mount --archive latest --mount-point /tmp/restore


# EOF

