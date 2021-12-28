CREATE OR REPLACE FUNCTION who_made_this_beer(beer_name text)
    RETURNS text AS
    $$
        DECLARE
            potential_brewery text;
        BEGIN
            SELECT brewery
                INTO potential_brewery
                FROM all_beers
                WHERE beer LIKE CONCAT('%', beer_name, '%');
            RETURN potential_brewery;
        END;
    $$ LANGUAGE 'plpgsql';