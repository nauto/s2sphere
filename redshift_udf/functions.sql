

--CREATE OR REPLACE FUNCTION s2_distance (cell_id_1 BIGINT, cell_id_2 BIGINT) RETURNS float IMMUTABLE as $$
--    def distance(x1, y1, x2, y2):
--        import s2sphere
--        return math.sqrt((y2 - y1) ** 2 + (x2 - x1) ** 2)
-- 
--    return distance(x1, y1, x2, y2)
--$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION s2_to_lat (s2_cell_id BIGINT) RETURNS float IMMUTABLE as $$
    # Convert lat/lon from s2_cell_id
    def s2_lat(cell_id):
        import s2sphere    
        cell = s2sphere.CellId.from_token(cell_id)
        ll = cell.to_lat_lng()
        lat = ll.lat().degrees
        return lat

    return s2_lat(s2_cell_id)
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION s2_to_lon (s2_cell_id BIGINT) RETURNS float IMMUTABLE as $$
    # Convert lat/lon from s2_cell_id
    def s2_lat(cell_id):
        import s2sphere    
        cell = s2sphere.CellId.from_token(cell_id)
        ll = cell.to_lat_lng()
        lon = ll.lon().degrees
        return lon

    return s2_lat(s2_cell_id)
$$ LANGUAGE plpythonu;
