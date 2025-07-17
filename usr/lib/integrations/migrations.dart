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
  ];
}
