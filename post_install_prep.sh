#!/bin/bash

gcloud config set compute/zone us-central1-a
gcloud compute copy-files collect_bashrc.py create_users.py grr-demo:/tmp/

# Collects all the bashrc's from a machine, then changes one, so we can download
# it again and show the axis of time record.
gcloud compute ssh grr-demo -- 'sudo grr_console --command_file /tmp/collect_bashrc.py'
gcloud compute ssh client-ubuntu-trusty-m -- 'echo "export LD_PRELOAD=/usr/share/.sysd.so" >> ~/.bashrc'

# Create users
gcloud compute ssh grr-demo -- 'sudo grr_console --command_file /tmp/create_users.py'

# Should probably change packer scripts to remove the key from config (instead
# of just deleting to force re-enroll) then add these fastpoll settings.
put_clients_into_fastpoll() {
  for client in $1; do
    echo ${client}
    gcloud compute ssh ${client} -- -t 'echo "Client.poll_max: 5" | sudo tee --append /etc/grr.local.yaml'
    gcloud compute ssh ${client} -- -t 'echo "Client.foreman_check_frequency: 20" | sudo tee --append /etc/grr.local.yaml'
    gcloud compute ssh ${client} -- -t 'sudo /etc/init.d/grr restart; sudo service grr restart'
  done
}

CLIENTS="client-deb-wheezy client-deb-wheezy-m client-rhel client-ubuntu-trusty client-ubuntu-trusty-m"
put_clients_into_fastpoll "${CLIENTS}"
