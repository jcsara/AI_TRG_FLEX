USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;


--To generate a single response:

SELECT AI_COMPLETE('snowflake-arctic', 'What are large language models?');

SELECT AI_COMPLETE(
    'mistral-large',
    CONCAT('Critique this review in bullet points: <review>', content, '</review>')
) FROM reviews LIMIT 2;


-- Model parameters

/**
temperature: A value from 0 to 1 (inclusive) that controls the randomness of the output of the language model. A higher temperature (for example, 0.7) results in more diverse and random output, while a lower temperature (such as 0.2) makes the output more deterministic and focused.

Default: 0

top_p: A value from 0 to 1 (inclusive) that controls the randomness and diversity of the language model, generally used as an alternative to temperature. The difference is that top_p restricts the set of possible tokens that the model outputs, while temperature influences which tokens are chosen at each step.

Default: 0

max_tokens: Sets the maximum number of output tokens in the response. Small values can result in truncated responses.

Default: 4096 Maximum allowed value: 8192

guardrails: Filters potentially unsafe and harmful responses from a language model using Cortex Guard. Either TRUE or FALSE.

Default: FALSE
**/

SELECT SNOWFLAKE.CORTEX.AI_COMPLETE(
    'mistral-large',
    'Explain the plot of Inception in 3 sentences',
    OBJECT_CONSTRUCT(
        'temperature', 0.6,
        'top_p', 0.9,
        'max_tokens', 500,
        'guardrails', TRUE
    )
) AS RESPONSE;

-- show details = true

SELECT AI_COMPLETE(
    model => 'mistral-large',
    prompt => 'how does a snowflake get its unique pattern?',
    model_parameters => {
        'temperature': 0.7,
        'max_tokens': 10
    },
    show_details => true
);

SELECT AI_COMPLETE(
    model => 'mistral-large',
    prompt => 'Extract structured data from this customer interaction note: Customer Sarah Jones complained about the mobile app crashing during checkout. She tried to purchase 3 items: a red XL jacket ($89.99), blue running shoes ($129.50), and a fitness tracker ($199.00). The app crashed after she entered her shipping address at 123 Main St, Portland OR, 97201. She has been a premium member since January 2024.',
    model_parameters => {
        'temperature': 0,
        'max_tokens': 4096
    },
    response_format => {
            'type':'json',
            'schema':{'type' : 'object','properties' : {'note':{'type':'object','properties':
            {'items_count' : {'type' : 'number'},'price': {'type':'array','items':{'type':'string'}}, 'address': {'type':'string'}, 'member_date': {'type':'string'}},'required':['items_count','price' ,'address', 'member_date']}}}
    }
);


----Single File---



SELECT AI_COMPLETE('claude-3-5-sonnet',
'Which country  observed the largest inflation change in 2024 compared to 2023?',
TO_FILE('@AISQL_FILES', 'inflation-forecast.png'));

SELECT AI_COMPLETE('claude-3-5-sonnet',
'Extract the kitchen appliances identified in this image. Respond in JSON only with the identified appliances.',
TO_FILE('@AISQL_FILES', 'kitchen.png'));


    ------- prompt---

SELECT AI_COMPLETE('claude-3-5-sonnet',
PROMPT('Are both image {0} and image {1} pictures of cats?',
TO_FILE('@AISQL_FILES', 'sleepingcat.png'), TO_FILE('@AISQL_FILES', 'jumpingcat.png'))) AS image_classification;



SELECT * FROM image_table;

SELECT AI_COMPLETE('claude-3-5-sonnet',
PROMPT('Classify the input image {0} in no more than 2 words. Respond in JSON', img_file)) AS image_classification
FROM image_table;

