--following docker-compose.yml  file content can be used to create a postgres server in local , and connect the same with dbeaver 
--code start from the bottom line 
version: '3.8'

services:
  postgres:
    image: postgres:latest  # or postgres:18 for specific version
    container_name: my-postgres
    environment:
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mysecretpassword
      POSTGRES_DB: mydb
      PGDATA: /var/lib/postgresql/data  # Still specifies data location
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql  # Mount one level up!
    restart: unless-stopped

volumes:
  postgres_data:

--code is till the above line 
###############################################################

QUESTIONS QUESTIONS QUESTIONS 
QUESTIONS QUESTIONS QUESTIONS 
QUESTIONS QUESTIONS QUESTIONS 


--leecode hard problem 
--language sql 
--find days when no of people > 100 for 3 or more consecutive days 

with date_grp as (
	select  id , 
			visit_date , 
			no_of_people , 
			row_number() over(order by visit_date asc) as rn,
			id - row_number() over(order by visit_date asc) as grp  
	from stadium 
	where no_of_people > 100 
) 
select grp , count(*) 
from date_grp 
group by grp 
having count(*) >= 3 


-- leetcode hard problem 
-- language sql
-- find median salry of employees 
-- when rows are even median is val at row/2 + val at row/2 + 1  , when rows are odd , the median is val at (row+1)/2
script:
create table employee 
(
emp_id int,
company varchar(10),
salary int
);

insert into employee values (1,'A',2341)
insert into employee values (2,'A',341)
insert into employee values (3,'A',15)
insert into employee values (4,'A',15314)
insert into employee values (5,'A',451)
insert into employee values (6,'A',513)
insert into employee values (7,'B',15)
insert into employee values (8,'B',13)
insert into employee values (9,'B',1154)
insert into employee values (10,'B',1345)
insert into employee values (11,'B',1221)
insert into employee values (12,'B',234)
insert into employee values (13,'C',2345)
insert into employee values (14,'C',2645)
insert into employee values (15,'C',2645)
insert into employee values (16,'C',2652)
insert into employee values (17,'C',65);

with emp_ranking as (
select  emp_id , 
		company, 
		row_number() over(partition by company order by salary asc) as row_num
from employee 
)
select * , max(row_num) over(partition by company) as total_num_rows  -- here we can have used the count(1) as well 
		avg (case 
			when total_num_rows % 2 = 0 and (row_num = total_num_rows/2 or row_num = total_num_rows/2 + 1) then salary
			when total_num_rows % 2 != 0 and (row_num = total_num_rows/2 ) then salary 
		end ) as median_salary 
from emp_ranking 




-- or we can use a clever trick  of inbetween 
with emp_ranking as (
select  emp_id , 
		company, 
		row_number() over(partition by company order by salary asc) as row_num
from employee 
)
select company , avg(salary) as median
from (
select * , count(1) over(partition by company order by salary asc) as total_count 
from employee
where row_num in (total_count::float/2 , total_count::float/2 + 1 )
)
group by company



-- leetcode hard problem 
-- language sql  
-- get the report of student by geography 
-- script:
create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');


-- solution 
-- we want mayank rohit and virat in the same group so, there for
row_number() over(partition by city order by name asc ) -- this way you can give people with earliest name as same grp , and 
-- later you can group by them 

select  player_grp
		max(case when city = 'Banglore' then name else null ) end as 'Banglore'
		max(case when city = 'Delhi' then name else null ) end as 'Delhi'
		max(case when city = 'Mumbai' then name else null ) end as 'Mumbai'
from (
		select * , 
				row_number() over(partition by city order by name asc )  as player_grp
		from player_locations
	 )
group by player_grp





-- python based interview question 
def is_valid_ip(ip_address: str) -> Boolean :

	ip_array = ip_address.split(".")

	if len(ip_array) != 4 : return False

	for bit in ip_array : 
		if !is_instance(bit,int) : return False
		if bit < 0 or bit > 255 : return False 
		else : continue 

	return True




-- leetcode hard problem
-- language sql 
-- problem statement -> get the second most recent activity , and if there is 1 activity then return that only 
-- data query 
create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');



