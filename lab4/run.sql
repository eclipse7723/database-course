-- procedure test
CALL beers_by_style('Lager');
/*   Output:
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

-- function test
SELECT who_made_this_beer('Russian Kvass');
/*   Output:
     "Beavertown Brewery"
 */

-- trigger test
INSERT INTO Locations VALUES (-1, 'test', NULL, 'test');
/* Output:
    ИНФОРМАЦИЯ:  Why you add "test", where Ukraine??
    INSERT 0 1

    Query returned successfully in 80 msec.
 */