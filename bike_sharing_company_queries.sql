--These were the queries I created to study the trends in casual riders using Cyclistic's bike-sharing service in October 2023.  I imported the results of these queries into Tableau where I made a dashboard showing a map, pie chart, and  2 bar charts that visualized casual riders usage of bikes in October 2023. 
 
 --What are the trends for casual bike riders in October 2023?

--Look at number of casual riders for each start station
SELECT member_casual, start_station_name, count(*) AS casual_start_station
FROM `global-approach-402922.cyclistic.trip_data`
WHERE member_casual = 'casual' AND start_station_name IS NOT NULL 
GROUP BY 1, 2
Order by count(*) desc;

--Look at date, start station, and number of casual rider.
SELECT EXTRACT (DATE FROM started_at) AS date_started_at, member_casual, start_station_name, count(*) AS casual_start_station
FROM `global-approach-402922.cyclistic.trip_data`
WHERE member_casual = 'casual' AND start_station_name IS NOT NULL 
GROUP BY 1, 2, 3
Order by count(*) desc;

--Bring in longitude and latitude for creating map of most popular start station for casual riders.
SELECT start_lat, start_lng, start_station_name, member_casual, start_station_id, count(*) AS number_casual_start_station
FROM `global-approach-402922.cyclistic.trip_data`
WHERE member_casual = 'casual'
GROUP BY 1, 2, 3, 4, 5
ORDER BY count(*)desc;

--Bring in longitude and latitude for creating map of most popular start station for member riders.
SELECT start_lat, start_lng, start_station_name, member_casual, start_station_id, count(*) AS number_casual_start_station
FROM `global-approach-402922.cyclistic.trip_data`
WHERE member_casual = 'member'
GROUP BY 1, 2, 3, 4, 5
ORDER BY count(*)desc;

--Look at what type of bikes casual riders and member riders are using
SELECT member_casual, rideable_type, count(*) AS number_using_different_bikes
FROM `global-approach-402922.cyclistic.trip_data`
GROUP BY 1, 2
ORDER BY member_casual; 

--Find length of a Ride for each casual rider.
SELECT member_casual, start_station_name, started_at, ended_at, TIME_DIFF(TIME(ended_at), TIME(started_at), minute) AS time_difference
FROM `global-approach-402922.cyclistic.trip_data`
WHERE member_casual = 'casual'
GROUP BY 2, 3, 1, 4
ORDER BY count(*) desc;

--Find average length of ride for each start station.
SELECT member_casual, start_station_name, AVG(time_difference) AS average_time_of_ride
FROM `global-approach-402922.cyclistic.time_difference_per_ride`
GROUP BY 2, 1
ORDER BY AVG(time_difference) desc;


--count number of casual rider from each start station.
SELECT member_casual, start_station_name, count(*) AS casual_start_station
FROM `global-approach-402922.cyclistic.trip_data`
WHERE member_casual = 'casual' AND start_station_name = 'Phillips Ave & 79th St'
GROUP BY 1, 2
Order by count(*) desc;

--Find total number of rides taken by casual riders, member riders, and the total combined in October
SELECT member_casual, count(started_at) AS number_of_casual_rides_taken
FROM `global-approach-402922.cyclistic.trip_data`
WHERE member_casual = 'casual' OR member_casual = 'member'
GROUP BY 1
ORDER BY count(started_at);