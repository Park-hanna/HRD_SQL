use pokemon;

alter table mypokemon rename myoldpokemon;

alter table mypokemon
change column e_name eng_name varchar(20),
change column num number int;
alter table mypokemon drop column k_name;

use mynewpokemon;
alter table mynewpokemon
change column k_name kor_name varchar(20),
change column num number int;
alter table mynewpokemon drop column e_name;