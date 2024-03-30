sudo chown $USER /run/postgresql
pg_ctl -D ~/DB/postgres -l /tmp/ostgres-logfile start
