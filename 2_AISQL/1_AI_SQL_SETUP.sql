-- Run the following statements to create a database, schema, and a table with data loaded from AWS S3.
USE ROLE ACCOUNTADMIN;
SET USERNAME = (SELECT CURRENT_USER());
CREATE OR REPLACE ROLE TRG_CORTEX_ROLE;
GRANT ROLE TRG_CORTEX_ROLE TO ROLE SYSADMIN;

-- grant new role to user and switch to that role
GRANT ROLE TRG_CORTEX_ROLE to USER identifier($USERNAME);
CREATE OR REPLACE DATABASE TRAINING_DB;
GRANT ALL ON DATABASE TRAINING_DB TO ROLE TRG_CORTEX_ROLE;
GRANT ALL ON SCHEMA PUBLIC TO ROLE TRG_CORTEX_ROLE;



USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;


--REVIEWS TABLE


CREATE OR REPLACE TABLE REVIEWS (
    MOVIE_NAME STRING,
    CONTENT STRING
);

INSERT INTO REVIEWS (MOVIE_NAME, CONTENT) VALUES
('Inception',
'Inception is a visually stunning and intellectually challenging masterpiece by Christopher Nolan. The film explores the concept of dreams within dreams, creating a layered narrative that constantly keeps the audience engaged. Leonardo DiCaprio delivers an intense performance as Dom Cobb, a skilled thief who infiltrates the subconscious to steal or plant ideas. The visual effects are groundbreaking, and Hans Zimmer’s score elevates every scene with emotional depth and tension. Beyond its sci-fi surface, Inception is also about guilt, memory, and the human need for redemption. It rewards multiple viewings and remains one of the most innovative films of the century.'),
('The Dark Knight',
'The Dark Knight redefined what a superhero film could be. Christopher Nolan created a morally complex story that examines chaos, justice, and duality. Heath Ledger’s Joker is one of cinema’s most unforgettable villains—his performance unpredictable, chilling, and captivating from start to finish. Christian Bale’s Batman faces a moral dilemma that challenges his identity as both hero and vigilante. The action sequences are intense, but the movie’s greatest strength lies in its philosophical underpinnings and psychological depth. Every frame, from the cinematography to the haunting musical score, reflects the darkness and conflict at Gotham’s core. It is a true modern classic.'),
('Interstellar',
'Interstellar combines the vastness of space exploration with deeply emotional storytelling. Matthew McConaughey plays Cooper, a pilot who embarks on a journey through wormholes to save humanity from extinction. Christopher Nolan delivers a film that is as much about love and sacrifice as it is about science and discovery. The visuals are breathtaking, particularly the depictions of black holes and alien planets. Hans Zimmer’s score amplifies the sense of awe and urgency throughout. What makes Interstellar unforgettable is its balance between hard science and human emotion. It challenges viewers to think about time, relativity, and what it means to be human.'),
('Titanic',
'Titanic remains one of the most iconic romantic tragedies ever made. Directed by James Cameron, it tells the story of Jack and Rose, two people from different social classes who find love aboard the ill-fated ship. The attention to historical accuracy, stunning set design, and emotional storytelling make it a cinematic triumph. Leonardo DiCaprio and Kate Winslet share undeniable chemistry, making their doomed romance both believable and heartbreaking. The visual effects, especially the sinking sequence, still hold up decades later. Beyond the love story, Titanic reflects themes of class division, fate, and human fragility in the face of disaster.'),
('Avatar',
'Avatar is a visionary film that changed the landscape of modern cinema through groundbreaking 3D technology. James Cameron creates the lush world of Pandora, inhabited by the Na’vi, an indigenous species that embodies harmony with nature. The story follows Jake Sully, a disabled marine who becomes part of this alien culture and discovers a new sense of belonging. Beyond its dazzling visuals and immersive environments, Avatar delivers a strong ecological message about respecting the environment and opposing exploitation. The emotional core lies in transformation—both physical and spiritual. It’s an epic journey that reminds us of the beauty of interconnected life.'),
('The Godfather',
'The Godfather stands as a defining moment in film history, blending family loyalty, power, and corruption into a gripping narrative. Francis Ford Coppola’s direction and Mario Puzo’s storytelling create an unforgettable portrayal of organized crime and human morality. Marlon Brando’s performance as Don Vito Corleone is commanding yet compassionate, while Al Pacino’s transformation from reluctant son to ruthless leader is both tragic and inevitable. The cinematography, dialogue, and music work together to build an atmosphere of quiet menace and grandeur. The Godfather is not just a crime drama—it’s a study of legacy, ambition, and how power reshapes the soul.'),
('The Shawshank Redemption',
'The Shawshank Redemption is a deeply moving film about hope, endurance, and friendship set within the confines of a prison. Tim Robbins plays Andy Dufresne, a man wrongly convicted of murder, whose calm resilience slowly transforms the world around him. Morgan Freeman’s narration as Red gives the story warmth and wisdom. The film’s pacing allows the emotional moments to breathe, emphasizing how patience and faith can triumph over despair. Every scene is filled with subtle detail, from the symbolism of freedom to the redemptive beauty of small victories. It’s a timeless story about the human spirit’s capacity to persevere.'),
('Forrest Gump',
'Forrest Gump is a heartwarming and inspirational journey through decades of American history as seen through the eyes of a kind but simple man. Tom Hanks gives a remarkable performance that balances innocence with profound emotional truth. The film seamlessly blends humor, tragedy, and nostalgia, showcasing Forrest’s unintentional influence on major cultural moments. The soundtrack captures the spirit of each era perfectly. What makes Forrest Gump timeless is its emotional sincerity—it reminds us that greatness often comes from humility, love, and persistence. Through Forrest’s story, we see how destiny unfolds in mysterious ways that are both funny and deeply touching.'),
('The Matrix',
'The Matrix revolutionized science fiction and action cinema by combining philosophical concepts with cutting-edge visual effects. Keanu Reeves plays Neo, a computer hacker who discovers that reality as he knows it is a simulated illusion. The Wachowskis masterfully explore questions about free will, control, and perception. The action sequences, especially bullet time, redefined movie choreography. Laurence Fishburne’s Morpheus and Carrie-Anne Moss’s Trinity add depth and balance to the story. Beneath its high-concept plot, The Matrix challenges viewers to question their own reality and the nature of truth. It remains a landmark film that influenced countless works in modern pop culture.'),
('Gladiator',
'Gladiator is an epic tale of revenge, honor, and redemption set in the grandeur of ancient Rome. Russell Crowe delivers a powerful performance as Maximus, a general betrayed and forced into slavery. Ridley Scott’s direction combines visceral battle scenes with emotional storytelling, capturing both brutality and nobility. The film’s production design and music by Hans Zimmer and Lisa Gerrard create a hauntingly beautiful atmosphere. Beyond the spectacle, Gladiator examines loyalty, justice, and the human will to fight for dignity. It’s a film that resonates with timeless themes of loss, courage, and the pursuit of a purpose greater than oneself.');

