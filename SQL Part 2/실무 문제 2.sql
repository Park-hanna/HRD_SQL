use fastcampus;

# 날짜, 시간별 분석
# q6. 2020년 7월의 평균 DAU를 구하라, Active User 수가 증가하는 추세인가?

select date_format(visited_at - interval 9 hour, '%Y-%m-%d') as date_at,
	   count(distinct customer_id)
from tbl_visit
where visited_at >= "2020-07-01" 
	  and visited_at < "2020-08-01"
group by 1
order by 1 asc;

select round(avg(cnt),0) as 2020_07_DAU
from (select count(distinct customer_id) as cnt
	  from tbl_visit
	  where visited_at >= '2020-07-01'
      and visited_at < '2020-08-01'
      group by date_format(visited_at - interval 9 hour, '%Y-%m-%d' )) foo;

# q7. 2020년 7월의 평균 WAU를 구하라

select round(avg(cnt),0) as 2020_07_WAU
from (select date_format(visited_at - interval 9 hour, '%Y-%m-%U') as date_at 
			,count(distinct customer_id) as cnt
	  from tbl_visit
      where visited_at >= '2020-07-01'
      and visited_at < '202-08-01'
      group by date_at) foo;

# q8. 2020년 7월의 Daily Revenue는 증가하는 추세인가? 평균 Daily Revenue를 구하라

select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at
	,  sum(price)
from tbl_purchase
where purchased_at >= '2020-07-01'
and purchased_at < '2020-08-01'
group by date_at
order by date_at asc;

select round(avg(foo.revenue),0) as daily_revenue
from (select sum(price) as revenue
	  from tbl_purchase
	  where purchased_at >= '2020-07-01'
      and purchased_at < '2020-08-01'
      group by date_format(purchased_at - interval 9 hour, '%Y-%m-%d')) as foo;

# q9. 2020년 7월의 평균 Weekly Revenue를 구하라

select round(avg(revenue),0) as weekly_revenue
from (select date_format(purchased_at - interval 9 hour, '%Y-%m-%U') as date_at,
			 sum(price) as revenue
	  from tbl_purchase
	  where purchased_at >= '2020-07-01'
      and purchased_at < '2020-08-01'
      group by date_at) as foo;

# q10. 2020년 7월 요일별 Revenue를 구하라. 어느 요일 Revenue가 가장 높고 낮은가?

select date_format(date_at, '%w') as day_of_week,
       date_format(date_at, '%W') as day_name,
       avg(revenue) as daily_revenue
from (select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at, 
			sum(price) as revenue
	  from tbl_purchase
      where purchased_at >= '2020-07-01'
      and purchased_at < '2020-08-01'
      group by 1) foo
group by 1,2
order by 1;

# q11. 2020년 7월 시간대별 Revenue를 구하라 어느 시간 Revenue가 가장 높고 낮은가?

select hour_at,
       avg(revenue) as hour_revenue
from (select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at, 
			date_format(purchased_at - interval 9 hour, '%H') as hour_at,
			sum(price) as revenue
	  from tbl_purchase
      where purchased_at >= '2020-07-01'
      and purchased_at < '2020-08-01'
      group by 1,2) foo
group by 1
order by 2 desc;


# q12. 2020년 7월 요일 및 시간대별 Revenue를 구하라. 어느 요일 및 시간대 Revenue가 가장 높고 낮은가?

select day_of_week,
	   hour_at,	   
       sum(revenue)
from (select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at, 
			date_format(purchased_at - interval 9 hour, '%W') as day_of_week,
			date_format(purchased_at - interval 9 hour, '%H') as hour_at,
			sum(price) as revenue
	  from tbl_purchase
      where purchased_at >= '2020-07-01'
      and purchased_at < '2020-08-01'
      group by 1,2,3) foo
group by 1,2
order by 3 desc;

# 요일 및 시간대별 Active User 수 계산해보기

select day_of_week,
	   hour_at,
       round(avg(cnt),0) as visit_customer
from (select date_format(visited_at - interval 9 hour, '%Y-%m-%d') as date_at, 
			date_format(visited_at - interval 9 hour, '%W') as day_of_week,
			date_format(visited_at - interval 9 hour, '%H') as hour_at,
			count(distinct customer_id) as cnt
	  from tbl_visit
      where visited_at >= '2020-07-01'
      and visited_at < '2020-08-01'
      group by 1,2,3) foo
group by 1,2
order by 3 desc;