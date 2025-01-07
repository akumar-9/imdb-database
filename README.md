# IMDB Database Repository

This repository contains the essential SQL scripts and an ER diagram to manage and explore the IMDB database structure and assignments. These resources are useful for understanding database schemas, relationships, and functionalities.

## Contents

### Files
1. **`ASSignment.sql`**
   - SQL script for managing actors, producers, movies, and their mappings.
   - Includes triggers, stored procedures, and utility functions.

2. **`classes.sql`**
   - SQL script for managing school-related entities like classes, teachers, and students.
   - Includes data insertion, queries, and relationships.

3. **`IMDB.sql`**
   - Core SQL file for the IMDB database schema.
   - Defines actors, producers, movies, genres, and their mappings.
   - Includes update triggers for tracking changes.

4. **`ER_Diagram.png`**
   - An Entity-Relationship Diagram (ERD) for the database.
   - Visual representation of the database structure, including entities, relationships, and cardinalities.

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/akumar-9/imdb-database.git
   cd imdb-database
   ```

2. Load the SQL scripts into your preferred database management system (e.g., SQL Server):
   ```sql
   -- Load IMDB schema
   source imdb.sql;

   -- Load assignments schema
   source assignment.sql;

   -- Load classes schema
   source classes.sql;
   ```

3. Refer to the `ER_Diagram.png` file to understand the database structure and relationships.

## Prerequisites

- Microsoft SQL Server or a compatible relational database management system.
- Basic understanding of SQL and database design.

## License

This project is licensed under the [MIT License](LICENSE).

