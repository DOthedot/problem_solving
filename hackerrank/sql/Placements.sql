-- code for mysql
-- for students whos friends got higher offers 
-- and order by there salary in ascending order 

select stud.name
from friends 
left join packages as p1 on friends.id = p1.id 
left join packages as p2 on friends.friend_id = p2.id 
left join students as stud on friends.id = stud.id 
where  p1.salary < p2.salary
order by p2.salary asc 

