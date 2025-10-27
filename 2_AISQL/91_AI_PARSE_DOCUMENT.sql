/**

AI_PARSE_DOCUMENT

Returns the extracted content from a document on a Snowflake stage as a JSON-formatted string. 

This function supports two types of extraction: Optical Character Recognition (OCR), and layout.

--Syntax
AI_PARSE_DOCUMENT( '@<stage>', '<path>', [ <options> ] )

**/


USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;



SELECT AI_PARSE_DOCUMENT (
    TO_FILE('@parse_stage','SnowProDataScientistStudyGuide.pdf'),
    {'mode': 'LAYOUT' , 'page_split': true}) AS exam_guide;
