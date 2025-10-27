USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;

CREATE OR REPLACE TEMP TABLE SENTENCE_VECTORS (
  sentence VARCHAR,
  embedding VECTOR(FLOAT, 4)
);

-- Insert rows one by one (or via UNION ALL)
INSERT INTO SENTENCE_VECTORS
SELECT 'The cat sits on the mat.', ARRAY_CONSTRUCT(0.25,0.10,0.50,0.70)::VECTOR(FLOAT,4)
UNION ALL
SELECT 'A cat is sitting on the mat.', ARRAY_CONSTRUCT(0.26,0.12,0.48,0.69)::VECTOR(FLOAT,4)
UNION ALL
SELECT 'The dog plays in the park.', ARRAY_CONSTRUCT(0.80,0.60,0.15,0.10)::VECTOR(FLOAT,4);


SELECT 
  a.sentence AS base_sentence,
  b.sentence AS compare_sentence,
  VECTOR_COSINE_SIMILARITY(a.embedding, b.embedding) AS cosine_similarity
FROM SENTENCE_VECTORS a
JOIN SENTENCE_VECTORS b
  ON a.sentence != b.sentence
WHERE a.sentence = 'The cat sits on the mat.';

