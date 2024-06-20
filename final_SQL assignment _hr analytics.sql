/*create database sql_w;

use sql_w;
#numeric functions

select abs(22);*/
use hr_ana;
use hr_1;
use hr_2;

/*-------------------------------------KPI 1------------------------------*/
/*Average Attrition rate for all Departments*/

/*select a.Department, concat(format(avg(a.attrition_y)*100,2),'%') as Attrition_Rate
from  ( select department,attrition, case when attrition='No' then 1
Else 0 End as attrition_y from hr_1 ) as a group by a.department;*/


/*--------------------------KPI-2---------------------------*/
/*Average Hourly rate of Male Research Scientist */
SELECT AVG(HourlyRate) AS average_hourly_rate
FROM hr_1
WHERE gender = 'Male' AND JobRole = 'Research Scientist';



/*---------------------KPI-3-----------------------------------*/
/*Attrition rate Vs Monthly income stats */
/*create view Attrition_2 AS SELECT count(attrition) Ex_Employee from hr_1 where attrition = 'Yes';
select * from Attrition_1;
# 3. Attrition rate Vs Monthly income stats

select h1.department,
round(count(h1.attrition)/(select count(h1.employeenumber) from hr_1 h1)*100,2) Attrtion_rate ,
round(avg(h2.MonthlyIncome),2) average_incom from hr_1 h1 join hr_2 h2
on h1.EmployeeNumber = h2.employee_id
where attrition = 'Yes'
group by h1.department;

create view Attrition_employeeincome as
select h1.department,
round(count(h1.attrition)/(select count(h1.employeenumber) from hr_1 h1)*100,2) Attrtion rate,
round(avg(h2.MonthlyIncome),2) average_income from hr_1 h1 join hr_2 h2
on h1.EmployeeNumber = h2.employee id
where attrition = 'Yes'
group by h1.department;

select * from attrition_employeeincome;

*/


/*-------------------------KPI- 4------------------------------ */
/*Average working years for each Department */
/*use hr_analyst;
desc hr_1;
desc hr_2;
show tables;
select * from hr_1;
select * from hr_2;*/

/* 1-- Average Attrition Rate for All Department -- */
/*select a.Department, concat(format(avg(a.attrition_y)*100,2),'%') as Attrition_Rate
from  
( select department,attrition,
case when attrition='No'
then 1
Else 0
End as attrition_y from hr1 ) as a
group by a.department;*/


# --------------------------------------------- KPI 5 --------------------------------------------

# 5. Job Role Vs Work life balance

select * from hr_2;

select h1.jobrole,h2.worklifebalance_status, count(h2.worklifebalance_status) Employee_count
from hr_1 h1 join hr_2 h2
on h1.employeenumber = h2.`Employee ID`
group by h1.jobrole,h2.worklifebalance_status
order by h1.jobrole;

DELIMITER //
Create procedure Get_Count (in job_role varchar(30),in Work_balance varchar(30),out Ecount int)
begin
select count(h2.worklifebalance_status)  Employee_count into ecount
from hr_1 h1 join hr_2 h2
on h1.employeenumber = h2.`Employee ID`
where h1.jobrole = job_role and h2.worklifebalance_status = Work_balance
group by job_role,work_balance;
end //
DELIMITER ;
 
 call get_count('developer','Good',@Ecount);
 select @Ecount;


# --------------------------------------------- KPI 6-------------------------------------------

# 6. Attrition rate Vs Year since last promotion relation

select * from  hr_2;

select h2.`last promotion year`,count(h1.attrition)  attrition_count
from hr_1 h1 join hr_2 h2 on h1.employeenumber = h2.`employee id`
where h1.attrition = 'Yes'
group by `last promotion year`
order by `last promotion year`;


