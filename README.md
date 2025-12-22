# Vehicle Rental System – Database Design & SQL Queries

## Project Overview

This project is a **Vehicle Rental System** database created to practice
database design, relationships, and SQL queries.

The project focuses on:
- Designing tables with proper relationships
- Using primary keys and foreign keys correctly
- Writing SQL queries using JOIN, EXISTS, WHERE, GROUP BY, and HAVING

---

## Database Description

The database consists of three main tables:

- Users
- Vehicles
- Bookings

These tables work together to manage vehicle rentals in a real-world scenario.

---

## Tables and Business Logic

### Users Table

The Users table stores:
- User name
- Email (unique for each user)
- Password
- Phone number
- User role (Admin or Customer)

Each user can make multiple bookings.

---

### Vehicles Table

The Vehicles table stores:
- Vehicle name
- Vehicle type (car, bike, truck)
- Vehicle model
- Registration number (unique)
- Daily rental price
- Availability status (available, rented, maintenance)

Each vehicle can be booked multiple times.

---

### Bookings Table

The Bookings table stores:
- Which user made the booking
- Which vehicle was booked
- Rental start date and end date
- Booking status (pending, confirmed, completed, cancelled)
- Total rental cost

Each booking is linked to **one user and one vehicle**.

---

## Entity Relationships

- One user can have many bookings
- One vehicle can have many bookings
- Each booking belongs to one user and one vehicle

Primary keys are used to uniquely identify records.
Foreign keys are used to connect related tables.

---

## SQL Queries (queries.sql)

Below are the SQL queries written for this project with explanations.

---

### Query 1: Retrieve Booking Details (JOIN)

This query retrieves booking information along with the customer name
and vehicle name using INNER JOIN.

```sql
SELECT 
    b.id AS booking_id,
    u.name AS customer_name,
    v.vehicle_name,
    b.rent_start_date,
    b.rent_end_date,
    b.booking_status
FROM bookings AS b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id;
```

### Query 2: Retrieve all the not booked vehicles (EXISTS)

This query retrieves all the vehicles information that were not booked using NOT EXISTS.

```sql
SELECT *
FROM vehicles AS v
WHERE NOT EXISTS (
    SELECT *
    FROM bookings AS b
    WHERE b.vehicle_id = v.vehicle_id
);
```

### Query 3: Retrieve all the available vehicle of the same type (SELECT,WHERE)

This query retrieves all the vehicles information of the same type using WHERE and SELECT clause.

```sql
SELECT *
FROM vehicles
WHERE vehicle_type = 'car'
AND availability_status = 'available';
```

### Query 4: Retrieve vehicles with > 2 bookings (GROUP BY,HAVING)

This query retrieves all the vehicles information of the same type using WHERE and SELECT clause.

```sql
SELECT vehicle_id, count(*) AS booking_count FROM bookings AS b
GROUP BY b.vehicle_id 
HAVING count(*) > 2;
```
