-----------------------------------------------------------------------------------------------------------
--Queries run using data from Synthea, a synthetic patient database.  Some of these queries were made with 
--tutorials from Josh Matlock, https://datawizardry.academy/. Others were further explorations I did on my own.
--Functions include count(),GROUP BY, ORDER BY, HAVING, and JOINS.
___________________________________________________________________________________________________________

select * from public.encounters;
--Examine inpatient encounters
select *
from public.encounters
where encounterclass = 'inpatient';

select id, prefix, first, last, suffix
from public.patients
where city = 'Boston';

--Look at encounters with patients with chronic kidney diseases in all 4 stages of the disease.
select *
from public.conditions
where code in ('585.1', '585.2', '585.3', '585.4') ;

--Count Number of encounters with patients with different types of chronic kidney disease
select description, count(*) as patients_with_kidney_disease 
from public.conditions
where code in ('585.1', '585.2', '585.3', '585.4')
GROUP BY description
Order by count(*) desc;

--List of patients from their city of residence.
--Only including cities that have more than 100 patients. 
--Not including Boston.
select city, count(*) as number_of_patients
from public.patients
where city != 'Boston'
Group By city
Having count(*) >= 100
Order by number_of_patients desc;

select *
from public.immunizations;

--Find out the number of patients that live in each city that got the Seasonal Flu Vaccine
select a.code, b.city, count (*) as number_vaccinated_per_city
from public.immunizations a JOIN public.patients b ON patient = ID
where a.code = '5302'
Group BY b.city, a.code
Order by number_vaccinated_per_city desc


