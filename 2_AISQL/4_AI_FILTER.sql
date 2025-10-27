/**

https://docs.snowflake.com/en/sql-reference/functions/ai_filter

AI_FILTER - Classifies free-form prompt inputs into a boolean. Currently supports both text and image filtering.

Syntax
------

AI_FILTER( <input> )

--Applying AI_FILTER to single image:

AI_FILTER( <predicate> , <input> )

-- Applying AI_FILTER to multiple columns with both text and images, leveraging the PROMPT:

AI_FILTER( PROMPT('<template_string>',  <col_1>, … ) )

**/


USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;




SELECT AI_FILTER('Is Canada in North America?');

--1
WITH reviews AS (
            SELECT 'Wow... Loved this place.' AS review
            UNION ALL 
            SELECT 'The pizza is  good.'
)
SELECT * FROM reviews
WHERE AI_FILTER(CONCAT('The reviewer is happy: ', review));


-- 2
WITH reviews AS (
SELECT 'Wow... Loved this place.' AS review
UNION ALL 
SELECT 'The pizza is not good.'
)
SELECT * FROM reviews
WHERE AI_FILTER(PROMPT('The reviewer enjoyed the restaurant: {0}', review));


--3
WITH country AS (
            SELECT 'Switzerland' AS country,
            UNION ALL 
            SELECT 'Korea'  
),
region AS (
            SELECT 'Asia' AS region,
            UNION ALL 
            SELECT 'Europe'
)
SELECT country,
      region,
      AI_FILTER(PROMPT('{0} is in {1}', country, region)) AS result
FROM country CROSS JOIN region ;

--AI_FILTER with JOIN


-- Create CUSTOMERS table
CREATE OR REPLACE TEMPORARY TABLE CUSTOMERS (
  CUSTOMER_ID INT,
  CUSTOMER_NAME STRING,
  PRODUCT_ID INT,
  FEEDBACK STRING
);

INSERT INTO CUSTOMERS VALUES
  (1, 'Alice', 101, 'The phone stopped charging after a week. Very disappointed.'),
  (2, 'Bob', 102, 'Excellent camera quality and smooth performance.'),
  (3, 'Carol', 101, 'Battery drains too fast, not satisfied.'),
  (4, 'David', 103, 'Love the design and features. Totally worth it.'),
  (5, 'Eve', 102, 'Screen cracked easily, poor build quality.');

  -- Create PRODUCTS table
CREATE OR REPLACE TEMPORARY TABLE PRODUCTS (
  PRODUCT_ID INT,
  PRODUCT_NAME STRING
);

INSERT INTO PRODUCTS VALUES
  (101, 'Smartphone X'),
  (102, 'Camera Pro'),
  (103, 'Smartwatch Z');

-- The AI_FILTER function filters rows based on semantic meaning (using Snowflake Cortex’s AI model) rather than strict SQL conditions.

SELECT 
    C.CUSTOMER_NAME,
    P.PRODUCT_NAME,
    C.FEEDBACK
FROM CUSTOMERS AS C
JOIN PRODUCTS AS P
    ON C.PRODUCT_ID = P.PRODUCT_ID
WHERE AI_FILTER(PROMPT('Return true if this feedback expresses negative sentiment or dissatisfaction: {0}', C.FEEDBACK));

------------AI_FILTER: Images-----

-- Filter images by providing an instruction predicate and the image file column:

-- SELECT TO_FILE(file_url) AS img FROM DIRECTORY(@myimages);

--example 1
WITH pictures AS (
SELECT TO_FILE(file_url) AS img
  FROM DIRECTORY(@AISQL_FILES)
)
SELECT
FL_GET_RELATIVE_PATH(img) AS file_path FROM pictures
WHERE AI_FILTER('Is this a picture of a cat?', img);

--example 2
WITH food_pictures AS (
  SELECT
      TO_FILE(file_url) AS img
  FROM DIRECTORY(@food_images)
)
SELECT
FL_GET_RELATIVE_PATH(img) AS file_path FROM food_pictures
WHERE AI_FILTER('Is this a picture of a dessert?', img);


