--Command To Load Data in HIVE from MYSQL using SQOOP:-
--sqoop import --connect jdbc:mysql://quickstart.cloudera/antwak --username antwak --password antwak --table cutomers --hive-import --hive-table antwak.customer

--1. How many records are present? 
Select Count(*) From customers;
--Ans. 12435

--2. How many customers stay in the state TX?
Select Count(*) From customers where customer_state = 'TX';
--Ans. 635

--3.Which state has the lowest customer count?
Select customer_state , count(*) as customer_count  from customers group by customer_state order by customer_count ASC limit 1;
--Ans. State = AL , CustomerCount = 3

--4. Which state has the highest customer count? 
Select customer_state , count(*) as customer_count  from customers group by customer_state order by customer_count DESC limit 1;
--Ans. State = PR , CustomerCount = 4771

--5.How many customers are present with the First Name 'Mary’?
Select count(*) as customer_count from customers where customer_fname = 'Mary';
--Ans. 4741
