

CREATE OR REPLACE FUNCTION f_s2_to_lat (s2_cell_id VARCHAR(64)) RETURNS float IMMUTABLE as $$
    # Convert lat/lon from s2_cell_id
    def s2_lat(cell_id):
        import s2sphere    
        cell = s2sphere.CellId.from_token(cell_id)
        ll = cell.to_lat_lng()
        lat = ll.lat().degrees
        return lat

    return s2_lat(s2_cell_id)
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION f_s2_to_lon (s2_cell_id VARCHAR(64)) RETURNS float IMMUTABLE as $$
    # Convert lat/lon from s2_cell_id
    def s2_lon(cell_id):
        import s2sphere   
        cell = s2sphere.CellId.from_token(cell_id)
        ll = cell.to_lat_lng()
        lon = ll.lng().degrees
        return lon

    return s2_lon(s2_cell_id)
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION f_lat_lon_to_s2 (lat float, lon float) RETURNS varchar(64) IMMUTABLE as $$
    # Convert lat/lon to s2_cell_id
    def lat_lon_s2(lat, lon):
        import s2sphere   
        latlng = s2sphere.LatLng.from_degrees(lat, lon)
        cell = s2sphere.CellId.from_lat_lng(latlng)
        return cell.to_token()

    return lat_lon_s2(lat, lon)
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION f_s2_distance (s2_cell_id1 VARCHAR(64), s2_cell_id2 VARCHAR(64)) RETURNS float IMMUTABLE as $$
    # Find distance in degrees between two s2 cells. Meters?
    def s2_dist(cell_id1, cell_id2):
        import s2sphere   
        cell1 = s2sphere.CellId.from_token(cell_id1)
        cell2 = s2sphere.CellId.from_token(cell_id2)
        dist = cell1.to_lat_lng().get_distance(cell2.to_lat_lng()).degrees
        return dist

    return s2_dist(s2_cell_id1, s2_cell_id2)
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION f_lat_lon_distance (lat1 float, lon1 float, lat2 float, lon2 float) RETURNS float IMMUTABLE as $$
    # Find distance in degrees between two lat/lon values.
    def s2_lon(lat1, lon1, lat2, lon2):
        import s2sphere   
        ll1 = s2sphere.LatLng.from_degrees(lat1, lon1)
        ll2 = s2sphere.LatLng.from_degrees(lat2, lon2)
        dist = ll1.get_distance(ll2).degrees
        return dist

    return s2_lon(lat1, lon1, lat2, lon2)
$$ LANGUAGE plpythonu;


