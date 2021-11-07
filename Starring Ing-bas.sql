pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
test=> SELECT * FROM movies where url=' inglourious-basterds';
test=> ALTER TABLE movies
test-> ADD lexemesStarring2 tsvector;
test=> UPDATE movies
test-> SET lexemesStarring2 = to_tsvector(Starring);
test=> SELECT url FROM movies
test-> WHERE lexemesStarring @@ to_tsquery('brad');
test=> UPDATE movies
test-> SET rank = ts_rank(lexemesStarring,plainto_tsquery(
test(> (
test(> SELECT Starring FROM movies WHERE url='inglourious-basterds'
test(> )
test(> ));
test=> CREATE TABLE recommendationsBasedOnStarringField5 AS
test-> SELECT url, rank FROM movies WHERE rank < 0.99 ORDER BY rank DESC LIMIT 50;
test=> \copy (SELECT * FROM recommendationsBasedOnStarringField5) to '/home/pi/RSL/top50recommendations6.csv' WITH csv;
