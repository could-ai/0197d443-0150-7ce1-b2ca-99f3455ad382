// Database migrations executed by AI Agent
// This file contains a record of all SQL statements executed against the database

class DatabaseMigrations {
  static final List<Map<String, dynamic>> migrations = [
      {
      "description": "Create contacts table",
      "sql": "CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    phone_number TEXT NOT NULL UNIQUE,
    email TEXT UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);",
      "executed_at": "2025-07-17T11:21:27Z",
    },
      {
      "description": "Insert initial contacts into the contacts table",
      "sql": "INSERT INTO contacts (name, phone_number, email) VALUES
  ('Lancelot', '123-456-7890', 'lancelot@example.com'),
  ('Susu', '234-567-8901', 'susu@example.com'),
  ('Cici', '345-678-9012', 'cici@example.com'),
  ('bluesky', '456-789-0123', 'bluesky@example.com'),
  ('timo', '567-890-1234', 'timo@example.com'),
  ('couldai', '678-901-2345', 'couldai@example.com');",
      "executed_at": "2025-07-17T12:01:57Z",
    },
      {
      "description": "Add 'created_at' column to contacts table",
      "sql": "ALTER TABLE contacts ADD COLUMN created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;",
      "executed_at": "2025-07-17T12:16:57Z",
    },
      {
      "description": "Add gender column to the contacts table",
      "sql": "ALTER TABLE contacts ADD COLUMN gender TEXT;",
      "executed_at": "2025-07-17T12:23:30Z",
    },
      {
      "description": "Update existing contacts with gender information",
      "sql": "UPDATE contacts SET gender = 'Male' WHERE name = 'Lancelot';
UPDATE contacts SET gender = 'Female' WHERE name = 'Susu';
UPDATE contacts SET gender = 'Female' WHERE name = 'Cici';
UPDATE contacts SET gender = 'Male' WHERE name = 'bluesky';
UPDATE contacts SET gender = 'Male' WHERE name = 'timo';
UPDATE contacts SET gender = 'Male' WHERE name = 'couldai';",
      "executed_at": "2025-07-17T12:29:36Z",
    },
  ];
}
