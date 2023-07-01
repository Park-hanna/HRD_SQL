# MISSION (11) 이름이 ‘chu’로 끝나는 포켓몬들의 이름, 키, 몸무게를 가져와 주세요.

select name, height, weight from mypokemon
where name like '%chu';

# MISSION (12) 이름이 ‘e’로 끝나고, 방어력이 50 미만인 포켓몬들의 이름, 방어력을 가져와 주세요.

select name, defense from mypokemon
where name like '%e' and defense < 50;

# MISSION (13) 공격력과 방어력의 차이가 10 이상인 포켓몬들의 이름, 공격력, 방어력을 가져와 주세요.

select name, attack, defense from mypokemon
where attack - defense >= 10 or defense - attack >= 10;

/* MISSION (14)
능력치의 합이 150 이상인 포켓몬의 이름과 능력치의 합을 가져와 주세요.
이 때, 능력치의 합은 ‘total’이라는 별명으로 가져와 주세요.
조건1. 능력치의 합은 공격력, 방어력, 속도의 합을 의미합니다 */

select name, attack + defense + speed as total from mypokemon
where attack + defense + speed >= 150;