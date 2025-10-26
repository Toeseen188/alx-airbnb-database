# 🎯 Normalization Analysis: Achieving 3NF

This report confirms that the current AirBnB clone database schema is already structured to satisfy the requirements of the **Third Normal Form (3NF)**. Normalization was verified by checking compliance with 1NF, 2NF, and 3NF across all entities.

---

## 🧭 Table of Contents
* [1. Understanding the Goal: Third Normal Form (3NF)](#1-understanding-the-goal-third-normal-form-3nf)
* [2. Compliance Check: First Normal Form (1NF)](#2-compliance-check-first-normal-form-1nf)
* [3. Compliance Check: Second Normal Form (2NF)](#3-compliance-check-second-normal-form-2nf)
* [4. Compliance Check: Third Normal Form (3NF)](#4-compliance-check-third-normal-form-3nf)

---

## 1. Understanding the Goal: Third Normal Form (3NF)

Achieving 3NF means the database design is optimized to prevent data redundancy and anomalies. A table is in 3NF if it meets the following three conditions:

1.  It is in 1NF (Atomic values).
2.  It is in 2NF (No partial dependencies on the primary key).
3.  **No transitive dependencies** (No non-key attribute is dependent on another non-key attribute).

---

## 2. Compliance Check: First Normal Form (1NF)

**Requirement:** Attributes must hold only atomic (single) values, and there are no repeating groups.

**Conclusion:** **Schema Compliant.**

* All attributes (e.g., `first_name`, `pricepernight`, `email`) are defined as single values.
* The use of individual columns for price, location, and contact information avoids compound or repeating groups.

---

## 3. Compliance Check: Second Normal Form (2NF)

**Requirement:** The table must be in 1NF, and all non-key attributes must be fully dependent on the entire primary key. This is only a concern when using **composite primary keys**.

**Conclusion:** **Schema Compliant.**

* All tables in the schema (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`) use a **single-column Primary Key** (`UUID`s like `user_id`, `property_id`, etc.).
* Since there are no composite primary keys, partial dependency is impossible by definition, confirming 2NF compliance.

---

## 4. Compliance Check: Third Normal Form (3NF)

**Requirement:** The table must be in 2NF, and there should be **no transitive dependencies**. (No non-key attribute determines the value of another non-key attribute).

**Conclusion:** **Schema Compliant.**

The current design successfully prevents transitive dependencies:

* **User Table:** Attributes like `first_name` or `phone_number` do not determine the `password_hash` or `role`. All non-key attributes directly describe the `user_id`.
* **Property Table:** `pricepernight` does not determine `location`, and vice-versa. All fields directly describe the `property_id`.
* **Booking Table:** Non-key attributes like `start_date` and `end_date` are only dependent on the `booking_id`, not on the `total_price` or `status`.

Because the schema adheres to these three fundamental rules, **no structural changes were necessary** to achieve 3NF.
