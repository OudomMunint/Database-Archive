--Query for hotel DB
--TST AND QA ONLY

select * from hotel
--where city = 'Newcastle'
where city like '%New%'

select g from guest
where guestAdress like '%Street%'
order by guestName

select * from Room
where (type like '%D' or type like'%F') and price >180
order by price asc

select * from booking
where dateto is Null

select count(*) as "Number Of Hotel" from hotel

select avg(price) as "Average Price of rooms" from room

select sum(price) as "Sum Price of rooms" from room
where type like '%F'

select guestNo, count(roomNo) From booking
where roomno like '%1'
group by guestNo

Select hotelNo, count(roomNo) as "Number of rooms in hotel" from room
group by hotelNo
order by hotelNo