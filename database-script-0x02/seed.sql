-- -----------------------------------------------------------------------------
-- OBJECTIVE: Insert Sample Data into AirBnB Clone Database
-- This script uses hardcoded UUIDs for integrity across foreign keys.
-- -----------------------------------------------------------------------------

-- ===============================================
-- 1. UUID DEFINITIONS (FOR FOREIGN KEY REFERENCES)
-- ===============================================

-- Users
-- A. Host with multiple properties and transactions
-- B. Guest who only books
-- C. Admin account
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Elara', 'Vance', 'elara.host@example.com', 'hash_host_1', '123-456-7890', 'host'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Liam', 'Chen', 'liam.guest@example.com', 'hash_guest_2', '987-654-3210', 'guest'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 'Admin', 'Root', 'admin@example.com', 'hash_admin_3', NULL, 'admin');

-- Properties (Owned by Elara Vance)
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight) VALUES
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Zenith Skyloft', 'Modern loft with stunning city views.', 'New York City, NY', 250.00),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a55', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Cozy Lakeside Cabin', 'Perfect retreat for nature lovers.', 'Lake Tahoe, CA', 150.00);

-- Bookings (Made by Liam Chen, all on Zenith Skyloft)
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a66', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '2025-11-01', '2025-11-05', 1000.00, 'confirmed'), -- 4 nights
('g0eebc99-9c0b-4ef8-bb6d-6bb9bd380a77', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '2025-12-15', '2025-12-18', 750.00, 'pending'); -- 3 nights

-- Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
('h0eebc99-9c0b-4ef8-bb6d-6bb9bd380a88', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a66', 1000.00, 'stripe');

-- Reviews (Liam Chen reviews Zenith Skyloft after his confirmed booking)
INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
('i0eebc99-9c0b-4ef8-bb6d-6bb9bd380a99', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 5, 'The skyloft views were incredible, and the location was perfect. Clean and modern!');

-- Messages (Liam Chen asking Host Elara Vance a question)
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('j0eebc99-9c0b-4ef8-bb6d-6bb9bd380b00', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'What is the best way to get from the airport to the skyloft?', '2025-10-25 10:00:00');

-- Example of a second property (Lakeside Cabin) needing a message
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('k0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Hi Liam, I confirmed your booking for the Skyloft. The simplest way is the express train.', '2025-10-25 10:05:00');

-- ===============================================
-- 2. VERIFICATION QUERIES (OPTIONAL)
-- Use these to verify the data was inserted correctly.
-- ===============================================

-- SELECT * FROM "User";
-- SELECT * FROM Property;
-- SELECT * FROM Booking;
-- SELECT * FROM Payment;
-- SELECT * FROM Review;
-- SELECT * FROM Message;
