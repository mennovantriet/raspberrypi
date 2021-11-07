pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
test=> SELECT * FROM movies where url='pulp-fiction';
test=> ALTER TABLE movies
test-> ADD lexemesStarring30 tsvector;
test=> UPDATE movies
test-> SET lexemesStarring30 = to_tsvector(Starring);
test=> SELECT url FROM movies
test-> WHERE lexemesStarring30 @@ to_tsquery('leonardo');
test=> UPDATE movies
test-> SET rank = ts_rank(lexemesStarring30,plainto_tsquery(
test(> (
test(> SELECT Starring FROM movies WHERE url='pulp-fiction'
test(> )
test(> ));
test=> CREATE TABLE recommendationsBasedOnStarringField30 AS
test-> SELECT url, rank FROM movies WHERE rank < 0.99 ORDER BY rank DESC LIMIT 50;
test=> \copy (SELECT * FROM recommendationsBasedOnStarringField30) to '/home/pi/RSL/top50recommendations30.csv' WITH csv;
