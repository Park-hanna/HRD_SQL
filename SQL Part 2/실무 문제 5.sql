use fastcampus;

# 프로덕트 분석 심화
/* q19. 2020년 7월 신규 유저가 하루 안에 결제로 넘어가는 비율을 구하라
		그 비율이 어떠하며, 결제까지 보통 몇 분이 소요되는지 구하라
*/

with rt_tbl as (
select A.*
	  , B.customer_id as paying_user
      , B.purchased_at
      , time_to_sec(timediff(B.purchased_at, A.created_at)) / 3600 as diff_hours
from tbl_customer A
left join (select customer_id
				  , min(purchased_at) as purchased_at
		   from tbl_purchase
           group by 1) B
on A.customer_id = B.customer_id
and B.purchased_at < A.created_at + interval 1 day

where A.created_at >= '2020-07-01'
and A.created_at < '2020-08-01'
)

select round(count(paying_user)/count(customer_id)*100, 2) as per
from rt_tbl
union all
select round(avg(diff_hours),2)
from rt_tbl;

/* q20. 2020년 7월 유저의 재방문율이 높은가? 
7월 기준 Day1 Retention이 어떤지 구하고 추세를 Daily로 추출하라
*/

select date_format(A.visited_at,'%Y-%m-%d') as d_date
	  ,count(distinct A.customer_id) as active_users
      ,count(distinct B.customer_id) as retained_users
      ,count(distinct B.customer_id)/count(distinct A.customer_id) as retention
from tbl_visit A
left join tbl_visit B
on A.customer_id = B.customer_id
and date_format(A.visited_at, '%Y-%m-%d') = date_format(B.visited_at - interval 1 day, '%Y-%m-%d')
where date_format(A.visited_at, '%Y-%m-%d') < '2020-08-01'
group by 1
;

# q21. 가입 기간별 고객 분포가 어떤지 구하라 DAU 기준

use fastcampus;

with tbl_visit_by_joined as 
(select date_format(A.visited_at - interval 9 hour, '%Y-%m-%d') as d_date
		, A.customer_id
        , B.created_at as d_joined
        , max(A.visited_at) as last_visit
        , datediff(cast(max(A.visited_at) as date), cast(B.created_at as date)) as date_diff
from tbl_visit A
left join tbl_customer B
on A.customer_id = B.customer_id

where A.visited_at >= '2020-07-01'
and A.visited_at < '2020-08-01'
group by 1,2,3
)

select A.d_date
	  , case when A.date_diff >= 730 then '2년 이상'
			 when A.date_diff >= 365 then '1년 이상'
			 when A.date_diff >= 183 then '6개월 이상'
	         when A.date_diff >= 91 then '3개월 이상'
			 when A.date_diff >= 30 then '1개월 이상'
             else '1개월 미만'
             end as segment
		, B.all_users
		, count(A.customer_id) as users
        , round(count(A.customer_id)/B.all_users ,2) as per
from tbl_visit_by_joined A
left join (select d_date
				 , count(customer_id) as all_users
			from tbl_visit_by_joined
            group by 1) B
on A.d_date = B.d_date
group by 1,2,3
order by 1,2,3
      
      
      
      
      
      
      
      
      

