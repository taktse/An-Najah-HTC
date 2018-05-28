#!/bin/bash
#
# Edit customize.sh as you wish to customize squid.conf.
# It will not be overwritten by upgrades.
# See customhelps.awk for information on predefined edit functions.
# In order to test changes to this, run this to regenerate squid.conf:
#	service frontier-squid
# and to reload the changes into a running squid use
#	service frontier-squid reload
# Avoid single quotes in the awk source or you have to protect them from bash.
#

awk --file `dirname $0`/customhelps.awk --source '{
setoption("acl NET_LOCAL src", "128.138.133.0/24 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 192.12.238.0/24")
setoption("cache_mem", "256 MB")
setoptionparameter("cache_dir", 3, "250000")

setoption("cache_log", "/opt/squid/log/cache.log")
setoption("coredump_dir", "/opt/squid/data/squid_cache")
setoptionparameter("cache_dir", 2, "/opt/squid/data/squid_cache")
setoptionparameter("access_log", 1, "daemon:/opt/squid/log/access.log")
print
}'
