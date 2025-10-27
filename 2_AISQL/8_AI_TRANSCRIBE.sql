/*

AI_TRANSCRIBE- Transcribes text from an audio file with optional timestamps and speaker labels. AI_TRANSCRIBE supports numerous languages, and audio can contain more than one language. Timestamps and speaker labels are extracted based on the specified timestamp granularity, as shown in the table below.

--Syntax
AI_TRANSCRIBE( <audio_file> [ , <options> ] )

*/


USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;



SELECT AI_TRANSCRIBE(TO_FILE('@audio_stage', 'c10128_neutral_uk.mp3'));


SELECT AI_TRANSCRIBE(TO_FILE('@audio_stage', 'c10128_neutral_uk.mp3'),
    {'timestamp_granularity': 'word'});

SELECT AI_TRANSCRIBE(TO_FILE('@audio_stage', 'c10128_neutral_uk.mp3'),
{'timestamp_granularity': 'speaker'});