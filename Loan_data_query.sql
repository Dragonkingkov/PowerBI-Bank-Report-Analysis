SELECT * FROM bank_loan_data;

select count(id) as total_loan_applications from bank_loan_data;


select count(id) as MTD from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021;

select count(id) as PMTD from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021;

select sum(loan_amount) as total_funded_amount from bank_loan_data;

select sum(loan_amount) as mtd_total_funded_amount from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021;

select sum(loan_amount) as pmtd_total_funded_amount from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021;

select sum(total_payment) as total_amount_recieved from bank_loan_data;

-- total_amount_received in current month
select sum(total_payment) as mtd_total_amount_recieved from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021;

--AVG interest rate issued
-- multiply by 100 to get %
-- round to 2 decimal places
select round(avg(int_rate)*100,2) as avg_interest_rate from bank_loan_data;

-- Same for mtd
select round(avg(int_rate)*100,2) as mtd_avg_interest_rate from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021;


-- debt to income ratio 
select round(avg(dti)*100,2) as avg_dti from bank_loan_data;
-- debt to income ratio mtd
select round(avg(dti)*100,2) as mtd_avg_dti from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021;
-- debt to income ratio pmtd
select round(avg(dti)*100,2) as pmtd_avg_dti from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021;


-- Good loans percentage
-- loan status either fully paid or current
select (count(case 
             when loan_status='Fully Paid' or loan_status='Current' then id end))*100
			/count(id) --divided by total loans
			as good_loan_percentage
from bank_loan_data;

-- good loan applications
select count(id) as good_loan_applications from bank_loan_data 
where loan_status='Fully Paid' or loan_status='Current';

-- good loan funded amount

select sum(loan_amount) as good_loan_funded_amount from bank_loan_data
where loan_status='Fully Paid' or loan_status='Current';



-- GOOD LOAN TOTAL RECEIVED AMOUNT

select sum(total_payment) as good_loan_received_amount from bank_loan_data
where loan_status='Fully Paid' or loan_status='Current';

-- Bad loans
--1) Percentage of bad loans

select count(case
          when loan_status='Charged Off' then id end ) *100
		  /
		  count(id)
		  as bad_loan_percentage
from bank_loan_data;

--2) no of bad loans

select count(id) as bad_loans from bank_loan_data
where loan_status='Charged Off'


-- Bad loans funded amount

select sum(loan_amount) as bad_loan_amount from bank_loan_data
where loan_status='Charged Off'

-- Bad loans receieved amount
select sum(total_payment) as bad_loan_amount from bank_loan_data
where loan_status='Charged Off'

-- loan status grid
select loan_status,
count(id) as number_of_applications,
sum(total_payment) as total_recieved_amount,
sum(loan_amount) as total_funded_amount,
round(avg(int_rate)*100,2) as interest,
round(avg(dti)*100,2) as DTI
from bank_loan_data
group by loan_status;

-- loan status grid mtd
select loan_status,
count(id) as number_of_applications_mtd,
sum(total_payment) as mtd_total_recieved_amount,
sum(loan_amount) as mtd_total_funded_amount
from bank_loan_data
where month(issue_date)=12
group by loan_status;

select min(month(issue_date)) from bank_loan_data;

select 
count(id) as Total_loan_applcations, 
sum(loan_amount)  as Total_funded_amount,
sum(total_payment)  as Total_received_amount
from bank_loan_data
group by month(issue_date);


select 
month(issue_date) as month_number,
datename(month,issue_date) as Month_name,
count(id) as Total_loan_applcations, 
sum(loan_amount)  as Total_funded_amount,
sum(total_payment)  as Total_received_amount
from bank_loan_data
group by month(issue_date),datename(month,issue_date)
order by month(issue_date);

-- Make the same data grid by categorizing by address state

select
address_state as State_Name,
count(id) as Total_loan_applcations,
sum(loan_amount)  as Total_funded_amount,
sum(total_payment)  as Total_received_amount
from bank_loan_data
group by address_state
order by Total_loan_applcations desc;


--By loan term
select term as term,
count(id) as loan_applications,
sum(loan_amount)  as Total_funded_amount,
sum(total_payment)  as Total_received_amount
from bank_loan_data
group by term


--By Person's career length
select emp_length as emp_length,
count(id) as loan_applications,
sum(loan_amount)  as Total_funded_amount,
sum(total_payment)  as Total_received_amount
from bank_loan_data
group by emp_length
order by emp_length


-- Purpose

select purpose as loan_purpose,
count(id) as loan_applications,
sum(loan_amount)  as Total_funded_amount,
sum(total_payment)  as Total_received_amount
from bank_loan_data
group by purpose
order by count(id) desc


--Home ownership
select home_ownership as home_ownership,
count(id) as loan_applications,
sum(loan_amount)  as Total_funded_amount,
sum(total_payment)  as Total_received_amount
from bank_loan_data
group by home_ownership
order by count(id) desc