# 📝 AirBnB Clone Database: SQL DDL Implementation

This directory contains the Data Definition Language (DDL) necessary to instantiate the AirBnB clone relational database schema. The primary file in this directory is the `schema.sql` file.

---

## 🎯 Implementation Objective

The main goal of the SQL DDL is to accurately translate the finalized database specification into runnable code, ensuring high performance and data integrity from the start.

### Key Requirements:

| Requirement | Details | Importance |
| :--- | :--- | :--- |
| **CREATE TABLE Statements** | Define all six core entities: `User`, `Property`, `Booking`, `Payment`, `Review`, and `Message`. | Mandatory |
| **Data Typing** | Use appropriate data types, including `UUID` for primary keys and `ENUM` for restricted value sets (e.g., `role`, `status`). | High Integrity |
| **Keys & Constraints** | Define all Primary Keys (PK), Foreign Keys (FK), `NOT NULL` constraints, and specific `CHECK` constraints (e.g., Review `rating` 1-5). | High Integrity |
| **Performance Indexing** | Create necessary secondary indexes on frequently queried columns (`email`, `property_id`, `booking_id`) to ensure optimal query performance. | Performance Critical |

---

## 🔗 Referenced Documentation

For a detailed breakdown of all attributes, data types, and constraint rules, please refer to the following documents in the main repository:

* **`requirements.md`**: Full entity and attribute specification.
* **`normalization_report.md`**: Confirmation that the design adheres to the Third Normal Form (3NF).
