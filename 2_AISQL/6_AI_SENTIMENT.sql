/**

--AI_SENTIMENT

--Syntax

AI_SENTIMENT( <text> [ , <categories> ] )

**/


USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;



--example uses AI_SENTIMENT to get the overall sentiment of a food service review.
SELECT AI_SENTIMENT('A tourist\'s delight, in low urban light,
Recommended gem, a pizza night sight. Swift arrival, a pleasure so right,
Yet, pockets felt lighter, a slight pricey bite.');




CREATE OR REPLACE TEMPORARY TABLE REVIEWS (
    REVIEW_ID INT AUTOINCREMENT,
    REVIEW_CONTENT STRING
);

INSERT INTO REVIEWS (REVIEW_CONTENT) VALUES
('The concept was unique, but the performance of the lead actor was disappointing.'),
('Brilliant cinematography and soundtrack! The visuals were stunning from start to finish.'),
('The story was predictable, though the acting was top-notch.'),
('Excellent concept and script. The director did a great job bringing the idea to life.'),
('Poor sound mixing ruined the overall experience, though the camera work was solid.'),
('Amazing soundtrack and engaging plot. The performance felt natural and powerful.'),
('The script lacked depth and failed to keep me engaged.'),
('Visually spectacular but emotionally hollow; cinematography saves the film.'),
('Fantastic acting and great direction, but the concept felt reused.'),
('Weak performance by the supporting cast, though the soundtrack was memorable.');

SELECT
  AI_SENTIMENT(
    REVIEW_CONTENT,
    ['concept', 'performance', 'script', 'cinematography', 'soundtrack']
  ) AS SENTIMENT_RESULT,
  REVIEW_CONTENT
FROM REVIEWS
LIMIT 10;
