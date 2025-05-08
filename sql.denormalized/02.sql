SELECT tag, count(*) AS count
FROM (
    SELECT DISTINCT
        data->>'id' AS id_tweets,
        '#' || (jsonb_array_elements(
            COALESCE(data->'entities'->'hashtags', '[]') ||
            COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]')
        )->>'text') AS tag
    FROM tweets_jsonb
    WHERE
        COALESCE(data->'entities'->'hashtags', '[]') @> '[{"text": "coronavirus"}]'
        OR COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]') @> '[{"text": "coronavirus"}]'
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;

