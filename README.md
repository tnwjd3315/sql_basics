# SQL Basics: Agricultural Production Data Analysis

This repository contains SQL scripts for working with U.S. agricultural production data across various products including cheese, honey, milk, coffee, eggs, and yogurt. The scripts include table creation, data cleaning, and a variety of SQL queries to explore and analyze production trends by year and state.

## 🗃️ Tables Created

- `cheese_production`, `cheese_clean`
- `honey_production`, `honey_clean`
- `milk_production`, `milk_clean`
- `coffee_production`, `coffee_clean`
- `egg_production`, `egg_clean`
- `yogurt_production`, `yogurt_clean`
- `state_lookup`, `state_clean`

Each "clean" table is derived from its corresponding raw production table by removing rows with `NULL` values in the `Value` column.

## 🧼 Data Cleaning

Commas in the `Value` field are removed from all clean tables using `REPLACE(value, ',', '')` to allow numerical operations.

## 🔍 Example Queries

The script includes various types of SQL queries such as:

- Aggregation:
  - Total milk production in 2023
  - Average honey production in 2022
  - Maximum yogurt production in 2022
- Filtering by year or state:
  - All coffee data from 2015 or 2011
  - All state info where `State = 'IOWA'` or `State = 'FLORIDA'`
- Joins and conditional logic:
  - States that produced both honey and milk in 2022
  - Left joins to find states with missing production data
- Nested queries and grouping:
  - Total yogurt production for states that produced cheese in 2022 or 2023
  - Years where honey production was high and average coffee value calculated

## 📁 File Structure

All SQL commands are currently stored in a single script file. You may split them into sub-files (`create_tables.sql`, `clean_data.sql`, `queries.sql`) for better modularity.

## 📌 Requirements

These scripts are intended to be run in an environment supporting standard SQL, such as:

- DBeaver (recommended for visual interface)
- SQLite / PostgreSQL / MySQL (some adjustments may be needed depending on SQL dialect)

## ✅ License

This project is licensed under the MIT License.

---

Feel free to contribute or fork the repository for your own use.
