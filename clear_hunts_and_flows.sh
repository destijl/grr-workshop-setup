#!/bin/bash

gcloud compute copy-files clear_hunts_and_flows.py grr-demo:/tmp/
gcloud compute ssh grr-demo -- 'sudo grr_console --command_file /tmp/clear_hunts_and_flows.py'


