use pokemon;

# MISSION (1) 내 포켓몬의 타입 별 키의 평균을 가져와 주세요.

select type, avg(height)
from mypokemon
left join ability
on mypokemon.number = ability.number
group by type;

# MISSION (2) 내 포켓몬의 타입 별 몸무게의 평균을 가져와 주세요.

select type, avg(weight)
from mypokemon 
left join ability
on mypokemon.number = ability.number
group by type;

# MISSION (3) 내 포켓몬의 타입 별 키의 평균과 몸무게의 평균을 함께 가져와 주세요.

select type,  avg(height), avg(weight)
from mypokemon
left join ability
on mypokemon.number = ability.number
group by type;

# MISSION (4) 번호가 100 이상인 내 포켓몬들의 번호, 이름, 공격력, 방어력을 가져와 주세요.
use pokemon;
select name, attack, defense
from mypokemon
left join ability
on mypokemon.number = ability.number
where ability.number >= 100;

# MISSION (5) 공격력과 방어력의 합이 큰 순서대로 내 포켓몬들의 이름을 나열해 주세요.

select name
from mypokemon
left join ability
on mypokemon.number = ability.number
order by attack + defense desc;

# MISSION (6) 속도가 가장 빠른 내 포켓몬의 이름을 가져와 주세요.

select name
from mypokemon
left join ability
on mypokemon.number = ability.number
order by speed desc
limit 1;