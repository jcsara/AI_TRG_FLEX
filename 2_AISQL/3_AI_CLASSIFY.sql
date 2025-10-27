USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;



--AI_CLASSIFY: Text¶
--The following example classifies the prompt into one of two categories, travel or cooking:
SELECT AI_CLASSIFY('One day I will see the world', ['travel', 'cooking']);

--The following example uses multi-label classification:
SELECT AI_CLASSIFY(
  'One day I will see the world and learn to cook my favorite dishes',
  ['travel', 'cooking', 'reading', 'driving'],
  {'output_mode': 'multi'}
);

-- few Shots examples

SELECT AI_CLASSIFY(
  'One day I will see the world and learn to cook my favorite dishes',
  [
    {'label': 'travel', 'description': 'content related to traveling'},
    {'label': 'cooking'},
    {'label': 'reading'},
    {'label': 'driving'}
  ],
  {
    'task_description': 'Determine topics related to the given text',
    'output_mode': 'multi',
    'examples': [
      {
        'input': 'i love traveling with a good book',
        'labels': ['travel', 'reading'],
        'explanation': 'the text mentions traveling and a good book which relates to reading'
      }
    ]
  });

-- text_classification_table

CREATE OR REPLACE TEMPORARY TABLE text_classification_table AS
SELECT 'France' AS input, ['North America', 'Europe', 'Asia'] AS classes
UNION ALL
SELECT 'Singapore', ['North America', 'Europe', 'Asia']
UNION ALL
SELECT 'one day I will see the world', ['travel', 'cooking', 'dancing']
UNION ALL
SELECT 'my lobster bisque is second to none', ['travel', 'cooking', 'dancing'];

SELECT input,
    classes,
    AI_CLASSIFY(input, classes):labels AS classification
FROM text_classification_table;



WITH food_pictures AS (
  SELECT
      TO_FILE(file_url) AS img
  FROM DIRECTORY(@FOOD_IMAGES)
)
SELECT
*,
AI_CLASSIFY(img, ['dessert', 'drink', 'main dish', 'side dish']):labels AS classification
FROM food_pictures;

--Using a prompt object constructed by PROMPT():
WITH food_pictures AS (
  SELECT
      TO_FILE(file_url) AS img
  FROM DIRECTORY(@food_images)
)
SELECT
*,
AI_CLASSIFY(PROMPT('Please help me classify the food within this image {0}', img),
  ['dessert', 'drink', 'main dish', 'side dish']):labels AS classification
FROM food_pictures;