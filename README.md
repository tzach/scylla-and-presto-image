This is project build a Scylla+Presto standalone Docker image base on [Scylla Docker image](https://hub.docker.com/r/scylladb/scylla/).

### Usage

Run
```
sudo docker run --name some-scylla-presto -d tzachl/scylla-and-presto-image
```

Run CQLsh
```
$ sudo docker exec -it some-scylla-presto cqlsh

cqlsh> CREATE KEYSPACE mykeyspace WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
use mykeyspace ;
CREATE TABLE users (user_id int PRIMARY KEY, fname text, lname text);
insert into users (user_id , fname, lname) values (1, 'tzach', 'livyatan');
insert into users (user_id , fname, lname) values (2, 'dor', 'laor');
insert into users (user_id , fname, lname) values (3, 'shlomi', 'laor');
insert into users (user_id , fname, lname) values (4, 'shlomi', 'livne');
insert into users (user_id , fname, lname) values (6, 'avi', 'kivity');
```

Run Presto CLI
```
$ sudo docker exec -it some-scylla-presto ./presto --server localhost:8080 --catalog cassandra --schema default

presto:default> SELECT * FROM cassandra.mykeyspace.users where user_id >= 2 and user_id <= 3;
 user_id | fname  | lname
---------+--------+-------
       2 | dor    | laor
       3 | shlomi | laor
(2 rows)

Query 20160828_182437_00000_vaibb, FINISHED, 1 node
Splits: 2 total, 2 done (100.00%)
0:06 [2 rows, 2B] [0 rows/s, 0B/s]

```

See [Scylla Docker Image how to](https://hub.docker.com/r/scylladb/scylla/) for more Scyla options.
