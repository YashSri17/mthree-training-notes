# **Database Tables for Uber-Like Project**

## **Implemented Tables**

### **1. Users Table**
| Column Name     | Data Type          | Constraints                      |
|---------------|-----------------|---------------------------------|
| user_id       | SERIAL PRIMARY KEY | Unique identifier for each user |
| name         | VARCHAR(100)      | NOT NULL                        |
| email        | VARCHAR(100)      | UNIQUE, NOT NULL                |
| phone        | VARCHAR(15)       | UNIQUE, NOT NULL                |
| password_hash | TEXT              | NOT NULL                        |
| user_type    | ENUM('rider', 'captain') | NOT NULL                |
| created_at   | TIMESTAMP         | DEFAULT CURRENT_TIMESTAMP       |

### **2. Captain Table**
| Column Name   | Data Type          | Constraints                        |
|--------------|-----------------|---------------------------------|
| captain_id   | SERIAL PRIMARY KEY | Unique identifier for each captain |
| user_id      | INT              | REFERENCES users(user_id) ON DELETE CASCADE |
| license_number | VARCHAR(50)    | UNIQUE, NOT NULL                 |
| vehicle_id   | INT              | REFERENCES vehicles(vehicle_id) ON DELETE SET NULL |
| rating       | FLOAT            | DEFAULT 5.0                      |
| status       | ENUM('available', 'on-trip', 'offline') | DEFAULT 'offline' |

### **3. Vehicle Table**
| Column Name   | Data Type        | Constraints                        |
|--------------|--------------|---------------------------------|
| vehicle_id   | SERIAL PRIMARY KEY | Unique identifier for each vehicle |
| captain_id   | INT            | REFERENCES captain(captain_id) ON DELETE CASCADE |
| vehicle_type | VARCHAR(50)    | NOT NULL                        |
| model        | VARCHAR(100)   | NOT NULL                        |
| license_plate | VARCHAR(20)   | UNIQUE, NOT NULL                 |
| capacity     | INT            | DEFAULT 4                        |
| color        | VARCHAR(50)    |                                  |

### **4. Rating Table**
| Column Name   | Data Type        | Constraints                        |
|--------------|--------------|---------------------------------|
| rating_id    | SERIAL PRIMARY KEY | Unique identifier for each rating  |
| trip_id      | INT            | REFERENCES trips(trip_id) ON DELETE CASCADE |
| given_by     | ENUM('rider', 'captain') | NOT NULL                |
| rating       | INT            | CHECK (rating BETWEEN 1 AND 5) |
| review       | TEXT           |                                  |
| created_at   | TIMESTAMP      | DEFAULT CURRENT_TIMESTAMP       |

### **5. Payment Table**
| Column Name    | Data Type        | Constraints                        |
|---------------|--------------|---------------------------------|
| payment_id    | SERIAL PRIMARY KEY | Unique identifier for each payment |
| trip_id       | INT            | REFERENCES trips(trip_id) ON DELETE CASCADE |
| amount        | DECIMAL(10,2)  | NOT NULL                        |
| payment_method | ENUM('card', 'cash', 'wallet') | NOT NULL        |
| payment_status | ENUM('pending', 'successful', 'failed') | DEFAULT 'pending' |
| transaction_id | VARCHAR(100)  | UNIQUE                          |
| created_at    | TIMESTAMP      | DEFAULT CURRENT_TIMESTAMP       |

### **6. Location Table**
| Column Name   | Data Type        | Constraints                        |
|--------------|--------------|---------------------------------|
| location_id  | SERIAL PRIMARY KEY | Unique identifier for each location |
| user_id      | INT            | REFERENCES users(user_id) ON DELETE CASCADE |
| location_name | VARCHAR(50)   | NOT NULL                        |
| address      | TEXT           | NOT NULL                        |
| latitude     | DECIMAL(9,6)   |                                  |
| longitude    | DECIMAL(9,6)   |                                  |

## **Additional Tables for Expansion**
11. **Notifications Table** – Stores notifications sent to users.
12. **Support Tickets Table** – Stores customer support queries.
13. **User Sessions Table** – Tracks user login and logout times.
14. **Referral Program Table** – Manages referral bonuses and invites.
15. **Surge Pricing Table** – Defines dynamic pricing based on demand.
16. **Ride Cancellations Table** – Stores reasons for trip cancellations.
17. **Saved Locations Table** – Allows users to save frequent locations.
18. **Feedback Suggestions Table** – Stores user feedback for improvements.
19. **Driver Earnings Table** – Tracks daily earnings of drivers.
20. **App Logs Table** – Stores system logs for debugging purposes.
