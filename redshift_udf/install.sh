#!/usr/bin/env

rm -f /tmp/s2sphere.zip
rm -rf s2sphere_udf
mkdir s2sphere_udf
touch s2sphere_udf/__init__.py
cp -r ../s2sphere s2sphere_udf
zip -r /tmp/s2sphere_udf.zip s2sphere_udf

. ~/.aws/credentials

aws s3 cp /tmp/s2sphere_udf.zip s3://nauto-dw/test/

psql -h redshift.test.nauto.systems -p 5439 --dbname=nauto -U etl <<EOF

CREATE OR REPLACE LIBRARY s2sphere LANGUAGE plpythonu FROM 's3://nauto-dw/test/s2sphere_udf.zip' 
CREDENTIALS 'aws_access_key_id=$aws_access_key_id;aws_secret_access_key=$aws_secret_access_key';
EOF