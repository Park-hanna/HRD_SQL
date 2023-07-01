use pokemon;

/*MISSION (1)
포켓몬 테이블과 능력치 테이블을 합쳐서 포켓몬 이름, 공격력, 방어력을 한번에 가져와 주세요.
이 때, 포켓몬 테이블에 있는 모든 포켓몬의 데이터를 가져와 주세요. 만약, 포켓몬의 능력치 데이터를 구할
수 없다면, NULL을 가져와도 좋습니다.*/

select name, attack, defense
from mypokemon
left join ability
on mypokemon.number = ability.number;

/*MISSION (2)
포켓몬 테이블과 능력치 테이블을 합쳐서 포켓몬 번호와 이름을 한번에 가져와 주세요.
이 때, 능력치 테이블에 있는 모든 포켓몬의 데이터를 가져와 주세요. 만약, 포켓몬의 이름 데이터를 구할
수 없다면, NULL을 가져와도 좋습니다*/

select ability.number, name
from mypokemon
right join ability
on mypokemon.number = ability.number;