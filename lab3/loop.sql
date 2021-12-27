INSERT INTO Breweries VALUES (500, NULL, 'test_brewery');
INSERT INTO Styles VALUES (500, 'test_style');

DO $$
    BEGIN
        FOR i IN 0..10
            LOOP
                INSERT INTO Beers
                (beer_id, brewery_id, style_id, name, abv)
                VALUES
                (500+i, 500, 500, CONCAT('test_beer_', i), ROUND((Random()+3.5)::numeric, 1));
            END LOOP;
END; $$