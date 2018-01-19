#!/usr/bin/env

rm -f /tmp/s2sphere.zip
touch s2sphere/__init__.py
(cd s2sphere;
zip -r /tmp/s2sphere.zip s2sphere
zip -r /tmp/s2sphere.zip __init__.py
)

. ~/.aws/credentials

aws s3 cp /tmp/s2sphere.zip s3://nauto-dw/test/

psql -h redshift.test.nauto.systems -p 5439 --dbname=nauto -U etl <<EOF

CREATE OR REPLACE LIBRARY s2sphere LANGUAGE plpythonu FROM 's3://nauto-dw/test/s2sphere.zip' 
CREDENTIALS 'aws_access_key_id=$aws_access_key_id;aws_secret_access_key=$aws_secret_access_key';
EOF

psql -h redshift.test.nauto.systems -p 5439 --dbname=nauto -U etl -f functions.sql