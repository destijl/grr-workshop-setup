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

# Force re-enroll on start.
sudo service grr stop || true
sudo /etc/init.d/grr stop || true
sudo rm -f /etc/grr.local.yaml || true
