# Vaccine Research & Development Database

Course project for Fundamentals of Databases. Contains database schema, sample data, views, procedures, and a Streamlit UI for managing vaccine trial data.

## Overview
The system tracks:
- Vaccine candidates and target diseases
- Antigens and formulations
- Batches and production dates
- Research sites and clinical studies (Phases I-III)
- Anonymized participants, adverse events, and lab results

## Tech Stack
- **Database**: MySQL 8.0+
- **Language**: Python 3.x
- **Web UI**: Streamlit
- **Python Libraries**: `mysql-connector-python`, `pandas`

## Repository Structure
- `/README.md`: Project documentation and setup guide
- `/sql/create_tables.sql`: DDL script creating 11 tables with keys and check constraints
- `/sql/load_data.sql`: DML script inserting sample records across all tables
- `/sql/queries.sql`: SQL queries (joins, aggregations, subqueries, and CRUD operations)
- `/sql/views.sql`: Database views for reporting and analytical summaries
- `/sql/triggers_procedures.sql`: Stored procedure and stored function definitions
- `/diagrams/ERD.png`: Entity-Relationship Diagram
- `/src/app.py`: Web application source code for database interaction (UI)
- `/report.pdf`: Written technical report
- `/presentation.pptx`: Presentation slides for project defense

## Setup and Execution Guide

### 1. Database Setup
Run the SQL scripts in MySQL Workbench in the exact order listed below:
1. `sql/create_tables.sql`
2. `sql/load_data.sql`
3. `sql/queries.sql`
4. `sql/views.sql`
5. `sql/triggers_procedures.sql`

### 2. User Interface Setup (UI)
1. Install Python dependencies:
   ```bash
   pip install streamlit mysql-connector-python pandas
2. Make sure your local MySQL password matches the one in src/app.py, then run:
   ```bash
   streamlit run src/app.py
