#!/bin/bash

gcloud config set compute/zone us-central1-a
gcloud compute copy-files collect_bashrc.py create_users.py grr-demo:/tmp/

# Collects all the bashrc's from a machine, then changes one, so we can download
# it again and show the axis of time record.
gcloud compute ssh grr-demo -- 'sudo grr_console --command_file /tmp/collect_bashrc.py'
gcloud compute ssh client-ubuntu-trusty-m -- 'echo "export LD_PRELOAD=/usr/share/.sysd.so" >> ~/.bashrc'


# Create users
gcloud compute ssh grr-demo -- 'sudo grr_console --command_file /tmp/create_users.py'
