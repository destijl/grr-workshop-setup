#!/bin/bash

gcloud compute copy-files cleanup.py grr-demo:/tmp/
gcloud compute ssh grr-demo -- 'sudo grr_console --command_file /tmp/cleanup.py'


