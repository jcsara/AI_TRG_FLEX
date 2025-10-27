USE ROLE TRG_CORTEX_ROLE;
USE WAREHOUSE COMPUTE_WH;


SELECT SNOWFLAKE.CORTEX.CLASSIFY_TEXT(
    'The weather is sunny today.',
    ARRAY_CONSTRUCT('Weather', 'Mood', 'Activity')
) AS classification_result;

SELECT SNOWFLAKE.CORTEX.CLASSIFY_TEXT(
    'I am planning to go hiking this weekend.',
    ARRAY_CONSTRUCT('Activity', 'Weather', 'Planning')
) AS classification_result;

SELECT SNOWFLAKE.CORTEX.CLASSIFY_TEXT(
    'I feel tired after a long day of work.',
    ARRAY_CONSTRUCT('Emotion', 'Activity', 'Health')
) AS classification_result;

-----------

SELECT SNOWFLAKE.CORTEX.EXTRACT_ANSWER(
    'The weather is sunny today and perfect for outdoor activities.',
    'What is the weather like?'
) AS extracted_answer;

SELECT SNOWFLAKE.CORTEX.EXTRACT_ANSWER(
    'I am planning to go hiking this weekend in the mountains.',
    'What activity is planned?'
) AS extracted_answer;

SELECT SNOWFLAKE.CORTEX.EXTRACT_ANSWER(
    'I feel tired after a long day of work.',
    'How does the person feel?'
) AS extracted_answer;

-- Sentiment analysis examples
SELECT SNOWFLAKE.CORTEX.SENTIMENT(
    'The weather is sunny today and I feel great!'
) AS sentiment_result;

SELECT SNOWFLAKE.CORTEX.SENTIMENT(
    'I am frustrated with the delays in the project.'
) AS sentiment_result;

SELECT SNOWFLAKE.CORTEX.SENTIMENT(
    'This is the best day of my life!'
) AS sentiment_result;

--- Text summarization examples
SELECT SNOWFLAKE.CORTEX.SUMMARIZE(
    'The weather is sunny today and perfect for outdoor activities. I am planning to go hiking this weekend in the mountains. I feel tired after a long day of work.'
) AS summary_result;
SELECT SNOWFLAKE.CORTEX.SUMMARIZE(
    'I love programming in Python. It is a versatile language that can be used for web development, data analysis, artificial intelligence, and more. The community support is also fantastic.'
) AS summary_result;
SELECT SNOWFLAKE.CORTEX.SUMMARIZE(
    'The new product launch was a huge success. The team worked hard to ensure everything went smoothly, and the feedback from customers has been overwhelmingly positive.'
) AS summary_result;     

-- translation examples
SELECT SNOWFLAKE.CORTEX.TRANSLATE(
    'Hello, how are you?',
    'en', -- source language
    'es'  -- target language
) AS translation_result;
SELECT SNOWFLAKE.CORTEX.TRANSLATE(
    'Bonjour, comment ça va?',
    'fr', -- source language
    'en'  -- target language
) AS translation_result;
SELECT SNOWFLAKE.CORTEX.TRANSLATE(
    'Hola, ¿cómo estás?',
    'es', -- source language
    'fr'  -- target language
) AS translation_result;



--EMBED_TEXT_768 function examples
SELECT SNOWFLAKE.CORTEX.EMBED_TEXT_768('snowflake-arctic-embed-m-v1.5', 'hello world');

SELECT SNOWFLAKE.CORTEX.EMBED_TEXT_1024('snowflake-arctic-embed-l-v2.0', 'hello world');