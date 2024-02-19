***on barman server***
vim /etc/barman.d/<dbname>
```bash
[db]
active = true
description = "postgres server"
conninfo = host=db user=barman dbname=postgres
streaming_conninfo = host=db user=streaming_barman dbname=postgres

backup_method = postgres
streaming_archiver = on
slot_name = barman
create_slot = auto

reuse_backup = off

retention_policy = "RECOVERY WINDOW OF 10 DAYS"
```
***now we should create user for barman on postgres server***
```bash
# its better to switch to your postgres user
su postgres

# create barman user
psql -c "CREATE USER barman with superuser password 'password123'"

# create streaming_barman user
psql -c "CREATE USER streaming_barman with replication password 'password123'"
```
***after that you can find the .pgpass file in barman home directory you can see the configuration file below***
```bash
vim .pgpass
# host:port:database:user:password
*:5432:*:barman:password123
*:5432:*:streaming_barman:password123
```
***then go to postgres server and look after pg_hba.conf file***
```bash
vim /var/lib/postgresql/data/pg_hba.conf

host    replication     streaming_barman 172.21.0.5/32          scram-sha-256
host    postgres        barman 		 172.21.0.5/32		scram-sha-256
```
**now restart the postgres container to apply configuration**
```bash
docker restart db
```
**test the db connection on barman server with following command**
```bash
psql -c "SELECT VERSION()" -U barman -h db postgres
```
**same here for streaming_barman user**
```bash
psql -U streaming_barman -h db -c "IDENTIFY_SYSTEM" replication=1
```
**check the barman config and connection with below command too**
```bash
# dont worry about error and warning half of them is gonna fix after the next command
barman check <db_hostname>
```

***now we are getting closer to the end,with this command we tell postgres close the archive file and ship it over***
```bash
barman switch-wal --force -archive <db_hostname>
```
***now we finally get backup***
```bash
barman backup <db_hostname>
```
