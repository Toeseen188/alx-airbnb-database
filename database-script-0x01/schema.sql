-- -----------------------------------------------------------------------------
-- OBJECTIVE: Create the AirBnB Clone Database Schema (Entities and Constraints)
-- USES: Standard SQL DDL (compatible with PostgreSQL/MySQL with UUID support)
-- -----------------------------------------------------------------------------

-- 1. Create the User Table
-- Primary Key: user_id (UUID)
-- Constraints: email must be UNIQUE and NOT NULL. role is an ENUM.
CREATE TABLE "User" (
    user_id       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name    VARCHAR(255) NOT NULL,
    last_name     VARCHAR(255) NOT NULL,
    email         VARCHAR(255) NOT NULL UNIQUE, -- UNIQUE constraint on email
    password_hash VARCHAR(255) NOT NULL,
    phone_number  VARCHAR(20) NULL,
    role          ENUM('guest', 'host', 'admin') NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for fast user lookup and login efficiency
CREATE INDEX idx_user_email ON "User" (email);

-- -----------------------------------------------------------------------------

-- 2. Create the Property Table
-- Primary Key: property_id (UUID)
-- Foreign Key: host_id references User
CREATE TABLE Property (
    property_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id        UUID NOT NULL,
    name           VARCHAR(255) NOT NULL,
    description    TEXT NOT NULL,
    location       VARCHAR(255) NOT NULL,
    pricepernight  DECIMAL(10, 2) NOT NULL,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraint
    CONSTRAINT fk_host
        FOREIGN KEY (host_id) 
        REFERENCES "User" (user_id) 
        ON DELETE CASCADE -- If host is deleted, properties are also deleted
);

-- -----------------------------------------------------------------------------

-- 3. Create the Booking Table
-- Primary Key: booking_id (UUID)
-- Foreign Keys: property_id, user_id
-- Constraints: status is an ENUM
CREATE TABLE Booking (
    booking_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id   UUID NOT NULL,
    user_id       UUID NOT NULL,
    start_date    DATE NOT NULL,
    end_date      DATE NOT NULL,
    total_price   DECIMAL(10, 2) NOT NULL,
    status        ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_booking_property
        FOREIGN KEY (property_id) 
        REFERENCES Property (property_id) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_booking_user
        FOREIGN KEY (user_id) 
        REFERENCES "User" (user_id) 
        ON DELETE RESTRICT -- Prevent user deletion if they have active bookings
);

-- Index for checking property availability efficiently
CREATE INDEX idx_booking_property_id ON Booking (property_id, start_date, end_date);

-- -----------------------------------------------------------------------------

-- 4. Create the Payment Table
-- Primary Key: payment_id (UUID)
-- Foreign Key: booking_id
-- Constraints: payment_method is an ENUM
CREATE TABLE Payment (
    payment_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id      UUID NOT NULL,
    amount          DECIMAL(10, 2) NOT NULL,
    payment_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method  ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    
    -- Foreign Key Constraint
    CONSTRAINT fk_payment_booking
        FOREIGN KEY (booking_id) 
        REFERENCES Booking (booking_id) 
        ON DELETE RESTRICT -- Keep payment record even if booking is canceled
);

-- Index for retrieving transaction history linked to a booking
CREATE INDEX idx_payment_booking_id ON Payment (booking_id);

-- -----------------------------------------------------------------------------

-- 5. Create the Review Table
-- Primary Key: review_id (UUID)
-- Foreign Keys: property_id, user_id
-- Constraints: rating uses a CHECK constraint
CREATE TABLE Review (
    review_id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id   UUID NOT NULL,
    user_id       UUID NOT NULL,
    rating        INTEGER NOT NULL,
    comment       TEXT NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_review_property
        FOREIGN KEY (property_id) 
        REFERENCES Property (property_id) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_review_user
        FOREIGN KEY (user_id) 
        REFERENCES "User" (user_id) 
        ON DELETE RESTRICT,
        
    -- CHECK Constraint for rating range (1 to 5)
    CONSTRAINT chk_rating_range
        CHECK (rating >= 1 AND rating <= 5)
);

-- -----------------------------------------------------------------------------

-- 6. Create the Message Table
-- Primary Key: message_id (UUID)
-- Foreign Keys: sender_id, recipient_id
CREATE TABLE Message (
    message_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id     UUID NOT NULL,
    recipient_id  UUID NOT NULL,
    message_body  TEXT NOT NULL,
    sent_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_message_sender
        FOREIGN KEY (sender_id) 
        REFERENCES "User" (user_id) 
        ON DELETE SET NULL, -- Sender can be deleted without deleting messages
        
    CONSTRAINT fk_message_recipient
        FOREIGN KEY (recipient_id) 
        REFERENCES "User" (user_id) 
        ON DELETE SET NULL -- Recipient can be deleted without deleting messages
);

-- Index for message retrieval by recipient (for an inbox view)
CREATE INDEX idx_message_recipient_id ON Message (recipient_id);

-- -----------------------------------------------------------------------------
