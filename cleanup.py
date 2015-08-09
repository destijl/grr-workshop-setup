"""Cleanup script."""
from grr.lib import export_utils

# After you do this the UI complains a little, but creating a new hunt fixes it.
hunts = aff4.FACTORY.Open("aff4:/hunts/")
for hunt in hunts.ListChildren():
  aff4.FACTORY.Delete(hunt)

# Delete clients that haven't polled in for 2hours
for fd in aff4.FACTORY.MultiOpen(export_utils.GetAllClients()):
  cutoff = rdfvalue.RDFDatetime().Now() - rdfvalue.Duration("2h")
  if fd.Get(fd.Schema.PING) < cutoff:
    aff4.FACTORY.Delete(fd.urn)

# Delete all flows
for client in export_utils.GetAllClients():
  aff4.FACTORY.Delete(client.Add("flows"))


