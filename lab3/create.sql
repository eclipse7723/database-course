-- ������� ����� ����, �������, ����, ������ �� ���� ���������
CREATE OR REPLACE VIEW all_beers AS
	SELECT TRIM(b.name) AS "Beer",
		   TRIM(s.name) AS "Style",
		   TRIM(bb.name) AS "Brewery",
		   b.abv AS "Alcohol by volume",
		   TRIM(loc.country) AS "Country",
		   TRIM(loc.city) AS "City"
		FROM Beers AS b
			LEFT JOIN Breweries AS bb	ON b.brewery_id = bb.brewery_id
			LEFT JOIN Locations AS loc	ON bb.loc_id = loc.loc_id
			LEFT JOIN Styles AS s	ON b.style_id = s.style_id;

-- 3� - ����������� ������ ����
CREATE OR REPLACE VIEW abv_count AS
	SELECT COUNT(b.abv) AS "Count", b.abv AS "Alcohol by volume"
	FROM Beers AS b GROUP BY b.abv ORDER BY COUNT(b.abv) DESC;

-- 3� - ������� ��������� ���� � ������� ���
CREATE OR REPLACE VIEW city_count AS
	SELECT COUNT(loc.city) as "Count", TRIM(loc.city) as "City"
		FROM Beers as b
			LEFT JOIN Breweries AS bb	ON b.brewery_id = bb.brewery_id
			LEFT JOIN Locations AS loc	ON bb.loc_id = loc.loc_id
		GROUP BY loc.city ORDER BY COUNT(loc.city) DESC;

-- 3�. ��������� ������ ���� �� ����� (�����)
CREATE OR REPLACE VIEW avg_style_abv AS
	SELECT COUNT(b.abv) AS "Count",
		   ROUND(AVG(b.abv)::numeric, 2) AS "Average alcohol by volume",
		   TRIM(s.name) AS "Style"
		FROM Beers AS b LEFT JOIN Styles AS s	ON b.style_id = s.style_id
		GROUP BY s.style_id ORDER BY COUNT(b.abv) DESC;