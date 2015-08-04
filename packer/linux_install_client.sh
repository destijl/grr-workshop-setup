#!/bin/bash
set -e

if [[ ${GRR_DEBURL} ]]; then
  PKG=$(basename ${GRR_DEBURL})
  wget --quiet ${GRR_DEBURL}
  sudo dpkg --install ${PKG}
elif [[ ${GRR_RPMURL} ]]; then
  PKG=$(basename ${GRR_RPMURL})
  sudo yum install -y wget
  wget --quiet ${GRR_RPMURL}
  sudo rpm -i ${PKG}
fi

# Delete local config to force a re-enroll.
sudo service grr stop || true
sudo /etc/init.d/grr stop || true

# Workaround bug in grr debian postinst that doesn't set the right runlevels
sudo update-rc.d grr defaults || true
sudo rm -f /etc/grr.local.yaml || true
