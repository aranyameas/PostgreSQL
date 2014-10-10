#!/bin/bash
psql -p $PGPORT $DB_NAME < create_tables.sql > /dev/null
sleep 5

echo "Query time without indexes"
cat <(echo '\timing') queries.sql |psql -p $PGPORT $DB_NAME | grep Time | awk -F "Time" '{print "Query" FNR $2;}'

psql -p $PGPORT $DB_NAME < create_indexes.sql > /dev/null

echo "Query time with indexes"
cat <(echo '\timing') queries.sql |psql -p $PGPORT $DB_NAME | grep Time | awk -F "Time" '{print "Query" FNR $2;}'
