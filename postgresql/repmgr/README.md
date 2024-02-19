***repmgr.conf fle***
```bash
node_id=1

node_name=db

conninfo='host=db user=repmgr dbname=repmgr port=5432'

data_directory='/var/lib/postgresql/data'

barman_host='barman@barman'

barman_server=db

restore_command='/usr/bin/barman-wal-restore -U barman barman db %f %p'

pg_bindir='/usr/lib/postgresql/14/bin'

log_file='/var/log/repmgr.log'

use_replication_slots=true
```
***create user for repmgr in postgresql server***
```bsah
psql -c "CREATE USER repmgr WITH superuser"
```
***create database for repmgr***
```bash
psql -c "CREATE DATABASE repmgr owner repmgr"
```
***append the below block to pg_hba.conf file***
```bash
local 	replication 	repmgr 		 			trust
host 	replication 	repmgr 		 172.21.0.0/24		trust
host 	replication 	repmgr 		 127.0.0.1/32		trust

local 	repmgr  	repmgr 		 			trust
host 	repmgr  	repmgr 		 172.21.0.0/24		trust
host 	repmgr  	repmgr 		 127.0.0.1/32		trust
```
***go to postgresql.conf file and uncomment the below line***
```bash
shared_preload_libraries = 'repmgr'
```
restart the postgres after modifying this config
