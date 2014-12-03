use hw6;
select *,(select s_name from S as B where B.s_num = A.s_num AND B.s_name LIKE 'A%')from SPJ as A where A.p_num = 'p3';

select s_name from S AS suppliers where suppliers.s_num in (select s_num from SPJ AS joint_table) AND suppliers.s_name LIKE 'A%';
