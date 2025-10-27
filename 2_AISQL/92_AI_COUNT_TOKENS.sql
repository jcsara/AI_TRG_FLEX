
USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;


SELECT AI_COUNT_TOKENS('ai_complete', 'llama3.3-70b', 'Summarize the insights from this
call transcript in 20 words: "I finally splurged on these after months of hesitation about
the price, and I\'m mostly impressed. The Nulu fabric really is as buttery-soft as everyone says,
and they\'re incredibly comfortable for yoga and lounging. The high-rise waistband stays put
and doesn\'t dig in, which is rare for me. However, I\'m already seeing some pilling after
just a few wears, and they definitely require gentle care. They\'re also quite delicate -
I snagged them slightly on my gym bag zipper. Great for low-impact activities, but I wouldn\'t
recommend for high-intensity workouts. Worth it for the comfort factor"');

-- AI_EMBED
SELECT AI_COUNT_TOKENS('ai_embed', 'nv-embed-qa-4', '"I finally splurged on these after months
of hesitation about the price, and I\'m mostly impressed. The Nulu fabric really is as buttery-soft
as everyone says, and they\'re incredibly comfortable for yoga and lounging. The high-rise waistband
stays put and doesn\'t dig in, which is rare for me. However, I\'m already seeing some pilling after
just a few wears, and they definitely require gentle care. They\'re also quite delicate - I snagged
them slightly on my gym bag zipper. Great for low-impact activities, but I wouldn\'t recommend for
high-intensity workouts. Worth it for the comfort factor"');

SELECT AI_COUNT_TOKENS('ai_classify',
  'One day I will see the world and learn to cook my favorite dishes',
  [
      {'label': 'travel'},
      {'label': 'cooking'},
      {'label': 'reading'},
      {'label': 'driving'}
  ]
);

--with task desc

SELECT AI_COUNT_TOKENS('ai_classify',
  'One day I will see the world and learn to cook my favorite dishes',
  [
    {'label': 'travel', 'description': 'content related to traveling'},
    {'label': 'cooking','description': 'content related to food preparation'},
    {'label': 'reading','description': 'content related to reading'},
    {'label': 'driving','description': 'content related to driving a car'}
  ],
  {
    'task_description': 'Determine topics related to the given text'
  }
);


--AI_SENTIMENT

SELECT AI_COUNT_TOKENS('ai_sentiment',
  'This place makes the best truffle pizza in the world! Too bad I cannot afford it');

  /**

That total tokens includes:
1. System prompt (instructions built by Snowflake)
2. Formatting tokens (JSON-like or internal metadata)
3. Your text input ("bad")
4. Special tokens added before sending to the LLM (e.g., separators, safety context, guardrails prompt)

So, the number you get — 139 tokens — is not the tokenization of the prompt alone. 
It’s the complete structured request payload that Snowflake internally sends to the LLM for the ai_sentiment task.
  **/