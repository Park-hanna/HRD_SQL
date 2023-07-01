use pokemon;

create table mynewpokemon(
	num int,
	e_name varchar(20),
    k_name varchar(20),
    p_type varchar(10)
);

insert into mynewpokemon (k_name, num, e_name, p_type)
values ("포니타", 77, "ponitta","flame" ),
		("메타몽",132,"metamong", "normal"),
        ("뮤",151,"mue","esper");
