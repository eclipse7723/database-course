-- вивести назву пива, броварні, сорт, міцність та місто виробника
CREATE OR REPLACE VIEW all_beers AS
	SELECT TRIM(b.name) AS "beer",
		   TRIM(s.name) AS "style",
		   TRIM(bb.name) AS "brewery",
		   b.abv AS "alcohol by volume",
		   TRIM(loc.country) AS "country",
		   TRIM(loc.city) AS "city"
		FROM Beers AS b
			LEFT JOIN Breweries AS bb	ON b.brewery_id = bb.brewery_id
			LEFT JOIN Locations AS loc	ON bb.loc_id = loc.loc_id
			LEFT JOIN Styles AS s	ON b.style_id = s.style_id;

-- 3а - розподілення міцності пива
CREATE OR REPLACE VIEW abv_count AS
	SELECT COUNT(b.abv) AS "count", b.abv AS "alcohol by volume"
	FROM Beers AS b GROUP BY b.abv ORDER BY COUNT(b.abv) DESC;

-- 3б - кількість внесеного пива в кожному місті
CREATE OR REPLACE VIEW city_count AS
	SELECT COUNT(loc.city) as "count", TRIM(loc.city) as "city"
		FROM Beers as b
			LEFT JOIN Breweries AS bb	ON b.brewery_id = bb.brewery_id
			LEFT JOIN Locations AS loc	ON bb.loc_id = loc.loc_id
		GROUP BY loc.city ORDER BY COUNT(loc.city) DESC;

-- 3в. залежність міцності пива від сорту (стиль)
CREATE OR REPLACE VIEW avg_style_abv AS
	SELECT COUNT(b.abv) AS "count",
		   ROUND(AVG(b.abv)::numeric, 2) AS "average alcohol by volume",
		   TRIM(s.name) AS "style"
		FROM Beers AS b LEFT JOIN Styles AS s	ON b.style_id = s.style_id
		GROUP BY s.style_id ORDER BY COUNT(b.abv) DESC;