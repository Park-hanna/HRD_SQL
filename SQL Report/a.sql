/*그중 1등급에 해당하는 고객의 랭킹, 고객아이디, 이름, 성별, 나이, 주소, 
서비스 이용데이터(총 구매횟수, 총 구매금액, 평균 구매금액)를 출력하세요 */
use fastcampus_project;

-- 고객 랭킹 구하기 

select rank() over(order by B.revenue desc) as customer_rank 
		, B.customer_id
        , A.customer_name
        , A.gender
        , A.age
        , A.home_address
        , B.revenue
        , B.count_order
        , B.avg_price
from customers A
inner join (select case when sum(payment) <= 49999 then '5등급'
					    when sum(payment) <= 99999 then '4등급'
					    when sum(payment) <= 149999 then '3등급'	 
					    when sum(payment) <= 199999 then '2등급'		
					    else '1등급'
					    end as grade
					, customer_id
					, sum(payment) as revenue
					, count(customer_id) as count_order
					, avg(payment) as avg_price
				from orders       
				group by customer_id
				having grade = '1등급'
				order by revenue desc) B
on A.customer_id = B.customer_id
order by customer_rank;

-- 고객 등급 나누기 서비스 이용데이터(총 구매횟수, 총 구매금액, 평균 구매금액)를 출력
select case when sum(payment) <= 49999 then '5등급'
				  when sum(payment) <= 99999 then '4등급'
				  when sum(payment) <= 149999 then '3등급'	 
				  when sum(payment) <= 199999 then '2등급'		
			      else '1등급'
			 	  end as grade
		, customer_id
        , sum(payment) as revenue
        , count(customer_id) as count_order
        , avg(payment) as avg_price
from orders       
group by customer_id
having grade = '1등급'
order by revenue desc ;
