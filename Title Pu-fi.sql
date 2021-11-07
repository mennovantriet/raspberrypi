pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
test=> SELECT * FROM movies where url='pulp-fiction';
test=> ALTER TABLE movies
test-> ADD lexemesTitle60 tsvector;
test=> UPDATE movies
test-> SET lexemesTitle60 = to_tsvector(Title);
test=> SELECT url FROM movies
test-> WHERE lexemesTitle60 @@ to_tsquery('fiction');
test=> UPDATE movies
test-> SET rank = ts_rank(lexemesTitle60,plainto_tsquery(
test(> (
test(> SELECT Title FROM movies WHERE url='pulp-fiction'
test(> )
test(> ));

test=> CREATE TABLE recommendationsBasedOnTitleField60 AS
test-> SELECT url, rank FROM movies WHERE rank < 0.99 ORDER BY rank DESC LIMIT 50;
test=> \copy (SELECT * FROM recommendationsBasedOnTitleField60) to '/home/pi/RSL/top50recommendations60.csv' WITH csv;
