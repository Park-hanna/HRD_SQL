/*MISSION
공격력과 방어력의 합이 120보다 크면 ‘very strong’, 90보다 크면 ‘strong’,
모두 해당 되지 않으면 ‘not strong’를 반환하는 함수 ‘isStrong’을 만들고 사용해주세요.
조건1: attack과 defense를 입력값으로 사용하세요.
조건2: 결과값 데이터 타입은 VARCHAR(20)로 해주세요.*/

use pokemon;

set global log_bin_trust_function_creators = 1;

DELIMITER //
create function isStrong(attack int ,defense int)
	returns varchar(20)
begin
	declare a int;
    declare b int;
    declare isstrong varchar(20);
    set a = attack;
    set b = defense;
	select case
			when a + b >= 120 then 'very strong'
            when a + b >= 90 then 'strong'
            else 'not strong'
		end into isstrong;
        return isstrong;
  end  
//
DELIMITER ;

select name,isStrong(attack, defense) as isStrong
from mypokemon;
