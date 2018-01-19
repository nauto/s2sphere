select f_s2_to_lon('808fa214f5477140');
select f_s2_to_lat('808fa214f5477140');
select f_lat_lon_to_s2(37.5040774225365, -122.245451544305);
select f_s2_distance('808fa214f5477140','808fa214f5477115');
select f_lat_lon_distance(37.5040774225365, -122.245451544305, 37.504, -122.254);
-- select * from svl_udf_log order by created desc limit 1;