-- Run the following statement to create a Snowflake managed internal stage to store the sample image files.
CREATE OR REPLACE STAGE AISQL_FILES encryption = (TYPE = 'SNOWFLAKE_SSE') directory = ( ENABLE = true );


CREATE or REPLACE TABLE image_table AS
(SELECT TO_FILE('@AISQL_FILES', RELATIVE_PATH) AS img_file FROM DIRECTORY(@AISQL_FILES));

SELECT * FROM image_table;



-- FOR @FOOD_IMAGES

-- Run the following statement to create a Snowflake managed internal stage to store the sample image files.
CREATE OR REPLACE STAGE FOOD_IMAGES encryption = (TYPE = 'SNOWFLAKE_SSE') directory = ( ENABLE = true );

-- Run the following statement to create a Snowflake managed internal stage to store the sample image files.
CREATE OR REPLACE STAGE EMP_STAGE encryption = (TYPE = 'SNOWFLAKE_SSE') directory = ( ENABLE = true );

-- Run the following statement to create a Snowflake managed internal stage to store the sample image files.
CREATE OR REPLACE STAGE AUDIO_STAGE encryption = (TYPE = 'SNOWFLAKE_SSE') directory = ( ENABLE = true );

-- Run the following statement to create a Snowflake managed internal stage to store the sample image files.
CREATE OR REPLACE STAGE PARSE_STAGE encryption = (TYPE = 'SNOWFLAKE_SSE') directory = ( ENABLE = true );


