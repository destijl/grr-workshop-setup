# GRR Workshop Setup

This repo has files and scripts that will allow you to create and run your own GRR workshop.

You'll need a Google compute engine account for running the clients and the server in GCE. A domain name to use for the server makes things easier but isn't required.

## Create the server

Create a reasonably high-powered Ubuntu trusty VM for the GRR server (I used n1-standard-8). Install the server using the [quickstart instructions](https://github.com/google/grr-doc/blob/master/quickstart.adoc). If you have a domain name for the demo server make sure to use it in the settings prompts.

## Download and host the clients

Download the client installers from the GRR server UI (under Manage Binaries) and put them somewhere your machines can download them from (drive, dropbox, S3). You can't re-use my clients because your clients need to be configured to talk to your own server.

## Install packer and get a GCE service account

Install [packer](https://packer.io/), we'll use it to create the machine images for the client.

Create a service account and download the key from the [GCE console](https://console.developers.google.com) APIs & Auth -> Credentials -> Add Credentials -> Service Account -> JSON -> Create. I had to edit the json to add in the Client ID and service account email address (visible in the interface after you create the account) before packer would accept it.

## Build the GCE images with packer

```
cd packer
/usr/local/bin/packer/packer build \
-var 'rpm_url=https://someurl/grr_3.0.0.7_amd64.rpm' \
-var 'deb_url=https://someurl/grr_3.0.0.7_amd64.deb' \
-var 'exe_url=https://soemurl/GRR_3.0.0.7_amd64.exe' \
-var 'project_id=YOUR_GCE_PROJECT_ID' \
demo_images.json
```

This will spin up GCE VMs, run the scripts to get the GRR client installed, and plant some interesting artifacts to find. The VMs are then torn down and are available in GCE under Images. Importantly we make sure to remove the local client config so it will re-enroll when the VM instance is created, so we don't get clients with the same ID installed on multiple machines.

## Create the client VM instances

```
bash create_instances.sh
```
## Configure the windows clients

Unfortunately packer doesn't play well with the stock GCE windows machines.
Packer needs ssh, which you achieve by creating your own VM image with a ssh
server.  But at that point you might as well just run the install script. So RDP
to the two windows machines and run the `prepare_windows.bat` commands in an
admin shell.

You can download the script with this:
```
powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('https://googledrive.com/host/0B1wsLqFoT7i2fjI5TjYtUGZuVTBCTVNYWGpsNjZnc0tQLWROWW91WHlaaWV2YVprN2NOSEE/prepare_windows.bat', 'prepare_windows.bat')"
```
Edit the URL in the script to point at your client, then:

```
prepare_windows.bat
```

## Check you have all the clients

In the server hit enter in the search box and you should see 7 clients.

