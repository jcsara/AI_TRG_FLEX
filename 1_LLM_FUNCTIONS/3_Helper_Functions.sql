USE ROLE TRG_CORTEX_ROLE;
USE WAREHOUSE COMPUTE_WH;
USE SCHEMA TRAINING_DB.PUBLIC;


-- Count tokens for a simple sentence using the Llama 3 8B model's tokenization
SELECT SNOWFLAKE.CORTEX.COUNT_TOKENS('llama3-8b', 'Hello, Snowflake! How are you today?') AS TOKEN_COUNT;

-- Count tokens for a longer text, demonstrating how it applies to potential LLM prompts
SELECT SNOWFLAKE.CORTEX.COUNT_TOKENS('mixtral-8x7b',
    'Please summarize the following document, focusing on key financial figures and market trends. ' ||
    'The document details the Q1 2024 earnings report, highlighting a 15% increase in revenue ' ||
    'driven by strong growth in the cloud computing division. Operating expenses rose by 8%, ' ||
    'and net profit increased by 10% year-over-year. The CEO expressed optimism about future ' ||
    'market expansion in Asia-Pacific. However, supply chain disruptions posed a challenge, ' ||
    'and the company anticipates these issues may persist into Q2. Investors reacted positively ' ||
    'to the earnings call, with stock prices showing a 5% gain after the announcement.'
) AS LONG_TEXT_TOKEN_COUNT;

-- TRY_COMPLETE

-- Example 1: Basic usage with a prompt that might occasionally fail (e.g., due to a temporary service issue)
SELECT SNOWFLAKE.CORTEX.TRY_COMPLETE('mixtral-8x7b', 'What is the capital of France?') AS LLM_RESPONSE;



-- In this scenario, if any `article_text` is too long, malformed, or causes an LLM error,
-- the SUMMARY column for that row would be NULL, and the query would complete without interruption.


SELECT SNOWFLAKE.CORTEX.SPLIT_TEXT_RECURSIVE_CHARACTER (
   'hello world are you here',
   'none',
   15,
   10
);

-- Create sample markdown data table


CREATE OR REPLACE TABLE sample_documents (
   doc_id INT AUTOINCREMENT, -- Monotonically increasing integer
   document STRING
);

-- Insert sample data
INSERT INTO sample_documents (document)
VALUES
   ('### Heading 1\\nThis is a sample markdown document. It contains a list:\\n- Item 1\\n- Item 2\\n- Item 3\\n'),
   ('## Subheading\\nThis markdown contains a link [example](http://example.com) and some \**bold*\* text.'),
   ('### Heading 2\\nHere is a code snippet:\\n```\\ncode_block_here()\\n```\\nAnd some more regular text.'),
   ('## Another Subheading\\nMarkdown example with \_italic\_ text and a [second link](http://example.com).'),
   ('### Heading 3\\nText with an ordered list:\\n1. First item\\n2. Second item\\n3. Third item\\nMore text follows here.');

-- split text
SELECT
   doc_id,
   c.value
FROM
   sample_documents,
   LATERAL FLATTEN( input => SNOWFLAKE.CORTEX.SPLIT_TEXT_RECURSIVE_CHARACTER (
      document,
      'markdown',
      25,
      10
   )) c;

  