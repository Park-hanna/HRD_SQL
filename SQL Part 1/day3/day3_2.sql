use pokemon;

# MISSION (6) 포켓몬 테이블에서 모든 포켓몬들의 이름과 키, 몸무게를 가져와 주세요.

select name, height, weight from mypokemon;

# MISSION (7) 포켓몬 테이블에서 포켓몬들의 키를 중복 제거하고 가져와 주세요.

select distinct height from mypokemon;

# MISSION (8) 포켓몬 테이블에서 모든 포켓몬들의 공격력을 2배 해 ‘attack2’라는 별명으로 이름과 함께 가져와 주세요.

select name, (attack * 2) as attack2 from mypokemon;

# MISSION (9) 포켓몬 테이블에서 모든 포켓몬들의 이름을 ‘이름’이라는 한글 별명으로 가져와 주세요.

select name as 이름 from mypokemon;

# MISSION (10) 포켓몬 테이블에서 모든 포켓몬들의 공격력은 ‘공격력’이라는 한글 별명으로, 방어력은 ‘방어력’이라는 한글 별명으로 가져와 주세요

select attack as 공격력, defense as "방어력" from mypokemon;