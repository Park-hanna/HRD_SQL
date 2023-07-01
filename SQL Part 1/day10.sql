use pokemon;

# MISSION (1) 내 포켓몬 중에 몸무게가 가장 많이 나가는 포켓몬의 번호를 가져와 주세요.

select number
from ability
where weight in (select max(weight) from ability);

# MISSION (2) 속도가 모든 전기 포켓몬의 공격력보다 하나라도 작은 포켓몬의 번호를 가져와 주세요.

select number 
from ability
where speed < any(select attack from ability where type ='electric');

# MISSION (3) 공격력이 방어력보다 큰 포켓몬이 있다면 모든 포켓몬의 이름을 가져와 주세.

select name
from mypokemon 
where exists(select* from ability where attack > defense);

/* MISSION (4) 
이브이의 번호 133을 활용해서, 이브이의 영문 이름, 키, 몸무게를 가져와 주세요.
이 때, 키는 height, 몸무게는 weight이라는 별명으로 가져와 주세요. */

select name, (select height from ability where number = 133) as height,
			 (select weight from ability where number = 133) as weight 
from mypokemon
where number =133;

# MISSION (5) 속도가 2번째로 빠른 포켓몬의 번호와 속도를 가져와 주세요.

select number, speed
from (select number,speed, rank() over(order by speed desc) as speed_rank from ability) as a  
where speed_rank = 2;

# MISSION (6) 방어력이 모든 전기 포켓몬의 방어력보다 큰 포켓몬의 이름을 가져와 주세요.

select name
from mypokemon
where number in 
	(select number from ability where defense > 
    all(select defense from ability where type = 'electric'));
