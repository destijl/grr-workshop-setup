from grr.lib import export_utils

# After you do this the UI complains a little, but creating a new hunt fixes it.
hunts = aff4.FACTORY.Open("aff4:/hunts/")
for hunt in hunts.ListChildren():
  aff4.FACTORY.Delete(hunt)

for client in export_utils.GetAllClients():
  aff4.FACTORY.Delete(client.Add("flows"))

