#!/bin/bash

# Collects all the bashrc's from a machine, then changes one, so we can download
# it again and show the axis of time record.
gcloud compute copy-files collect_bashrc.py grr-demo:/tmp/
gcloud compute ssh grr-demo -- 'sudo grr_console --command_file /tmp/collect_bashrc.py'
gcloud compute ssh client-ubuntu-trusty-m -- 'echo "export LD_PRELOAD=/usr/share/.sysd.so" >> ~/.bashrc'

