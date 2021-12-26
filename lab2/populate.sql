-- At first we need to define locations, beer style and breweries types

INSERT INTO Locations
    (loc_id, country, state, city)
    VALUES
    (000, 'Ukraine', NULL, 'Kyiv'),
    (001, 'Ukraine', NULL, 'Chernigiv'),
    (002, 'Ukraine', NULL, 'Kharkiv'),
    (003, 'Ukraine', NULL, 'Mykolaiv'),
    (004, 'Ukraine', NULL, 'Lviv');

INSERT INTO Types
    (type_id, name)
    VALUES
    (0, 'Brewery'),
    (1, 'Store'),
    (2, 'Eatery'),
    (3, 'Beer-to-go'),
    (4, 'Bar'),
    (5, 'Homebrew');

INSERT INTO Styles
    (style_id, name)
    VALUES
    (000, 'lager'),
    (001, 'belgian ale'),
    (002, 'porter'),
    (003, 'bitter'),
    (004, 'weizenbier');

-- Now we'll create some Breweries and their beer

INSERT INTO Breweries
    (brewery_id, loc_id, name)
    VALUES
    (000, 0, 'ПАТ «Оболонь»'),
    (001, 1, 'Чернігівський пивкомбінат «Десна»'),
    (002, 4, '«Хмільний лев»'),
    (003, 3, 'Пивзавод «Янтар»'),
    (004, 4, 'ТзОВ ТВК "Перша приватна броварня «Для людей — як для себе!»');

INSERT INTO Beers
    (beer_id, brewery_id, style_id, name, abv)
    VALUES
    (000, 4, 0, 'Stare misto', 4.8),
    (001, 4, 0, 'Бочкове', 4.5),
    (002, 4, 0, 'Heineken', 5.0),
    (003, 0, 0, 'Жигулівське', 4.2),
    (004, 0, 0, 'Оболонь преміум', 5.0),
    (005, 0, 0, 'Zlata Praha Cerne', 4.1),
    (006, 2, 1, 'Belgian Ale', 6.4),
    (007, 2, 4, 'Пшеничне нефільтроване', 4.5),
    (008, 2, 0, 'SWEDBEER', 4.6),
    (009, 1, 0, 'Біла Ніч', 4.8),
    (010, 1, 0, 'Stella Artois Light', 4.0);

-- Also insert breweries types

INSERT INTO Breweries_Types
    (brewery_id, type_id)
    VALUES
    (000, 0),
    (001, 0),
    (002, 0),
    (003, 0),
    (004, 0),
    (002, 1),
    (002, 5);