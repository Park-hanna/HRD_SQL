use fastcampus;

# 매출 관련 추가 분석

-- with 문 : 서브쿼리를 사용해서 임시테이블 처럼 사용 가능 옵티마이저가 인라인 뷰나 임시테이블로 판단
-- window 함수 : lag : 이전행을 가져옴
-- 			lead : 특정 위치 행을 가져옴 디폴트 1 은 다음행을 가져옴

# q17. 2020년 7월 일별 매출과 증감폭, 증감률을 구하라

with tbl_revenue as (
select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as d_date,
		sum(price) as revenue
from tbl_purchase
where purchased_at >= '2020-07-01'
and purchased_at < '2020-08-01'
group by 1
order by 1
)

select * 
	, revenue - lag(revenue) over(order by d_date asc) as diff_revenue
	,round((revenue - lag(revenue) over(order by d_date asc))/lag(revenue) over(order by d_date asc)*100,2) as chg_revenue
from tbl_revenue;

/* q18. 2020년 7월 일별로 많이 구매한 고객들을 구하라, 
7월 일별 구매 금액 기준 가장 많이 지출한 고개 top 3를 구하라
*/

select *
from 
(
select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as d_date,
		customer_id,
        sum(price) as revenue,
        dense_rank() over (partition by date_format(purchased_at - interval 9 hour , '%Y-%m-%d') order by sum(price) desc) as rank_rev
from tbl_purchase
where purchased_at >= '2020-07-01'
and purchased_at < '2020-08-01'
group by 1,2) foo

where rank_rev < 4;
