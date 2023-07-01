-- 2) KPI 지표 : 고객 및 상품 주문 데이터에서 서비스를 평가할수 있고 그에 따른 인사이트를 얻을 수 있는 결과를 출력하세요. 

use fastcampus_project;

-- 21년 월별 revenue 및 평균 revenue 파악

select date_format(order_date, '%Y-%m %M') as order_Month
	 , sum(payment) as revenue
     , avg(payment) as avg_revenue
from orders
where order_date >= '2021-01-01'
and order_date < '2022-01-01'
group by order_Month
order by order_Month;

-- 21년 월별 매출의 증감폭, 증감률 파악 (전월 대비 1월 비교 대상 없음)

with orders as (
select date_format(order_date, '%Y-%m %M') as date_at,
		sum(payment) as revenue
from orders
where order_date >= '2021-01-01'
and order_date < '2022-01-01'
group by 1
order by 1 
)

select * 
	, revenue - lag(revenue) over(order by date_at asc) as diff_revenue
	,round((revenue - lag(revenue) over(order by date_at asc))/lag(revenue) over(order by date_at asc)*100,2) as chg_revenue
from orders
order by  diff_revenue desc, chg_revenue desc;

-- 21년 월별 WAU 주별 구매자 파악 (구매자가 많은 요일순)

select date_format(order_date, '%Y-%m-%W') as date_at 
	,count(customer_id) as cnt
from orders
where order_date >= '2021-01-01'
and order_date < '2022-01-01'
group by date_at
order by date_at;

-- 21년 전체 요일별 revenue 평균 파악

select date_format(date_at, '%w') as day_of_week,
       date_format(date_at, '%W') as day_name,
       avg(revenue) as daily_revenue
from (select date_format(order_date, '%Y-%m-%d') as date_at
			,sum(payment) as revenue
	  from orders
      where order_date >= '2021-01-01'
	  and order_date < '2022-01-01'
      group by date_at) foo
group by day_of_week, day_name
order by daily_revenue desc;

-- 21년 구매자 배송 주소 도시별 배송 기간 평균 파악

select round(avg(datediff(A.deli_date,A.ord_date)),0) as avg_deli_date
      , B.city 
from (select date_format(delivery_date,'%Y-%m-%d') as deli_date 
			 , date_format(order_date, '%Y-%m-%d') as ord_date
             , customer_id
		from orders
        where order_date >='2021-01-01' 
        and order_date < '2022-01-01') A
inner join customers B
on A.customer_id = B.customer_id
group by B.city
order by avg_deli_date;

-- 21년 가장 많이 주문한 state 파악

select B.state
	 , count(A.customer_id) as cnt_customer
from orders A
inner join customers B
on A.customer_id = B.customer_id
where A.order_date >= '2021-01-01'
and A.order_date < '2022-01-01'
group by B.state
order by cnt_customer desc;

-- 전체 회원 대상 성, 연령별 분포 파악 및 분포 별 구매 건수, revenue 파악

select concat(case when gender = 'Male' then 'Male'
			when gender = 'Female' then 'Female'
			when gender = 'Agender' then 'Agender'
			when gender = 'Bigender' then 'Bigender'
			when gender = 'Genderfluid' then 'Genderfluid'
            when gender = 'Genderqueer' then 'Genderqueer'
            when gender = 'Non-binary' then 'Non-binary'
            when gender = 'Polygender' then 'Polygender'       
            else "no information"
            end
		, '('
		, case when age is null then 'nothing'
			 when age <= 20 then '  ~20 '
			 when age <= 30 then ' 21~30 '
			 when age <= 40 then ' 31~40 '
			 when age >= 50 then ' 41~50 '
			 when age >= 60 then ' 51~60 '
             when age > 61 then ' 61~ ' 
             else "no information"
             end
		, ')' ) as gen_age
		, count(*) as cnt
        , sum(payment) as revenue
from customers A
left join orders B
on A.customer_id = B.customer_id
group by 1
order by 3 desc;

-- 전체 고객 등급 분포 파악

select  B.grade
		, count(B.grade) as grade_count
        , sum(B.revenue) as revenue
        , avg(B.revenue) as avg_revenue
from customers A
inner join (select case when sum(payment) <= 49999 then '5등급'
					    when sum(payment) <= 99999 then '4등급'
					    when sum(payment) <= 149999 then '3등급'	 
					    when sum(payment) <= 199999 then '2등급'		
					    else '1등급'
					    end as grade
					, customer_id
                    , sum(payment) as revenue
				from orders       
				group by customer_id) B
on A.customer_id = B.customer_id
group by B.grade
order by 1;