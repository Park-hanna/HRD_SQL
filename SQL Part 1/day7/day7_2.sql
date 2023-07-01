use pokemon;

/* MISSION (1)
포켓몬의 번호가 150보다 작으면 값을 ‘old’로 반환하고, 번호가 150보다 크거나 같으면 값을 ‘new’로
반환해서 ‘age’라는 별명으로 가져와 주세요. */

select name, if (number < 150 , 'old', 'new') as age
from mypokemon;

/*MISSION (2)
포켓몬의 공격력과 방어력의 합이 100보다 작으면 값을 ‘weak’로 반환하고, 100보다 크거나 같으면
값을 ‘strong’로 반환해서 ‘ability’라는 별명으로 가져와 주세요. */

select name, if(attack+defense < 100 ,'weak', 'strong') as ability
from mypokemon;

/*MISSION (3)
포켓몬의 타입 별 공격력의 평균이 60 이상이면 값을 True(1)로 반환하고, 60보다 작으면 False(0)를
반환해 ‘is_strong_type’이라는 별명으로 가져와 주세요.  */

select type, if(avg(attack) >= 60, true, false) as is_strong_type
from mypokemon
group by type;

/*MISSION (4)
포켓몬의 공격력이 100보다 크고, 방어력도 100보다 크면 값을 True(1)로 반환하고, 둘 중 하나라도
100보다 작으면 False(0)를 반환해 ‘ace’라는 별명으로 가져와 주세요. */

select name, if(attack > 100 and defense > 100, true, false) as ace
from mypokemon;

/*MISSION (5)
포켓몬의 번호가 100보다 작으면 값을 ‘<100’을 반환하고, 200보다 작으면 값을 ‘<200’을 반환하고,
500보다 작으면 값을 ‘<500’을 반환하는 규칙을 만들고, 각 포켓몬 별 규칙 적용 값을 ‘number_bin’이라는
별명으로 가져와 주세요. */

select name, 
case 
	when number < 100 then '<100'
    when number < 200 then '<200'
    when number < 500 then '<500'
end as number_bin
from mypokemon;

/*MISSION (6)
아래 표에 따른 값을 반환하는 규칙을 만들고, 각 포켓몬 별 규칙 적용 값을 ‘age_attack’이라는 별명으로
가져와 주세요. */

select name, 
case 
	when number >= 150 and attack >= 50 then 'new_strong'
    when number >= 150 and attack < 50 then 'new_weak'
    when number < 150 and attack >= 50 then 'old_strong'
    when number <150 and attack < 50 then 'old_weak'
end as age_attack
from mypokemon;

/*MISSION (7)
타입 별 포켓몬 수가 1개면 ‘solo’, 3개 미만이면 ‘minor’, 3개 이상이면 ‘major’를 반환하고,
‘count_by_type’이라는 별명으로 가져와 주세요. */

select type,
case
	when count(1) = 1 then 'solo'
    when count(1) < 3 then 'minor'
else 'major'
end as count_by_type
from mypokemon
group by type;
