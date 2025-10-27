/*

AI_TRANSLATE - Translates the given input text from one supported language to another.

--Syntax
AI_TRANSLATE(
    <text>, <source_language>, <target_language>)


--

*/

USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;

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


SELECT AI_TRANSLATE(review_content, 'en', 'de') FROM reviews LIMIT 10;

-- English to spanish
SELECT AI_TRANSLATE(
  'Hit the slopes with Snowflake\'s latest innovation - "Skii Headphones" designed to keep your ears warm and your soul ablaze. Engineered specifically for snow weather, these rugged headphones combine crystal-clear sound with thermally-insulated ear cups to keep the chill out and the beats in. Whether you\'re carving through powder or cruising down groomers, Skii Headphones will fuel your mountain adventures with vibrant sound and unrelenting passion. Stay warm, stay fired up, and shred the mountain with Snowflake Skii Headphones',
'en','es');

-- German to English
SELECT AI_TRANSLATE(
  'Kunde: Hallo
    Agent: Hallo, ich hoffe, es geht Ihnen gut. Um Ihnen am besten helfen zu können, teilen Sie bitte Ihren Vor- und Nachnamen und den Namen der Firma, von der aus Sie anrufen.
    Kunde: Ja, hier ist Thomas Müller von SkiPisteExpress.
    Agent: Danke Thomas, womit kann ich Ihnen heute helfen?
    Kunde: Also wir haben die XtremeX Helme in Größe M bestellt, die wir speziell für die kommende Wintersaison benötigen. Jedoch sind alle Schnallen der Helme defekt, und keiner schließt richtig.
    Agent: Ich verstehe, dass das ein Problem für Ihr Geschäft sein kann. Lassen Sie mich überprüfen, was mit Ihrer Bestellung passiert ist. Um zu bestätigen: Ihre Bestellung endet mit der Nummer 56682?
    Kunde: Ja, das ist meine Bestellung.
    Agent: Ich sehe das Problem. Entschuldigen Sie die Unannehmlichkeiten. Ich werde sofort eine neue Lieferung mit reparierten Schnallen für Sie vorbereiten, die in drei Tagen bei Ihnen eintreffen sollte. Ist das in Ordnung für Sie?
    Kunde: Drei Tage sind ziemlich lang, ich hatte gehofft, diese Helme früher zu erhalten. Gibt es irgendeine Möglichkeit, die Lieferung zu beschleunigen?
    Agent: Ich verstehe Ihre Dringlichkeit. Ich werde mein Bestes tun, um die Lieferung auf zwei Tage zu beschleunigen. Wie kommst du damit zurecht?
    Kunde: Das wäre großartig, ich wäre Ihnen sehr dankbar.
    Agent: Kein Problem, Thomas. Ich kümmere mich um die eilige Lieferung. Danke für Ihr Verständnis und Ihre Geduld.
    Kunde: Vielen Dank für Ihre Hilfe. Auf Wiedersehen!
    Agent: Bitte, gerne geschehen. Auf Wiedersehen und einen schönen Tag noch!',
'de','en');
