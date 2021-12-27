CREATE OR REPLACE FUNCTION get_random_abv()
    RETURNS double precision AS
    $$
        DECLARE
        BEGIN
           RETURN ROUND((Random()+3.5)::numeric, 1);
        END;
    $$ LANGUAGE 'plpgsql';