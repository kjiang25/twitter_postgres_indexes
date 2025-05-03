/*
 * Change settings
 */

SET max_parallel_maintenance_workers TO 64;
SET maintenance_work_mem TO '16GB';
ALTER TABLE tweet_tags SET (parallel_workers = 64);
ALTER TABLE tweets SET (parallel_workers = 64);

/*
 * Create indexes
 */

CREATE INDEX ON tweet_tags(tag text_pattern_ops, id_tweets);
CREATE INDEX ON tweets(lang, id_tweets);
CREATE INDEX ON tweets(id_tweets, lang);
CREATE INDEX ON tweets USING gin(to_tsvector('english', text));

