/**

AI_EXTRACT - Extracts information from an input string or file.

-- Text 

    AI_EXTRACT( <text>, <responseFormat> )

    AI_EXTRACT( text => <text>, responseFormat => <responseFormat> )

-- Extract information from a file:

AI_EXTRACT( <file>, <responseFormat> )

AI_EXTRACT( file => <file>, responseFormat => <responseFormat> )

**/



USE ROLE TRG_CORTEX_ROLE;
USE DATABASE TRAINING_DB;
USE SCHEMA PUBLIC;
USE WAREHOUSE COMPUTE_WH;


--extract the information
SELECT AI_EXTRACT( text => 'John Smith lives in San Francisco and works for Snowflake',
responseFormat => {'name': 'What is the first name of the employee?', 'city': 'What is the address of the employee?'}
);

--extract and parses the information
SELECT AI_EXTRACT( text => 'John Smith lives in San Francisco and works for Snowflake', 
responseFormat => PARSE_JSON('{"name": "What is the first name of the employee?", "address": "What is the address of the employee?"}')
);





SELECT AI_EXTRACT(
file => TO_FILE('@emp_stage/Employee_Address_List.pdf'),
responseFormat => [['name', 'What is the name of the employee?'], ['city', 'Where does the employee live?']]
);

--Extracts the title

SELECT AI_EXTRACT(
  file => TO_FILE('@emp_stage/Employee_Address_List.pdf'),
  responseFormat => {
    'schema': {
      'type': 'object',
      'properties': {
        'title': {
          'description': 'What is the title of document?',
          'type': 'string'
        }
      }
    }
  }
);

-- Employees Arrays

SELECT AI_EXTRACT(
  file => TO_FILE('@emp_stage/Employee_Address_List.pdf'),
  responseFormat => {
    'schema': {
      'type': 'object',
      'properties': {
        'employees': {
          'description': 'What are the surnames of employees?',
          'type': 'array'
        }
      }
    }
  }
);

SELECT AI_EXTRACT(
  file => TO_FILE('@emp_stage/Employee_Address_List.pdf'),
  responseFormat => {
    'schema': {
      'type': 'object',
      'properties': {
        'income_table': {
          'description': 'Employee List',
          'type': 'object',
          'properties': {
            'Employee Name': {
              'type': 'array'
            },
            'Address': {
              'type': 'array'
            }
          }
        }
      }
    }
  }
);