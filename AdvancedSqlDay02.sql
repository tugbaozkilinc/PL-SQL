--CONSTANT
do $$
declare
	price constant numeric(2,1) := 0.5;
	fee numeric := 20;
begin
	raise notice 'Sale price is %', price*(10+fee);
	--price := 0.05; kabul etmez, final keyword gibi ilk atama degerini degistiremeyiz.
end $$;

--constant bir ifadeye run time da deger verebiliriz
do $$
declare
	start_at constant time :=now();
begin
	raise notice 'Running time of block is %', start_at;
end $$;

--CONTROL STRUCTURES
--IF STATEMENT
--syntax:
if condition then 
	statement;
end if;

--Task: 1 id li filmi bulalım eğer yoksa ekrana uyarı yazısı verelim
do $$
declare
	film_looked_for film%rowtype;
	choosen_id film.id%type :=1;
begin
	select * into film_looked_for from film where id=choosen_id;
	raise notice 'The film name whose id is % is % and the kind of it is % and the length of it is % ', film_looked_for.id, film_looked_for.title, film_looked_for.type, film_looked_for.length;
	if not found then
		raise notice 'The film whose id % you looked for has not been found', choosen_id;
	end if;
end $$;

--IF-THEN-ELSE
--syntax:
if condition then --if found then/if not found then 
	statement;
else
	alternative statement;
end if;

--Task: 1 id li film varsa title bilgisini yazınız yoksa uyarı yazısını ekrana basınız
do $$
declare
	the_film film%rowtype;
	the_id film.id%type :=1;
begin 
	select * from film into the_film where id=the_id;
	if not found then 
		raise notice 'The film whose id is % that you looked for has not been found', the_id;
	else
		raise notice 'The title of film whose id is % is %', the_id, the_film.title;
	end if;
end $$;

--IF-THEN-ELSE-IF
--syntax:
if condition-1 then 
	statement-1;
elseif condition-2 then
	statement-2;
elseif condition-3 then
	statement-3;
else
	statement-final;
end if;

--Task: 1 id li film varsa; süresi 50 dakikanın altında ise Short, 50<length<120 ise Medium, length>120 ise Long yazalım
do $$
declare
	film_object film%rowtype;
	film_id film.id%type :=2;
	description varchar(50);
begin
	select * from film into film_object where id=film_id;
	if not found then 
		raise notice 'The film whose id is % you looked for has not been found', film_id;
	else
		if film_object.length>0 and film_object.length<=50 then 
			description='Short';
		elseif film_object.length>50 and film_object.length<=120 then 
			description='Medium';
		elseif film_object.length>120 then 
			description='long';
		else 
			description='Undefined';
		end if;
	raise notice 'The time of % is %', film_object.title, description;
	end if;
end $$;

--CASE STATEMENT
--syntax:
CASE search-expression
	WHEN expression_1 [, expression_2,..] THEN statement
[..]
[ELSE
	 else-statement]
END case;

--Task: (1 id li)Filmin türüne göre çocuklara uygun olup olmadığını ekrana yazalım
do $$
declare
	warning varchar(50);
	kind film.type%type;
begin
	select type into kind from film where id=1;
	if found then
		case kind 
			when 'Korku' then warning='It is not suitable for kids';
			when 'Macera' then warning='It is suitable for kids';
			when 'Animasyon' then warning='It is advisable for kids';
		else 
			warning='Undefined';
		end case;
	raise notice '%', warning;
	end if;				
end $$;

--2. yol
do $$
declare
	film_object film%rowtype;
	film_id film.id%type :=1;
	description varchar(50);
begin
	select * from film into film_object where id=film_id;
	if found then
		case film_object.type
			when 'Korku' then description='It is not suitable for kids';
			when 'Macera' then description='It not suitable for kids';
			when 'Animasyon' then description='It is advisable for kids';
		else
			description :='Undefined';
		end case;
	raise notice '%', description;	
	else
		raise notice 'The film whose id is % you looked for has not been found', film_id;	
	end if;
end $$;















