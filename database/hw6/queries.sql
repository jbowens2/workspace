use hw6;
-- select *,(select s_name from S as B where B.s_num = A.s_num AND B.s_name LIKE 'A%')from SPJ as A where A.p_num = 'p3';

-- 1 
select s_name, s_num from S AS suppliers 
	where suppliers.s_num in (select s_num from SPJ AS joint_table) 
    AND suppliers.s_name LIKE 'A%';

-- select s_name, s_num from S AS suppliers where suppliers.s_num in (select s_num from SPJ AS joint_table where joint_table.s_num in (select p_num from P as parts where parts.p_name LIKE 'S%')) AND suppliers.s_name LIKE 'A%';

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

-- select s_name, (select sum(qty) from SPJ as joint_table where joint_table.s_num = supplier.s_num) from S AS supplier;
select s_name from S AS supplier 
join SPJ as joint_table on supplier.s_num = joint_table.s_num group by (joint_table.qty) having sum(joint_table.qty) > 1000;




