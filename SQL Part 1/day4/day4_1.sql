use pokemon;

# MISSION (1) 이브이의 타입을 가져와 주세요.

select name, type from mypokemon
where name = 'eevee';

# MISSION (2) 캐터피의 공격력과 방어력을 가져와 주세요.

select name, attack, defense from mypokemon
where name = 'caterpie';

# MISSION (3) 몸무게가 6kg보다 큰 포켓몬들의 모든 데이터를 가져와 주세요.

select * from mypokemon
where weight >= 6;

# MISSION (4) 키가 0.5m보다 크고, 몸무게가 6kg보다 크거나 같은 포켓몬들의 이름을 가져와 주세요.

select name from mypokemon
where height > 0.5 and weight >= 6;

/* MISSION (5) 포켓몬 테이블에서 공격력이 50 미만이거나, 방어력이 50 미만인 포켓몬들의 이름을
‘weak_pokemon’이라는 별명으로 가져와 주세요 */

select name as weak_pokemon from mypokemon
where attack < 50 or defense < 50;