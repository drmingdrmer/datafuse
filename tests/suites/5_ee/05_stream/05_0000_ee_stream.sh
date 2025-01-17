#!/usr/bin/env bash

CURDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
. "$CURDIR"/../../../shell_env.sh

echo "drop database if exists db_stream" | $BENDSQL_CLIENT_CONNECT

echo "CREATE DATABASE db_stream" | $BENDSQL_CLIENT_CONNECT
echo "create table db_stream.t(a int) change_tracking = true" | $BENDSQL_CLIENT_CONNECT
echo "insert into db_stream.t values(1)" | $BENDSQL_CLIENT_CONNECT
echo "create stream default.test_s on table db_stream.t comment = 'test'" | $BENDSQL_CLIENT_CONNECT
echo "insert into db_stream.t values(2)" | $BENDSQL_CLIENT_CONNECT

BASE_ROW_ID=$(echo "select _base_row_id from default.test_s" | $BENDSQL_CLIENT_CONNECT)
echo "select change\$row_id='$BASE_ROW_ID' from default.test_s" | $BENDSQL_CLIENT_CONNECT
echo "optimize table db_stream.t compact" | $BENDSQL_CLIENT_CONNECT
echo "select a, change\$action, change\$is_update, change\$row_id='$BASE_ROW_ID' from default.test_s" | $BENDSQL_CLIENT_CONNECT

echo "show streams like 'test_s'" | $BENDSQL_CLIENT_CONNECT | awk '{print $(NF-3), $(NF-2), $(NF-1), $NF}'
echo "show full streams like 'test_s'" | $BENDSQL_CLIENT_CONNECT | awk '{print $(NF-6), $(NF-5), $(NF-4), $(NF-3), $(NF-2), $(NF-1), $NF}'
echo "desc stream default.test_s" | $BENDSQL_CLIENT_CONNECT | awk '{print $(NF-6), $(NF-5), $(NF-4), $(NF-3), $(NF-2), $(NF-1), $NF}'

echo "drop stream if exists default.test_s" | $BENDSQL_CLIENT_CONNECT
echo "drop table if exists db_stream.t" | $BENDSQL_CLIENT_CONNECT
echo "drop database if exists db_stream" | $BENDSQL_CLIENT_CONNECT
