"""GRR console script to collect bashrc."""

from grr.lib import flow_utils
from grr.lib.flows.general import file_finder

action = file_finder.FileFinderAction(action_type="DOWNLOAD")
ff_args = file_finder.FileFinderArgs(paths=["/home/*/.bashrc"], action=action)
newest_time = ""
target_client = None
for client in SearchClients("client-ubuntu-trusty-m"):
  if client[3] > newest_time:
    newest_time = client[3]
    target_client = client[0]

if target_client:
  flow_utils.StartFlowAndWait(target_client.urn, token=None,
                              flow_name="FileFinder", args=ff_args)


