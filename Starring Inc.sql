pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
test=> SELECT * FROM movies where url='inception';
test=> ALTER TABLE movies
test-> ADD lexemesStarring70 tsvector;
test=> UPDATE movies
test-> SET lexemesStarring70 = to_tsvector(Starring);
test=> SELECT url FROM movies
test-> WHERE lexemesStarring70 @@ to_tsquery('leonardo');
test=> UPDATE movies
test-> SET rank = ts_rank(lexemesStarring70,plainto_tsquery(
test(> (
test(> SELECT Starring FROM movies WHERE url='inception'
test(> )
test(> ));
test=> CREATE TABLE recommendationsBasedOnStarringField70 AS
test-> SELECT url, rank FROM movies WHERE rank < 0.99 ORDER BY rank DESC LIMIT 50;
test=> \copy (SELECT * FROM recommendationsBasedOnStarringField70) to '/home/pi/RSL/top50recommendations70.csv' WITH csv;
