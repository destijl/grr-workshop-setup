#!/bin/bash

CR8="gcloud compute instances create"
${CR8} client-deb-wheezy --image grrdemo-debian-wheezy --tags grr-clients --zone us-central1-a
${CR8} client-deb-wheezy-m --image grrdemo-debian-wheezy-m --tags grr-clients --zone us-central1-a
${CR8} client-rhel --image grrdemo-rhel-7 --tags grr-clients --zone us-central1-a
${CR8} client-ubuntu-trusty --image grrdemo-ubuntu-trusty --tags grr-clients --zone us-central1-a
${CR8} client-ubuntu-trusty-m --image grrdemo-ubuntu-trusty-m --tags grr-clients --zone us-central1-a
${CR8} client-win2k8 --image "https://www.googleapis.com/compute/v1/projects/windows-cloud/global/images/windows-server-2008-r2-dc-v20150721" --tags grr-clients --zone us-central1-a --machine-type n1-highmem-2
${CR8} client-win2012 --image "https://www.googleapis.com/compute/v1/projects/windows-cloud/global/images/windows-server-2012-r2-dc-v20150721" --tags grr-clients --zone us-central1-a --machine-type n1-highmem-2

