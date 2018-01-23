select f_s2_to_lon('808fa21485008dbf');
select f_s2_to_lat('808fa21485008dbf');
select f_s2_to_lon('808fa214c2cf1093');
select f_s2_to_lat('808fa214c2cf1093');
select f_lat_lon_to_s2(37.505, -122.245);
select f_lat_lon_to_s2(37.504, -122.244);
select f_s2_distance('808fa21485008dbf','808fa214c2cf1093');
select f_lat_lon_distance(37.505, -122.255, 37.504, -122.254);
-- select * from svl_udf_log order by created desc limit 1;