--solution 
with cte as (
select  * , 
		count(*) over(partition by username) as total_activities , 
		rank() over(partition by username order by startDate desc) as rnk , 
from UserActivity
) 
select * 
from cte 
where total_activities = 1 or rnk = 2 



-- leetcode hard problem
-- language sql 
-- problem idea -> recursive cte 

-- solution query 

with recursive_cte as (

		select 1 as num  -- anchor condition 

		union all 

		select num + 1   -- recursive query 
		from recursive_cte 
		where num < 6 	 -- filter to stop the recursion 
)
select num 
from recursive_cte 


-- now comes the problem statement -> overage daily sales are given for 3 poducts , with period start and period end date 
-- calculate total sales by year 

-- data query 
create table sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);


-- soluton 

with cte as (
select min(period_start) as dates  ,  max(period) as max_date 
from sales 
union all 
select dateadd(date, 1, dates) as dates , max_date 
from sales 
where dates < max_date 
) 
select product_id , year(dates) as report_year, sum(average_daily_sales) as total_amount
from cte 
inner join sales on sales.dates between period_start and period_end 
group by product_id , year(dates)
order by product_id , dates asc 

-- note : you can use this recursive cte's to generate dummy data, to generally explode our rows into multiple rows 
-- very important concepts 

######################################################################



