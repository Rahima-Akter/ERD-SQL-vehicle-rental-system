<!-- create database -->
create database vehicle_rental_system


<!-- user table -->
create table users(
user_id serial primary key,
name varchar(30) not null,
email varchar(100) unique not null,
password varchar(255) not null,
phone_number varchar(15) not null,
role varchar(20) check (role in ('Admin', 'Customer'))
);

insert into users (name, email, password, phone_number, role) values
('John Doe', 'john.doe@example.com', 'password123', '123-456-7890', 'Admin'),
('Jane Smith', 'jane.smith@example.com', 'password123', '987-654-3210', 'Customer'),
('Alice Johnson', 'alice.johnson@example.com', 'alicepassword', '111-222-3333', 'Customer'),
('Bob Lee', 'bob.lee@example.com', 'bobpassword', '444-555-6666', 'Admin'),
('Charlie Brown', 'charlie.brown@example.com', 'charlie123', '555-444-3333', 'Customer'),
('David Williams', 'david.williams@example.com', 'davidpassword', '777-888-9999', 'Admin'),
('Emily Davis', 'emily.davis@example.com', 'emilypassword', '222-333-4444', 'Customer'),
('Frank Moore', 'frank.moore@example.com', 'frankpassword', '666-777-8888', 'Customer'),
('Grace White', 'grace.white@example.com', 'grace123', '999-000-1111', 'Admin'),
('Henry cavil', 'henry.cavil@example.com', 'henrycavilpassword', '444-333-5555', 'Customer');


<!-- vehicles table -->
create table vehicles(
vehicle_id serial primary key,
vehicle_name varchar(50) not null,
vehicle_type varchar(20) check (vehicle_type in ('car', 'bike', 'truck')),
vehicle_model varchar(50) not null,
registration_number varchar(100) unique not null,
daily_rent_price decimal(8,2) not null,
availability_status varchar(20) check (availability_status in ('available','rented','maintenance'))
);

insert into vehicles (vehicle_name, vehicle_type, vehicle_model, registration_number, daily_rent_price, availability_status) values
('Toyota Camry', 'car', '2023 Sedan', 'ABC1234', 50.00, 'available'),
('Honda CR-V', 'car', '2022 SUV', 'XYZ5678', 70.00, 'rented'),
('Yamaha R1', 'bike', '2021 Sport', 'MNO9876', 30.00, 'available'),
('Ford F-150', 'truck', '2023 Pickup', 'DEF3456', 100.00, 'maintenance'),
('Chevrolet Malibu', 'car', '2022 Sedan', 'GHI2345', 60.00, 'available'),
('Nissan Pathfinder', 'car', '2023 SUV', 'JKL6789', 80.00, 'rented'),
('Harley Davidson', 'bike', '2021 Cruiser', 'PQR1122', 40.00, 'available'),
('Ram 1500', 'truck', '2023 Pickup', 'STU2233', 90.00, 'available'),
('BMW 320i', 'car', '2022 Sedan', 'VWX4455', 75.00, 'rented'),
('Toyota Highlander', 'car', '2023 SUV', 'YZA5567', 85.00, 'available');
('Honda Civic', 'car', 'Honda Civic 2023', 'HVC1234', 60.00, 'available'),
('Kawasaki Ninja', 'bike', 'Kawasaki Ninja ZX-10R', 'KAW5678', 50.00, 'rented'),
('Chevrolet Silverado', 'truck', 'Chevrolet Silverado 2500', 'CHE8901', 120.00, 'available'),
('Tesla Model S', 'car', 'Tesla Model S 2023', 'TES2234', 150.00, 'maintenance'),
('Yamaha R6', 'bike', 'Yamaha YZF-R6', 'YAM5567', 45.00, 'available');
('Toyota Camry', 'car', '2023 Sedan', 'XYZ7890', 50.00, 'available'),
('Toyota Camry', 'car', '2023 Hybrid', 'ABC7890', 55.00, 'rented');


<!-- bookings table -->
create table bookings(
booking_id serial primary key,
user_id int references users(user_id) on delete cascade,
vehicle_id int references vehicles(vehicle_id) on delete cascade,
rent_start_date timestamp not null default now(),
rent_end_date date not null,
booking_status varchar(30) check (booking_status in ('pending','confirmed','completed','cancelled')),
total_rent_cost decimal(8,2) not null
);


insert into bookings(user_id, vehicle_id, rent_start_date, rent_end_date, booking_status, total_rent_cost) values
(1, 2, '2025-12-01 10:00:00', '2025-12-05', 'confirmed', 350.00),
(2, 4, '2025-12-03 09:00:00', '2025-12-07', 'pending', 400.00),
(3, 1, '2025-12-10 12:00:00', '2025-12-12', 'completed', 150.00),
(4, 7, '2025-12-01 08:00:00', '2025-12-03', 'cancelled', 0.00),
(5, 9, '2025-12-15 14:00:00', '2025-12-18', 'confirmed', 225.00),
(6, 8, '2025-12-05 11:00:00', '2025-12-06', 'completed', 90.00),
(7, 3, '2025-12-07 13:00:00', '2025-12-10', 'pending', 210.00),
(8, 5, '2025-12-10 15:00:00', '2025-12-14', 'confirmed', 500.00),
(9, 6, '2025-12-20 16:00:00', '2025-12-22', 'confirmed', 180.00),
(10, 10, '2025-12-22 17:00:00', '2025-12-25', 'completed', 320.00);




<!-- SQL Queries -->
<!-- Query 1: (JOIN) Retrieve booking information along with:Customer name, Vehicle name -->
select b.booking_id, 
name, vehicle_name,rent_start_date, rent_end_date,booking_status 
from bookings as b 
inner join users as u on b.user_id = u.user_id
inner join vehicles as v on b.vehicle_id = v.vehicle_id;



<!--Query 2: (EXISTS) Find all vehicles that have never been booked.-->
select * from vehicles as v
where not exists(select * from bookings as b where b.vehicle_id = v.vehicle_id);



<!-- Query 3: (WHERE) Retrieve all available vehicles of a specific type (e.g. cars). -->
select * from vehicles where vehicle_type = 'car' and availability_status = 'available';



<!-- Query 4: (GROUP BY and HAVING) Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings. -->
select vehicle_id, count(*) as booking_count from bookings as b
group by b.vehicle_id having count(*) > 2;