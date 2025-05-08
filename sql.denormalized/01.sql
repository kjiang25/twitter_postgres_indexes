SELECT count(*)
FROM tweets_jsonb
WHERE COALESCE(data->'entities'->'hashtags', '[]') @> '[{"text": "coronavirus"}]'
OR COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]') @> '[{"text": "coronavirus"}]';


