pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
test=> SELECT * FROM movies where url='inception';
test=> ALTER TABLE movies
test-> ADD lexemesSummary80 tsvector;
test=> UPDATE movies
test-> SET lexemesSummary80 = to_tsvector(Summary);
test=> SELECT url FROM movies
test-> WHERE lexemesSummary80 @@ to_tsquery('action');

test=> UPDATE movies
test-> SET rank = ts_rank(lexemesSummary80,plainto_tsquery(
test(> (
test(> SELECT Summary FROM movies WHERE url='inception'
test(> )
test(> ));
test=> CREATE TABLE recommendationsBasedOnSummaryField80 AS
test-> SELECT url, rank FROM movies WHERE rank > 0.99 ORDER BY rank DESC LIMIT 50;
test=> \copy (SELECT * FROM recommendationsBasedOnSummaryField80) to '/home/pi/RSL/top50recommendations80.csv' WITH csv;
