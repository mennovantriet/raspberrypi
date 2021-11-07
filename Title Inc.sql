pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
test=> SELECT * FROM movies where url='inception';
test=> ALTER TABLE movies
test-> ADD lexemesTitle90 tsvector;
test=> UPDATE movies
test-> SET lexemesTitle90 = to_tsvector(Title);
test=> SELECT url FROM movies
test-> WHERE lexemesTitle90 @@ to_tsquery('fight');
test=> UPDATE movies
test-> SET rank = ts_rank(lexemesTitle90,plainto_tsquery(
test(> (
test(> SELECT Title FROM movies WHERE url='inception'
test(> )
test(> ));

test=> CREATE TABLE recommendationsBasedOnTitleField90 AS
test-> SELECT url, rank FROM movies WHERE rank < 0.99 ORDER BY rank DESC LIMIT 50;
test=> \copy (SELECT * FROM recommendationsBasedOnTitleField90) to '/home/pi/RSL/top50recommendations90.csv' WITH csv;
