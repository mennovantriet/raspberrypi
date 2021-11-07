pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
psql (11.12 (Raspbian 11.12-0+deb10u1))
Type "help" for help.

test=> CREATE TABLE movies (
test(> url text,
test(> title text,
test(> ReleaseDate text,
test(> Distributor text,
test(> Starring text,
test(> Summary text,
test(> Director text,
test(> Genre text,
test(> Rating text,
test(> Runtime text,
test(> Userscore text,S
test(> Metascore text,
test(> scoreCounts text
test(> );
test=> CREATE TABLE movies (url text, title text, ReleaseDate text, Distributor text, Starring text, Summary text, Director text, Genre text, Rating text, Runtime text, Userscore text, Metascore text, scoreCounts text );
test=> \copy movies FROM '/home/pi/RSL/moviesFromMetacritic.csv' delimiter ';' csv header;
test=> SELECT * FROM movies where url=' inglourious-basterds';
test=> ALTER TABLE movies
test-> ADD lexemesSummary tsvector;
test=> UPDATE movies
test-> SET lexemesSummary = to_tsvector(Summary);
test=> SELECT url FROM movies
test-> WHERE lexemesSummary @@ to_tsquery('war');
test=> ALTER TABLE movies
test-> ADD rank float4;
test=> UPDATE movies
test-> SET rank = ts_rank(lexemesSummary,plainto_tsquery(
test(> (
test(> SELECT Summary FROM movies WHERE url='inglourious-basterds'
test(> )
test(> ));
test=> CREATE TABLE recommendationsBasedOnSummaryField2 AS
test-> SELECT url, rank FROM movies WHERE rank > 0.99 ORDER BY rank DESC LIMIT 50;
test=> \copy (SELECT * FROM recommendationsBasedOnSummaryField2) to '/home/pi/RSL/top50recommendations4.csv' WITH csv;


