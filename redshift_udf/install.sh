#!/usr/bin/env

rm -f /tmp/s2sphere.zip
touch s2sphere/__init__.py
(cd s2sphere;
zip -r /tmp/s2sphere.zip s2sphere
zip -r /tmp/s2sphere.zip __init__.py
)

. ~/.aws/credentials

aws s3 cp /tmp/s2sphere.zip s3://nauto-dw/test/

P=10.210.250.18
T=redshift.test.nauto.systems
S=10.203.13.143
IP=$S
psql -h $IP -p 5439 --dbname=nauto -U etl <<EOF

CREATE OR REPLACE LIBRARY s2sphere LANGUAGE plpythonu FROM 's3://nauto-dw/test/s2sphere.zip' 
CREDENTIALS 'aws_access_key_id=$aws_access_key_id;aws_secret_access_key=$aws_secret_access_key';
EOF

psql -h $IP -p 5439 --dbname=nauto -U etl -f functions.sql
psql -h $IP -p 5439 --dbname=nauto -U etl -f tests.sql
