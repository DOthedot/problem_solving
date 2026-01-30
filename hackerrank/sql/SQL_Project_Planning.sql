-- code written for mysql compatability 


--using liner dates to figure out the common task group 
with order_partition as (
    select start_date , end_date , 
    row_number() over (order by end_date asc) as rw
    from projects ),
-- using the same grp date , calculating max and min date inside each group
-- after that finding the difference of days between max and min
order_group as (
    select  DATE_SUB(end_date , INTERVAL rw DAY) as grp  , 
    min(start_date) as start_date  , max(end_date) as end_date ,  
    datediff(max(end_date) ,min(start_date)) as diff    
from order_partition
group by grp ) 
--selecting relevant columns for output 
select start_date , end_date  from order_group
order by diff asc ,  start_date asc

