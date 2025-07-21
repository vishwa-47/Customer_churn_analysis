select * from churn_analysis



select contract,
	churn,
	count(*) as total_customers
from churn_analysis
group by contract,churn
order by 2 desc




select churn,
	round(
	avg(monthlycharges)::numeric,2) as average_monthly_charges,
	count(*)
from churn_analysis
group by churn
order by 2 desc



select internetservice,
	count(*) as total_customers,
	count(
	case when churn = 'Yes' then 1 end) as churned_customers,
	round(
	count(case when churn = 'Yes' then 1 end)*100/count(*),2) as churn_rate 
from churn_analysis
group by 1




select min(tenure),
	max(tenure) from churn_analysis



select tenure_group,
		count(*) as total_customers,
		count(
		case when churn = 'Yes' then 1 end) as churned_customers,
		round(
		count(case when churn = 'Yes' then 1 end)*100.0/count(*),2
		) as churn_rate
	from
		(
select case
	when tenure between 0 and 5 then '0-5'
	when tenure >=5 and tenure <15 then '5-15'
	when tenure >=15 and tenure <25 then '15-25'
	when tenure >=25 and tenure <35 then '25-35'
	when tenure >=35 and tenure <45 then '35-45'
	when tenure >=45 and tenure <55 then '45-55'
	when tenure >=55 and tenure <65 then '55-65'
	else '>65'
	end as tenure_group,
	churn
from churn_analysis

)
group by 1
order by 3 desc





select contract,
	paymentmethod,
	round(
	count(case when churn = 'Yes' then 1 end)*100.0/count(*),2
	) as churn_rate
from churn_analysis
group by 1,2
order by 3 desc




select techsupport,
	round(
	count(case when churn = 'Yes' then 1 end)*100.0/count(*),2
	) as churn_rate
from churn_analysis
group by 1
order by 2 desc





with churn_counts as(
	select contract,
	count(*) filter (where churn = 'Yes') as churn_counts
	from churn_analysis
	group by contract
),

total_churn as (
	select sum(churn_counts) as total_churn from churn_counts
)


select contract,
	churn_counts,
	round(churn_counts*100.0/total_churn,2) as total_percent
from churn_counts cc
cross join total_churn tc
order by total_percent desc







select distinct(contract),
	distinct(internetservice),
	distinct(techsupport)
from churn_analysis





select distinct(techsupport) from churn_analysis




select concat(contract,'+',internetservice,'+',techsupport),
	churn_rate
from(
select contract,
	internetservice,
	techsupport,
	count(*) as total_customers,
	count(case when churn = 'Yes' then 1 end) as churned_customers,
	round(
		count(case when churn = 'Yes' then 1 end)*100.0/count(*),2
	) as churn_rate
from churn_analysis
group by contract,internetservice,techsupport	
having count(*)>30

)
order by churn_rate desc
limit 3







with techsupport as(
	select techsupport,
		round(count(case when churn = 'No' then 1 end)*100.0/count(*),2) as 	
)







