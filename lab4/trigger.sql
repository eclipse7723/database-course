CREATE OR REPLACE FUNCTION where_ukraine()
    RETURNS TRIGGER AS
    $$
        BEGIN
          IF NEW.country != 'Ukraine'
              THEN
                  RAISE INFO 'Why you add "%", where Ukraine??', TRIM(NEW.country);
              END IF;
          RETURN NEW;
        END
    $$
    LANGUAGE 'plpgsql';


CREATE TRIGGER i_where_ukraine
    AFTER INSERT ON Locations
    FOR EACH ROW EXECUTE FUNCTION where_ukraine();