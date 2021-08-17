
/* CASE STUDY - Cyclistic bike-share analysis */
/* Objective - Find out how do members and casual riders use Cyclistic bikes differently? */

select * from PortfolioProject..JanCycle		--Exploring Data Set

alter table PortfolioProject..JanCycle   
alter column started_at DateTime             
												--Formating Started_at & Ended_at as DateTime	
alter table PortfolioProject..JanCycle   
alter column endeded_at DateTime

select left(started_at,12) as Start_Date,	  --Extracting Date & Time from Started_at & Ended_at
right(started_at,8) as Start_Time, started_at, 
left(ended_at,12) as End_Date, 
right(ended_at,8) as End_Time, ended_at 
from PortfolioProject..JanCycle

alter table PortfolioProject..JanCycle			--Adding new Column Start_Date
add Start_Date Date
update PortfolioProject..JanCycle
set Start_Date = left(started_at,12) 

alter table PortfolioProject..JanCycle			--Adding new Column Start_Time
add Start_Time Time
update PortfolioProject..JanCycle
set Start_Time = right(started_at,8)

alter table PortfolioProject..JanCycle			--Adding new Column End_Date
add End_Date Date
update PortfolioProject..JanCycle
set End_Date = left(ended_at,12) 

alter table PortfolioProject..JanCycle			--Adding new Column End_Time
add End_Time Time
update PortfolioProject..JanCycle
set End_Time = right(ended_at,8)

ALTER TABLE PortfolioProject..JanCycle			--Calculating the Travel Time in Mins 
ADD TravelTime_min INT							--from Start_Time & End_Time
update PortfolioProject..JanCycle
set TravelTime_min = datediff(MINUTE,started_at,ended_at)

SELECT distinct(ride_id), member_casual, TravelTime_min 
from PortfolioProject..JanCycle


---------------------------------------------------------------------------------------------------

/* How many Riders are Members & Casual Riders */

Select Count(Distinct(ride_id)) as Number_of_Rides,member_casual
from PortfolioProject..JanCycle
group  by member_casual

---------------------------------------------------------------------------------------------------
--96834 is the total number of riders in JAN
--78717 are Memebers
--18117 are Casual Riders

/* Classification of Bike Types between Members & Casual Riders */

select  rideable_type, member_casual, 
Count(Distinct(ride_id)) as Number_of_Rides from PortfolioProject..JanCycle
group by member_casual, rideable_type

---------------------------------------------------------------------------------------------------
 /* Analyzing which Station do Members & Casual Riders prefer to start their Journey */ 

select distinct(start_station_name), member_casual, 
Count(Distinct(ride_id)) as Number_of_Rides from PortfolioProject..JanCycle
Where start_station_name is not null and member_casual = 'member'
group by start_station_name, member_casual
ORDER BY Number_of_Rides DESC

select distinct(start_station_name), member_casual,
Count(Distinct(ride_id)) as Number_of_Rides from PortfolioProject..JanCycle
Where start_station_name is not null and member_casual = 'casual'
group by start_station_name, member_casual
ORDER BY Number_of_Rides DESC
--------------------------------------------------------------------------------------------------

/* Analyzing which Station do Members & Casual Riders prefer to end their Journey */ 

select distinct(end_station_name), member_casual, 
Count(Distinct(ride_id)) as Number_of_Rides from PortfolioProject..JanCycle
Where end_station_name is not null and member_casual = 'member'
group by end_station_name, member_casual
ORDER BY Number_of_Rides DESC

select distinct(end_station_name), member_casual, 
Count(Distinct(ride_id)) as Number_of_Rides from PortfolioProject..JanCycle
Where end_station_name is not null and member_casual = 'casual'
group by end_station_name, member_casual
ORDER BY Number_of_Rides DESC

--------------------------------------------------------------------------------------------------

/* Calculating Average Travel Time of Members & Casual Riders */

select member_casual, AVG(TravelTime_min) as AverageTravelTime_Member
from PortfolioProject..JanCycle
where  member_casual = 'member'
GROUP BY member_casual

select member_casual, AVG(TravelTime_min) as AverageTravelTime_Casual
from PortfolioProject..JanCycle
where  member_casual = 'casual'
GROUP BY member_casual

---------------------------------------------------------------------------------------------------