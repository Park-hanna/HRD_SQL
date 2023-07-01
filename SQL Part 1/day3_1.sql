use pokemon;

# MISSION (1) 123 곱하기 456을 가져와 주세요. (힌트) MySQL에서 곱하기 기호(×)는 * 로 표현합니다. (숫자 * 숫자)

select 123 * 456;

#MISSION (2) 2310 나누기 30을 가져와 주세요. (힌트) MySQL에서 나누기 기호(÷)는 / 로 표현합니다. (숫자 / 숫자)

select 2310 / 30 ;

#MISSION (3) ‘피카츄’라는 문자열을 ‘포켓몬’이라는 이름의 컬럼 별명으로 가져와 주세요.

select name as pokemon from pokemon.mypokemon
where name ="pikachu";

#MISSION (4) 포켓몬 테이블에서 모든 포켓몬들의 컬럼과 값 전체를 가져와 주세요.

select * from mypokemon;

#MISSION (5) 포켓몬 테이블에서 모든 포켓몬들의 이름을 가져와 주세요.

select name from mypokemon;