# MISSION (6) 노말 타입이 아닌 포켓몬들의 데이터를 전부 가져와 주세요.

select * from mypokemon
where type != 'normal';

# MISSION (7) 타입이 (normal, fire, water, grass) 중에 하나인 포켓몬들의 이름과 타입을 가져와 주세요.

select name, type from mypokemon
where type in ( 'normal' , 'fire' , 'water' , 'grass') ;

# MISSION (8) 공격력이 40과 60 사이인 포켓몬들의 이름과 공격력을 가져와 주세요.

select name, attack from mypokemon
where attack between 40 and 60;

# MISSION (9) 이름에 ‘e’가 포함되는 포켓몬들의 이름을 가져와 주세요.

select name from mypokemon
where name like '%e%';

# MISSION (10) 이름에 ‘i’가 포함되고, 속도가 50 이하인 포켓몬 데이터를 전부 가져와 주세요

select * from mypokemon
where name like '%i%' and speed <= 50;