
/**
The SNOWFLAKE.CORTEX.COMPLETE function is used to interact with Snowflake's 
integrated Large Language Model (LLM) capabilities. It allows you to pass a prompt 
to the LLM and receive a response, such as generating SQL queries or other text-based 
outputs.

SELECT SNOWFLAKE.CORTEX.COMPLETE(
    '<model_name>', -- Specify the LLM model to use
    '<prompt>'      -- Provide the text prompt for the LLM
);

 */

USE ROLE TRG_CORTEX_ROLE;
USE WAREHOUSE COMPUTE_WH;

-- translation
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', -- Specify the LLM model
    'Translate the following text from English to Tamil: "How are you today?"'
);
--Question Answering 
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', -- Specify the LLM model
    'What is the capital of France?'
);

SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', -- Specify the LLM model
    'who is ipl 2025 winner?' -- this is current event so we will not get any result
);
-- Summarization
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', -- Specify the LLM model
    'Summarize the following text: "Snowflake is a cloud-based data platform that provides data warehousing, data lakes, and data sharing capabilities. It enables businesses to store, analyze, and share data efficiently."'
);
-- Text Generation
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', 
    'Write a blog post about the benefits of cloud computing.'
);
-- code generation
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', 
    'Write a Python script to connect to a Snowflake database.'
);

SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', -- Specify the LLM model
    'Write a SQL query to find the top 10 customers by revenue from a sales table.'
);
-- text classification
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', 
    'Classify the following text: "This product is amazing!" into positive, negative, or neutral sentiment.'
);

--Entity extraction
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', 
    'Extract entities from the following text: "Apple Inc. is looking to acquire a startup in Silicon Valley."'
);

-- Text completion
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', 
    'Complete the following sentence: "The future of artificial intelligence is"'
);

-- Text similarity
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', 
    'Find
     the similarity between the following two sentences: "The cat is on the roof." and "A feline is perched on the top of a building."'
);

-- Text generation with specific instructions
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', 
    'Generate a short story about a robot learning to love.'
);
-- Text generation with specific style
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', 
    'Write a poem in the style of Shakespeare about the beauty of nature.'
);

SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic', 
    'Write a poem in the style of a Tamil poet about the beauty of nature and the changing seasons.'
);

SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'snowflake-arctic',
    'Extract the product name and overall sentiment (positive, negative, neutral) from the following review and return it as a JSON object with keys "product_name" and "sentiment": "I love my new iPhone 15, the camera is amazing!"'
);

