sudo chown $USER /run/postgresql
pg_ctl -D ~/.config/DB/postgres -l /tmp/postgres-logfile start
