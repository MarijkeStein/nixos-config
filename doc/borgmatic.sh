#!/usr/bin/env bash

set -euxo pipefail

export HOSTNAME=$(hostname)
export REPO_PATH="/pub/backup/snapshots/borg/${HOSTNAME}"
export KEY_PATH="/pub/backup/LTS/Core/Passwords/borg-${HOSTNAME}.key"

mkdir "${REPO_PATH}"
chmod 0700 "${REPO_PATH}"

sudo borg init --encryption=repokey-blake2 "${REPO_PATH}"
sudo borg key export "${KEY_PATH}"

mkdir /etc/borgmatic
cd /etc/borgmatic
ln -s "/home/marijke/code/nixos-config/hosts/${HOSTNAME}/borgmatic.config.yaml" config.yaml
cd


# then:
#
# cat > "/root/.borg-passphrase-${HOSTNAME}"
# chmod 0600 "/root/.borg-passphrase-${HOSTNAME}"
#
#
# borgmatic create --verbosity 1
# borgmatic mount --archive latest --mount-point /tmp/restore


# EOF

