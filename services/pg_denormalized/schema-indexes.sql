SET max_parallel_maintenance_workers TO 64;
SET maintenance_work_mem TO '1GB';
SELECT reloptions FROM pg_class WHERE relname = 'tweets_jsonb';
-- ALTER TABLE tweets_jsonb SET (parallel_workers = 64);

CREATE INDEX ON tweets_jsonb
USING gin (
  COALESCE(data->'entities'->'hashtags', '[]'::jsonb)
);

CREATE INDEX ON tweets_jsonb
USING gin (
  COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]'::jsonb)
);

CREATE INDEX tweets_jsonb_expr_idx
ON tweets_jsonb
USING btree ((data->>'lang'));

CREATE INDEX ON tweets_jsonb
USING gin (
  to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text'))
);

