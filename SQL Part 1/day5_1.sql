use pokemon;

/* MISSION (1)
포켓몬 테이블에서 포켓몬의 이름과 이름의 글자 수를 이름의 글자 수로 정렬해서 가져와 주세요.
(정렬 순서는 글자 수가 적은 것부터 많은 것 순으로 해주세요.) */

select name, length(name) from mypokemon
order by length(name);

/* MISSION (2)
포켓몬 테이블에서 방어력 순위를 보여주는 컬럼을 새로 만들어서 ‘defense_rank’라는 별명으로 가져와
주세요. 이 때, 포켓몬 이름 데이터도 함께 가져와 주세요.
조건1: 방어력 순위란 방어력이 큰 순서대로 나열한 순위를 의미합니다.
조건2: 공동 순위가 있으면 다음 순서로 건너 뛰어 주세요. */

select name, dense_rank() over(order by(defense) desc) as defense_rank
from mypokemon;
 
/* MISSION (3)
포켓몬 테이블에서 포켓몬을 포획한 지 기준 날짜까지 며칠이 지났는 지를 ‘days’라는 별명으로 가져와
주세요. 이 때, 포켓몬의 이름도 함께 가져와 주세요.
조건: 기준 날짜는 2022년 2월 14일입니다. */

select name, datediff('2022-02-14',capture_date) as days 
from mypokemon;