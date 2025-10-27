/**

AI_SIMILARITY
-------------

Computes a similarity score based on the vector cosine similarity value of the inputs’ embedding vectors.
Currently supports both text and image similarity computation.



--SYNTAX 

AI_SIMILARITY( <input1>, <input2> )

AI_SIMILARITY( <input1>, <input2>, <config_object> )

**/


USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;

SELECT AI_SIMILARITY('I like this dish', 'This dish is very good');



CREATE OR REPLACE TEMPORARY TABLE RESTAURANT_REVIEWS (
    REVIEW_ID INT AUTOINCREMENT,
    REVIEW STRING
);

INSERT INTO RESTAURANT_REVIEWS (REVIEW) VALUES
('The pasta was absolutely delicious and full of flavor.'),
('Service was slow, and the waiter forgot our order.'),
('I love the food here! Everything tastes so fresh and homemade.'),
('The ambience was cozy, and the staff were very friendly.'),
('Overpriced for the portion size, not worth it.'),
('The desserts are heavenly — especially the cheesecake!'),
('Food was okay, but the drinks were amazing.'),
('One of the best dining experiences I’ve ever had.'),
('The restaurant was too noisy, couldn’t enjoy the meal.'),
('Great flavors and presentation. Highly recommend!');

SELECT 
REVIEW,
AI_SIMILARITY(REVIEW, 'I love the food here!') AS SIMILARITY_SCORE
FROM RESTAURANT_REVIEWS
ORDER BY SIMILARITY_SCORE DESC;


-- AI_SIMILARITY: Images¶

--In this example, the function computes a similarity score between the two images, cat.jpg and 2cats.jpg, stored in a Snowflake stage @file_stage.

SELECT AI_SIMILARITY(TO_FILE('@AISQL_FILES', 'sleepingcat.png'), TO_FILE('@AISQL_FILES', 'jumpingcat.png'));

SELECT
to_file('@AISQL_FILES', relative_path) as img
FROM directory('@AISQL_FILES')
WHERE AI_SIMILARITY(img, to_file('@AISQL_FILES','sleepingcat.png')) >= 0.5;


