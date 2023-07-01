# 데이터 전처리
use pokemon;

create table mypokemon(
	number Int,
    name varchar(20),
    type varchar(20),
    height float,
    weight float,
    attack int,
    defense int,
    speed int
);

INSERT INTO mypokemon(number, name, type, height, weight, attack, defense, spped)
VALUES (10, "caterpie", "bug", 0.3, 2.9, 30,35, 45),
	   (25, "pikachu", "electric", 0.4, 6, 55, 40, 90),
       (26, "raichu", "electric", 0.8, 30, 90, 55, 110),
       (133, "eevee", "normal", 0.3, 6.5, 55, 50, 55),
       (152, "chikorita", "grass", 0.9, 6.4, 49, 65,45);