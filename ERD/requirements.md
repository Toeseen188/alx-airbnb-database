i# 🛠️ Database Requirements Blueprint: AirBnB Clone

This document serves as the formal specification for the core data model. It outlines the schema, attribute definitions, data types, and required integrity constraints for all six primary database tables.

---

## 🧭 Table of Contents
* [1. User Table](#1-user-table-authentication-and-profiles)
* [2. Property Table](#2-property-table-listings)
* [3. Booking Table](#3-booking-table-reservations)
* [4. Payment Table](#4-payment-table-transactions)
* [5. Review Table](#5-review-table-feedback)
* [6. Message Table](#6-message-table-user-communication)
* [7. Foreign Key and Index Summary](#7-foreign-key-and-index-summary)

---

## 1. User Table (Authentication and Profiles)

| Attribute | Data Type | Constraints / Notes |
| :--- | :--- | :--- |
| **user\_id** | Primary Key (UUID) | Unique Identifier, Indexed |
| first\_name | VARCHAR (255) | **NOT NULL** |
| last\_name | VARCHAR (255) | **NOT NULL** |
| **email** | VARCHAR (255) | **UNIQUE**, **NOT NULL**, Indexed |
| password\_hash | VARCHAR (255) | **NOT NULL** (Stores hashed password) |
| phone\_number | VARCHAR (20) | NULL (Optional) |
| **role** | ENUM | **NOT NULL**. Values: (`guest`, `host`, `admin`) |
| created\_at | TIMESTAMP | DEFAULT CURRENT\_TIMESTAMP |

---

## 2. Property Table (Listings)

| Attribute | Data Type | Constraints / Notes |
| :--- | :--- | :--- |
| **property\_id** | Primary Key (UUID) | Unique Identifier, Indexed |
| **host\_id** | Foreign Key (UUID) | References `User(user_id)` |
| name | VARCHAR (255) | **NOT NULL** |
| description | TEXT | **NOT NULL** |
| location | VARCHAR (255) | **NOT NULL** (e.g., City, State) |
| pricepernight | DECIMAL (10, 2) | **NOT NULL** |
| created\_at | TIMESTAMP | DEFAULT CURRENT\_TIMESTAMP |
| updated\_at | TIMESTAMP | ON UPDATE CURRENT\_TIMESTAMP |

---

## 3. Booking Table (Reservations)

| Attribute | Data Type | Constraints / Notes |
| :--- | :--- | :--- |
| **booking\_id** | Primary Key (UUID) | Unique Identifier, Indexed |
| **property\_id** | Foreign Key (UUID) | References `Property(property_id)`, Indexed |
| **user\_id** | Foreign Key (UUID) | References `User(user_id)` |
| start\_date | DATE | **NOT NULL** |
| end\_date | DATE | **NOT NULL** |
| total\_price | DECIMAL (10, 2) | **NOT NULL** |
| **status** | ENUM | **NOT NULL**. Values: (`pending`, `confirmed`, `canceled`) |
| created\_at | TIMESTAMP | DEFAULT CURRENT\_TIMESTAMP |

---

## 4. Payment Table (Transactions)

| Attribute | Data Type | Constraints / Notes |
| :--- | :--- | :--- |
| **payment\_id** | Primary Key (UUID) | Unique Identifier, Indexed |
| **booking\_id** | Foreign Key (UUID) | References `Booking(booking_id)`, Indexed |
| amount | DECIMAL (10, 2) | **NOT NULL** (Must match Booking total\_price) |
| payment\_date | TIMESTAMP | DEFAULT CURRENT\_TIMESTAMP |
| **payment\_method** | ENUM | **NOT NULL**. Values: (`credit_card`, `paypal`, `stripe`) |

---

## 5. Review Table (Feedback)

| Attribute | Data Type | Constraints / Notes |
| :--- | :--- | :--- |
| **review\_id** | Primary Key (UUID) | Unique Identifier, Indexed |
| **property\_id** | Foreign Key (UUID) | References `Property(property_id)` |
| **user\_id** | Foreign Key (UUID) | References `User(user_id)` |
| **rating** | INTEGER | **NOT NULL**, **CHECK**: Value must be between 1 and 5. |
| comment | TEXT | **NOT NULL** |
| created\_at | TIMESTAMP | DEFAULT CURRENT\_TIMESTAMP |

---

## 6. Message Table (User Communication)

| Attribute | Data Type | Constraints / Notes |
| :--- | :--- | :--- |
| **message\_id** | Primary Key (UUID) | Unique Identifier, Indexed |
| **sender\_id** | Foreign Key (UUID) | References `User(user_id)` |
| **recipient\_id** | Foreign Key (UUID) | References `User(user_id)` |
| message\_body | TEXT | **NOT NULL** |
| sent\_at | TIMESTAMP | DEFAULT CURRENT\_TIMESTAMP |

---

## 7. Foreign Key and Index Summary

### 7.1. Foreign Key (Relationship) Constraints

| Source Table | Source Attribute | Target Table | Target Attribute | Description |
| :--- | :--- | :--- | :--- | :--- |
| `Property` | `host_id` | `User` | `user_id` | Property owned by a Host User. |
| `Booking` | `property_id` | `Property` | `property_id` | Reservation made for a Property. |
| `Payment` | `booking_id` | `Booking` | `booking_id` | Payment linked to a specific Booking. |
| `Review` | `user_id` | `User` | `user_id` | Review written by a specific User. |
| `Message` | `sender_id` | `User` | `user_id` | Sender of the message. |

### 7.2. Indexing Requirements

The following secondary indexes are mandatory for high-performance retrieval:

* **User:** Index on `email` (for login efficiency and uniqueness check).
* **Booking:** Index on `property\_id` (to check property availability efficiently).
* **Payment:** Index on `booking\_id` (to retrieve transaction history for a booking).
