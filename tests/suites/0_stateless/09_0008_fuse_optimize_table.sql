DROP DATABASE IF EXISTS db_09_0008;
CREATE DATABASE db_09_0008;
USE db_09_0008;

create table t(a uint64);

---------------------------

insert into t values (5);
insert into t values (6);
insert into t values (7);

optimize table t compact;

-- expects 4 history items, 3 of previous insertion, 1 for last compaction
select count(*) from fuse_history('db_09_0008', 't');

---------------------------

-- purge data and history
optimize table 't' purge;
-- expect 1 snapshot left
select count(*) from fuse_history('db_09_0008', 't');
-- check the data
select * from t order by a;
-- purge again, nothing happens
optimize table 't' purge;
select * from t order by a;

---------------------------

insert into t values (8);
insert into t values (9);
insert into t values (10);
-- purge and compact
optimize table 't' all;
-- expect 1 snapshot left
select count(*) from fuse_history('db_09_0008', 't');
select * from t order by a;

---------------------

-- optimize memory table should not panic/throws exception

create table m(a uint64) engine=Memory;
optimize table m;
optimize table m all;
optimize table m purge;
optimize table m compact;

---------------------

DROP TABLE t;
DROP TABLE m;
DROP DATABASE db_09_0008;
