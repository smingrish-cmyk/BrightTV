--1. Counting number of users per gender
    SELECT 
    Gender,
    COUNT(*) AS Count
FROM `workspace`.`brighttv_casestudy`.`user_profiles`
WHERE Gender IN ('female', 'male')
GROUP BY Gender
ORDER BY Gender asc;




---2. Counting number of users per race
select Race,
count(*) as Race_Count
FROM `workspace`.`brighttv_casestudy`.`user_profiles`
group by Race
order by Race_Count desc;






--3. Counting the number of users in each province
SELECT 
    Province, 
    COUNT(UserID) AS Total_Subscribers,
    ROUND(AVG(Age), 2) AS Average_Age
FROM `workspace`.`brighttv_casestudy`.`user_profiles`
WHERE Age > 0 AND Province IS NOT NULL 
GROUP BY Province
ORDER BY Total_Subscribers DESC;




--4. Number of users with unkown gender
select count(*) as Gender_Unkown
FROM `workspace`.`brighttv_casestudy`.`user_profiles`
where Gender ='None';




--5. Number of users with unkown race
select count(*) as Race_Unkown
FROM `workspace`.`brighttv_casestudy`.`user_profiles`
where Race ='None';




--6. Number of users with unkown Provinces
select count(*) as Province_Unkown
FROM `workspace`.`brighttv_casestudy`.`user_profiles`
where Province = 'None';




--7. Converting the time zone of the viewership table to SA time
select 
DATE_FORMAT(to_timestamp(RecordDate2, 'M/d/yyyy H:mm') + INTERVAL '2 hour', 'HH:mm:ss') AS SA_Time
from `workspace`.`brighttv_casestudy`.`viewership`;




--8. Extract and format the date and time from the RecordDate2 column.

SELECT 
DATE_FORMAT(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'd/M/yyyy') AS DATE,
DATE_FORMAT(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'HH:mm:ss') AS Time
From `workspace`.`brighttv_casestudy`.`viewership`;





--9. Duration per channel
select Channel2,
DATE_FORMAT(to_timestamp(`Duration 2`, 'M/d/yyyy H:mm'), 'HH:mm:ss') as Duration
From `workspace`.`brighttv_casestudy`.`viewership`;




---10. count viewers per channel
select  Channel2,count(UserID) as No_Of_Viewers
From `workspace`.`brighttv_casestudy`.`viewership`
group by Channel2
order by no_of_viewers desc;




--11. Checking for NULL values in the user profiles table
select *
from `workspace`.`brighttv_casestudy`.`user_profiles`
where UserID is null
   or Name is null
   or Surname is null
   or Email is null
   or Gender is null
   or Race is null
   or Age is null
   or province is null
   or `Social media handle` is null;







   --12. Checking for NULL values in the viewership table
   select *
   from `workspace`.`brighttv_casestudy`.`viewership`
   where UserID is null
   or Channel2 is null
   or `Duration 2`is null
   or RecordDate2 is null;





--13. Finding minimum and maximum age for viewers

select min(age) as Youngest,
      max(age) as Oldest
FROM `workspace`.`brighttv_casestudy`.`user_profiles`;


select
  COUNT(*) AS Count
from `workspace`.`brighttv_casestudy`.`viewership`;


--14. Table Join
select 
u.userid,
ifnull(u.Name,'Unkown') AS Name,
 ifnull(u.Surname,'Unkown') AS Surname,
 ifnull(u.Email,'Unkown') AS Email,
 ifnull(u.Gender,'Unkown') AS Gender,
  ifnull(u.Race,'Unkown') AS Race,
ifnull(u.Age,0) AS Age,
ifnull(u.Province,'Unkown') AS Province,
ifnull(u.`Social Media Handle`,'Unkown') AS Social_Media_Handle,
ifnull(v.Channel2, 'Unkown') AS Channels,
IFNULL(DATE_FORMAT(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'd/M/yyyy'), 'No Date') AS DATE,
IFNULL(monthname(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm')), 'No Date') AS Month,
IFNULL(month(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm')), 0) AS Month_Number,
IFNULL(dayname(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm')), 'No Date') AS Day,
ifnull (DATE_FORMAT(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'HH:mm:ss'),'No Time') AS Time,
ifnull(DATE_FORMAT(to_timestamp(v.`Duration 2`, 'M/d/yyyy H:mm'), 'HH:mm:ss'),'No Duration') as Duration,
case
   when u.age between 0 and 18 then 'Under_Age'
   when u.age between 19 and 30 then 'Young_Adult'
   when u.age between 31 and 45 then 'Adult'
  Else 'Middle_Age'
  End as Age_Group
from `workspace`.`brighttv_casestudy`.`user_profiles` as U
left join `workspace`.`brighttv_casestudy`.`viewership` as V
on U.UserID=V.UserID;

select
IFNULL(monthname(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm')), 'No Date') AS Month
from `workspace`.`brighttv_casestudy`.`viewership` as v;
