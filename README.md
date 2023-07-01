# Tripsit Development Environment

This will set up a development environment for Tripsit

Everything is contained in docker containers, so there should be no conflicts with your OS

You should still npm install in whichever repo you're working on, but you shouldn't need to install anything else

When you run 'npm start' it will setup:
* Traefik - How this server 


# Barman setup

# Create .pgpass file in /docker/barman/creds
# Create regular user
Create barman user in PG as a superuser, save the password to .pgpass file

# Create streaming user
Create streaming_barman user in PG with streaming rights, save the password to .pgpass file

# Modify hba file
Modify the var/lib/postgresql/data/pg_hba.conf file to add the following lines:

host    replication     all             172.22.0.3/0            trust

Or whatever your IP is

# Modify postgresql.conf
Modify the following lines to the postgresql.conf file:
wal_level = replica
max_wal_senders = 2