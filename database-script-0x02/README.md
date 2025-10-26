# Database Population: Sample Data Scripts

This directory is dedicated to populating the defined database schema (schema.sql`) with realistic sample records. This step is critical for initial testing of application logic, database constraints, and query performance.

---

## Primary Artifact: `seed.sql`

The core file, **`seed.sql`**, contains all the necessary SQL `INSERT` statements to populate the six core tables (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`).

### 1. Key Features of the Sample Data

| Feature | Description | Importance |
| :--- | :--- | :--- |
| **Relationship Integrity** | Uses explicit **UUIDs** to ensure every Foreign Key constraint is correctly satisfied across all tables. | Data Integrity |
| **Real-World Scenario** | Reflects common usage patterns with **Hosts**, **Guests**, confirmed/pending bookings, payments, and reviews. | Application Testing |
| **Constraint Testing** | Data is designed to pass all schema constraints, including ENUM values (`role`, `status`) and `CHECK` constraints (e.g., `rating` 1-5). | Validation |

---

## 2. Sample Data Summary

The script creates a small but complete scenario for end-to-end testing:

| Table | Sample Records | Key Scenarios |
| :--- | :--- | :--- |
| **User** | 3 | Host, Guest, Admin roles established. |
| **Property** | 2 | Two distinct listings, both owned by the Host. |
| **Booking** | 2 | One **confirmed** reservation; one **pending** reservation. |
| **Payment** | 1 | Record linked directly to the confirmed booking. |
| **Review** | 1 | 5-star rating for the confirmed property. |
| **Message** | 2 | Conversation records between the Guest and the Host. |