-- leetcode hard problem
-- language sql 
-- problem statement -> /* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/

-- date query 
create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);



-- as there will only be 1 plaform 

with cte as (
select spend_date , user_id ,max(platform) as platform, sum(amount) as total_amount
from spending 
group by spend_date , user_id 
having count(distinct plaform) = 1 

union all 

select spend_date , user_id , 'both' as platform, sum(amount) as total_amount
from spending 
group by spend_date , user_id 
having count(distinct plaform) = 2 )

select spend_date , user_id ,max(platform) as platform


-- there is a better answer 
with cte as(
			 	select  spend_date,user_id,case when count(platform)=2 then 'both' else max(platform) end
			 			as platform,count(distinct user_id ) user_count,sum(amount) total_amount
			 	from spending group by spend_date,user_id 

			 	union all
				
				select distinct spend_date,null user_id, 'both' platform , 0 user_count, 0 total_amount 
				from spending
)
select spend_date,platform,sum(user_count) user_count,sum(total_amount) total_amount 
from cte 
group by 	spend_date ,
			platform 
order by 	spend_date ,
			platform desc


-- leetcode sql problem -- set of 4 problems 
-- game play analysis questions 
-- data query 
create table activity (

 player_id     int     ,
 device_id     int     ,
 event_date    date    ,
 games_played  int
 );

 insert into activity values (1,2,'2016-03-01',5 ),(1,2,'2016-03-02',6 ),(2,3,'2017-06-25',1 )
 ,(3,1,'2016-03-02',0 ),(3,4,'2018-07-03',5 );

-- q1 
select player_id , min(event_date) as first_login_date 
from activity
group by player_id

--q2 
select player_id , device_id 
from activity 
left join q1_table on q1_table.player_id = activtiy.player_id and first_login_date = activity.evnet_date

--q3 
select	player_id , event_date , 
		sum(games_played) over (partition by player_id , order by event_date asc) as cum_sum
from activity 

--q4 
with min_date as (
					select player_id , min(event_date) as first_login_date 
					from activity
					group by player_id
				 )
select * , 
from activity 
left join min_date on player_id = player_id and event_date = first_login_date + 1



-- leetcode hard problem 
-- language sql 
-- problem statement -> find the users and mark yes who's second orders are the favrate order of seller , if they have not ordered twice return no 

with second_order_details(
							select * 
							from (
									select seller_id , order_date , 
									row_number() over(partition by seller_id order by order_date asc ) as rn 
									from ordres 
								)
							-- where  rn = 2 
						)
select case when rn = 2 and user.fav_brand = items.item_brand then 'YES' else 'NO' end as status 
from second_order_details 
left join user  on seller_id = user_id 
left join items on item_id = item_id 


-- leetcode hard 
-- language sql 
-- problem statement : find the winner of each , grp which is the person who has the maximum score , in case of tie return the person with least_id 

create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);


-- solution 

with all_player_scores as  (
								select  first_player as player , 
										first_score as score  ,  
										group_id 
								from matches 
								left join players on matches.first_player = players.palyer_id  

								union all 

								select  second_palyer as player  , 
										second_score as score  ,  
										group_id 
								from matches 
								left join players on matches.second_player = players.palyer_id  
							),
final_score as  (
					select  group_id , player , sum(score)
					from all_player_scores 
					group by group_id , player 
				)
select  * , 
		row_number() over(partition by group_id order by player asc )
From 
		final_score 



-- leetcode hard problem 
-- language sql 
-- problem statement -> find the cancellation rate of requests with unbanned users 

-- data query 
Create table  Trips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));
Create table Users (users_id int, banned varchar(50), role varchar(50));
Truncate table Trips;
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');
Truncate table Users;
insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');

-- solution 

select  request_at ,   
		count( case when status = 'cancelled_by_client' or status = 'cancelled_by_driver' then 1 else 0 ) end as user_cancel ,  
		count(1) as total_riders ,
		1.0*user_cancel / total_riders  * 100  as cancellation_percentage::.2f , 
from trips 
left join user on trips.client_id = users.users_id 
where usere.banned  = 'No' 
group by request_at	



-- leetcode hard problem 
-- language sql 
-- problem statement -> report students who are quiet in all exams : where quite means took at least one exam and and score is not the higher or not the lower 

-- data script :
create table students
(
student_id int,
student_name varchar(20)
);
insert into students values
(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

create table exams
(
exam_id int,
student_id int,
score int);

insert into exams values
(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
,(40,2,70),(40,4,80);

-- solution 
--getting the loweest and highest in each exam , 


with all_scores as (
select exam_id , min(score) as lowest_score , max(score) as highest_score 
from exams 
) 
select 
from exams 
inner join all_score on exams.exam_id = all_score.exam_id and score > lowest_score and score < highest_score   -- this will remove stuedents with edge score in some other exam , but they can be avergae in some other , which makes them count as quite 
group by exam_id  


so , instead of that 

with all_scores as (
select exam_id , min(score) as lowest_score , max(score) as highest_score 
from exams 
) 
select student_id , max(case when score = lowest score or score = highest score then 1 else 0 end) as red_flg
from exams
inner join all_scores 
group by student_id 
having red_flg = 0 



-- leetcode hard problem 
-- language sql 
-- problem statement 
-- given the call log data , write a sql query to find out the callers whose first and last call was the same 
-- person on a given day 
-- data query 
script:
create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');

-- solution 
with edge_calls as ( 
select callerid , recipientid , datecalled , 
		max(datecalled) over(partition by callerid ,date(datecalled) ) as max_date ,
		min(datecalled) over(partition by callerid ,date(datecalled) ) as min_date 
from mydb.sql_test.phonelog
order by callerid , datecalled asc
) 
select callerid  , date(datecalled) as called_date,
		recipientid  
from (
select callerid , recipientid , datecalled , lag(recipientid) over(partition by callerid) as prev_called_to 
from edge_calls 
where datecalled = max_date or datecalled = min_date 
) 
where recipientid  = prev_called_to ; 


-- leetcode hard problem 
-- langugae sql , solved on postgre 
-- problem statement : you have budget of 70000 , pick seniors and after that junior , list them 
-- date query 
create table candidates (
emp_id int,
experience varchar(20),
salary int
);
delete from candidates;
insert into candidates values
(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000);


-- solution 
with total_sal as (
select * , sum(salary) over(partition by experience order by salary asc rows between unbounded preceding and current row) as run_sum 
from mydb.sql_test.candidates 
order by experience desc , salary asc  
) , 
sen_sal as (
select * 
from total_sal 
where experience  = 'Senior' and run_sum <= 70000
)
select * 
from total_sal
where experience  = 'Junior' and run_sum <= 70000 - (select sum(salary) from sen_sal) 
union all 
select * 
from sen_sal



