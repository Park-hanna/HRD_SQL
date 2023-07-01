use fastcampus;

# 유저 세그먼트별 분석
/* q13. 전체 유저의 Demographic을 성, 연령별로 유저 수를 구하라
		어느 세그먼트가 가장 숫자가 높은가? (기타 성별은 하나, 연령은 5세 단위, 내림차순)
*/

select case when length(gender) >  1 or length(gender) <1 then '기타'
			else gender
            end as gender,
		case when age is null then '무응답'
			 when age <= 15 then '0. 15세 이하'
			 when age <= 20 then '1. 16~20세 이하'
			 when age <= 25 then '2. 21~25세 이하'
			 when age <= 30 then '3. 26~30세 이하'
			 when age <= 35 then '4. 31~35세 이하'
			 when age <= 40 then '5. 36~40세 이하'
			 when age <= 45 then '6. 41~45세 이하'
			 when age >= 46 then '7. 46세 이상'
             end as age
		,count(*) as cnt
from tbl_customer
group by 1, 2
order by 3 desc;


/* q14. q13 결과의 성,연령을 남성 25-29로 통합 및 각 성, 연령이 
		전체 고객에서 얼마나 차지하는지 분포(%)로 구하라 (내림차순)
*/ 
select concat(case when gender = 'M' then '남성'
			when gender = 'F' then '여성'
            when gender = 'Others' then '기타'
            when length(gender) <1 then '기타'
            end
		, '('
		, case when age is null then '무응답'
			 when age <= 15 then ' 15세 이하'
			 when age <= 20 then ' 16~20세 이하'
			 when age <= 25 then ' 21~25세 이하'
			 when age <= 30 then ' 26~30세 이하'
			 when age <= 35 then ' 31~35세 이하'
			 when age <= 40 then ' 36~40세 이하'
			 when age <= 45 then ' 41~45세 이하'
			 when age >= 46 then ' 46세 이상'
             end
		, ')' ) as gen_age
		, count(*) as cnt
        , round(count(*)/(select count(*) from tbl_customer)*100 ,2) as per
from tbl_customer
group by 1
order by 2 desc;


# q15. 2020년 7월의 성별에 따라 구매 건수 및 총 Revenue를 구하라. 남녀 이외 성별은 하나로 묶어라

select case when length(A.gender) < 1 or length(A.gender) > 1 then 'Others'
			else A.gender
            end as gender
		, count(*) as cnt
        , sum(price) as revenue
from tbl_customer A
left join tbl_purchase B
on A.customer_id = B.customer_id
where B.purchased_at >= '2020-07-01'
and B.purchased_at < '2020-08-01'
group by 1;

# q16. 2020년 7월의 성별, 연령대에 따라 구매 건수 및 총 Revenue를 구하라. 남녀 이외 성별은 하나로 묶어라

select concat(case when gender = 'M' then '남성'
			when gender = 'F' then '여성'
            when gender = 'Others' then '기타'
            when length(gender) <1 then '기타'
            end
		, '('
		, case when age is null then '무응답'
			 when age <= 15 then ' 15세 이하'
			 when age <= 20 then ' 16~20세 이하'
			 when age <= 25 then ' 21~25세 이하'
			 when age <= 30 then ' 26~30세 이하'
			 when age <= 35 then ' 31~35세 이하'
			 when age <= 40 then ' 36~40세 이하'
			 when age <= 45 then ' 41~45세 이하'
			 when age >= 46 then ' 46세 이상'
             end
		, ')' ) as gen_age
		, count(*) as cnt
        , sum(price) as revenue
from tbl_customer A
left join tbl_purchase B
on A.customer_id = B.customer_id
group by 1
order by 3 desc;