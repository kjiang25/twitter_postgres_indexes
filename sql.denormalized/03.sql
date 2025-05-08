SELECT
    data->>'lang' AS lang,
    COUNT(DISTINCT data->>'id') AS count
FROM tweets_jsonb
WHERE
    COALESCE(data->'entities'->'hashtags', '[]') @> '[{"text": "coronavirus"}]'
    OR COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]') @> '[{"text": "coronavirus"}]'
GROUP BY data->>'lang'
ORDER BY count DESC, lang;

