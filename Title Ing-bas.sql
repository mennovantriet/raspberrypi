pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
psql (11.12 (Raspbian 11.12-0+deb10u1))
Type "help" for help.
test=> SELECT * FROM movies where url=' inglourious-basterds';
test=> ALTER TABLE movies
test-> ADD lexemesTitle tsvector;
test=> UPDATE movies
test-> SET lexemesTitle = to_tsvector(Title);
test=> SELECT url FROM movies
test-> WHERE lexemesTitle @@ to_tsquery('bastards');
test=> UPDATE movies
test-> SET rank = ts_rank(lexemesTitle,plainto_tsquery(
test(> (
test(> SELECT Title FROM movies WHERE url='inglourious-basterds'
test(> )
test(> ));

test=> CREATE TABLE recommendationsBasedOnTitleField2 AS
test-> SELECT url, rank FROM movies WHERE rank > 0.99 ORDER BY rank DESC LIMIT 50;
test=> \copy (SELECT * FROM recommendationsBasedOnTitleField2) to '/home/pi/RSL/top50recommendations5.csv' WITH csv;
