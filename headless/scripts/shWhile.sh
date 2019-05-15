cat << EOF | test.sh 
BEGIN;

`pg_dump ----something`

update table .... statement ...;

END;
EOF