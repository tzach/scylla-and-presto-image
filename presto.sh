#!/bin/bash

# Presto launcher: update the connector address to local host ip
IP=$(hostname -i)
sed -i "s/cassandra.contact-points=.*/cassandra.contact-points=$IP/" /presto-server/etc/catalog/cassandra.properties

/presto-server/bin/launcher run
