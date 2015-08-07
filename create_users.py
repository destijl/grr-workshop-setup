from grr.tools import config_updater

for i in range(1, 50):
    config_updater.AddUser("User%d" % i, "Password%d" % i, labels=["admin"])
