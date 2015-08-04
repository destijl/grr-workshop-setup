#!/bin/bash
set -e

if [[ ${GRR_DEBURL} ]]; then
  PKG=$(basename ${GRR_DEBURL})
  wget --quiet ${GRR_DEBURL}
  dpkg --install ${PKG}
elif [[ ${GRR_RPMURL} ]]; then
  PKG=$(basename ${GRR_RPMURL})
  wget --quiet ${GRR_RPMURL}
  rpm -i ${PKG}
fi

# Force re-enroll on start.
service grr stop || true
/etc/init.d/grr stop || true
rm -f /etc/grr.local.yaml || true
