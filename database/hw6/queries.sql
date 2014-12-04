-- Jimmy Bowens
-- COSC Database
-- Homework #6

use hw6;

-- 1 
select s_name, s_num from S AS suppliers 
	where suppliers.s_num in (select s_num from SPJ AS joint_table) 
    AND suppliers.s_name LIKE 'A%';

-- 2 

select s_name, s_num from S AS suppliers 
	where suppliers.s_num in 
		(select s_num from SPJ AS joint_table where joint_table.p_num in 
			(select p_num from P AS parts where parts.p_name LIKE 'S%')) 
	AND suppliers.s_name LIKE 'A%';

-- 3

select s_name from S AS suppliers 
	join SPJ AS joint_table 
		where suppliers.s_num = joint_table.s_num 
        AND joint_table.j_num in
			(select j_num from J AS job where job.j_num = 'j2');
            
-- 4

select s_name from S AS suppliers 
	join SPJ AS joint_table 
		where suppliers.s_num = joint_table.s_num 
        AND joint_table.j_num in
			(select j_num from J AS job where job.city = 'Athens');

-- 5        
select p_name from P AS parts
	where parts.p_num not in
		(select p_num from SPJ where j_num = 'j3');

-- 6
select status AS compare_status into @compare_status from S where S.s_num = 's1';
select s_num from S where S.status < @compare_status;

-- 7
select sum(status) AS paris_status into @paris_status from S where S.city = 'paris';
select s_num, s_name from S where S.status > @paris_status;

-- 8
select s_name from S AS supplier 
join SPJ as joint_table on supplier.s_num = joint_table.s_num group by (joint_table.qty) having sum(joint_table.qty) > 1000;


-- 9

select j_num, city from J as jobs where jobs.city LIKE 'A%' order by city;

-- 10
update S as suppliers set suppliers.status = suppliers.status + 5 where suppliers.city = 'Paris';

-- 11

update P as parts set parts.p_name = 'Hammer' where parts.p_name = 'Screw' AND parts.city = 'London' AND parts.color = 'Red';

-- 12

delete J , SPJ
from J inner join SPJ on J.j_num = SPJ.j_num
where J.city = 'Rome';
	
-- 13
-- NOT POSSIBLE

-- 14
drop view if exists supplier_shipment;
create view supplier_shipment AS select s_num as supplier_id, qty as quantity from SPJ AS joint_table;


