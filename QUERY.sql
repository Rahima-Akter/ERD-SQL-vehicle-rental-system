
-- Query 1:
select b.booking_id, 
name, vehicle_name,rent_start_date, rent_end_date,booking_status 
from bookings as b 
inner join users as u on b.user_id = u.user_id
inner join vehicles as v on b.vehicle_id = v.vehicle_id;



-- Query 2:
select * from vehicles as v
where not exists(select * from bookings as b where b.vehicle_id = v.vehicle_id);



-- Query 3:
select * from vehicles where vehicle_type = 'car' and availability_status = 'available';


-- Query 4:
select v.vehicle_name, b.vehicle_id, count(*) as booking_count from bookings as b
inner join vehicles as v on b.vehicle_id = v.vehicle_id
group by b.vehicle_id, v.vehicle_name having count(*) > 2;