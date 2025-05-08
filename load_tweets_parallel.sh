#!/bin/sh

files='/data/tweets/geoTwitter21-01-01.zip
/data/tweets/geoTwitter21-01-02.zip
/data/tweets/geoTwitter21-01-03.zip
/data/tweets/geoTwitter21-01-04.zip
/data/tweets/geoTwitter21-01-05.zip
/data/tweets/geoTwitter21-01-06.zip
/data/tweets/geoTwitter21-01-07.zip
/data/tweets/geoTwitter21-01-08.zip
/data/tweets/geoTwitter21-01-09.zip
/data/tweets/geoTwitter21-01-10.zip'


echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
# FIXME: copy your solution to the previous problem here
time for file in $files; do
    echo
    unzip -p "$file" | sed 's/\\u0000//g' | psql postgres://postgres:pass@localhost:10651/postgres -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
done

# NOTE:
# I have removed the pg_normalized code from this repo.
# The only difference between pg_normalized and pg_normalized_batch is how the data is loaded.
# Since pg_normalized_batch is faster,
# we will use that code to load the data.

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: copy your solution to the previous problem here

# time echo "${files}" | parallel 'python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:10652/ --inputs {}'
