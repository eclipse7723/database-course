CREATE PROCEDURE beers_by_style (name text) AS
$$
    DECLARE
        record record;
    BEGIN
        FOR record IN
            SELECT DISTINCT ab.style, COUNT(ab.beer) as "count"
            FROM all_beers AS ab
            WHERE ab.style LIKE CONCAT('%', name, '%')
            GROUP BY ab.style
        LOOP
            RAISE INFO 'Found style "%" (% records)', record.style, record.count;
        END LOOP;
    END;
$$ LANGUAGE 'plpgsql';


/* Use example:
   CALL beers_by_style('Lager')

   Output from pgAdmin:
    ИНФОРМАЦИЯ:  Found style "American Adjunct Lager" (1939 records)
    ИНФОРМАЦИЯ:  Found style "American Amber / Red Lager" (1172 records)
    ИНФОРМАЦИЯ:  Found style "American Lager" (3741 records)
    ИНФОРМАЦИЯ:  Found style "American Light Lager" (1333 records)
    ИНФОРМАЦИЯ:  Found style "European Dark Lager" (954 records)
    ИНФОРМАЦИЯ:  Found style "European Pale Lager" (3715 records)
    ИНФОРМАЦИЯ:  Found style "European Strong Lager" (629 records)
    ИНФОРМАЦИЯ:  Found style "Japanese Rice Lager" (171 records)
    ИНФОРМАЦИЯ:  Found style "Munich Dunkel Lager" (1412 records)
    ИНФОРМАЦИЯ:  Found style "Vienna Lager" (1567 records)
    CALL

    Query returned successfully in 159 msec.
 */