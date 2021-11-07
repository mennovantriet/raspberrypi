pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
test=> SELECT * FROM movies where url='pulp-fiction';
test=> ALTER TABLE movies
test-> ADD lexemesSummary40 tsvector;
test=> UPDATE movies
test-> SET lexemesSummary40 = to_tsvector(Summary);
test=> SELECT url FROM movies
test-> WHERE lexemesSummary40 @@ to_tsquery('crime');

test=> UPDATE movies
test-> SET rank = ts_rank(lexemesSummary40,plainto_tsquery(
test(> (
test(> SELECT Summary FROM movies WHERE url='pulp-fiction'
test(> )
test(> ));
test=> CREATE TABLE recommendationsBasedOnSummaryField40 AS
test-> SELECT url, rank FROM movies WHERE rank > 0.99 ORDER BY rank DESC LIMIT 50;
test=> \copy (SELECT * FROM recommendationsBasedOnSummaryField40) to '/home/pi/RSL/top50recommendations40.csv' WITH csv;
