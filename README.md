# 🏡 AirBnB Clone Database Schema

This repository documents the relational database schema designed for a scalable AirBnB-like application, focusing on core marketplace functionalities, user roles, and transactional integrity.

The schema utilizes **UUIDs** (Universally Unique Identifiers) for all primary keys to ensure global uniqueness and scalability across distributed systems.

---

## 🧭 Table of Contents
* [Core Entities Overview](#core-entities-overview)
* [Key Relationships & Constraints](#key-relationships--constraints)
* [Indexing Strategy](#indexing-strategy)

---

## 1. Core Entities Overview

The database is built around six main entities that manage user interaction, property listings, and reservations:

| Entity | Primary Key | Description | Key Foreign Keys |
| :--- | :--- | :--- | :--- |
| **User** | `user_id` (UUID) | Stores user profiles; roles include **guest, host, and admin**. | N/A |
| **Property** | `property_id` (UUID) | Details for all property listings. | `host_id` (References User) |
| **Booking** | `booking_id` (UUID) | Manages reservations. Status is one of `pending`, `confirmed`, or `canceled`. | `property_id`, `user_id` |
| **Payment** | `payment_id` (UUID) | Records transaction details. | `booking_id` |
| **Review** | `review_id` (UUID) | Stores user ratings and comments (1-5 range). | `property_id`, `user_id` |
| **Message** | `message_id` (UUID) | Direct user-to-user communication logs. | `sender_id`, `recipient_id` |

---

## 2. Key Relationships & Constraints

Database integrity is maintained through defined constraints and validation rules:

* **User Validation:** The `email` field is strictly enforced as **UNIQUE** and **NOT NULL**.
* **Property Ownership:** Every `Property` must be linked to a valid `User` via the `host_id` foreign key.
* **Booking Status:** The `status` field in the Booking table is restricted to the ENUM values: `pending`, `confirmed`, or `canceled`.
* **Review Rating:** The `rating` field in the Review table must be an **INTEGER** between 1 and 5 (inclusive).

---

## 3. Indexing Strategy

Indexing is applied to optimize query performance for frequently used lookup fields:

| Table | Indexed Fields | Purpose |
| :--- | :--- | :--- |
| `User` | `email` | Fast user login and lookup. |
| `Property` | `property_id` | Efficient property retrieval. |
| `Booking` | `property_id` | Quickly find bookings for a specific property. |
| `Payment` | `booking_id` | Fast transaction lookup linked to a booking. |

