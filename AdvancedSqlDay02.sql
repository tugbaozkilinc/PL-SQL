--CONSTANT
do $$
declare
	whatever constant numeric := 0.1;
	easy numeric := 20.5;
begin
	raise notice 'Sale price: %', easy*(1+whatever);
	--whatever := 0.05; kabul etmez, final keyword gibi ilk atama degerini degistiremeyiz.
end $$;

--constant bir ifadeye run time da deger verebiliriz
do $$
declare
	start_at constant time :=now();
begin
	raise notice 'Running time of block is: %', start_at;
end $$;

--CONTROL STRUCTURES
--IF STATEMENT
--syntax:
/*
	if condition then 
		statement;
	end if;
*/

--Task: 1 id li filmi bulalım eğer yoksa ekrana uyarı yazısı verelim
do $$
declare
	selected_film film%rowtype;
	wanted_film_id film.id%type :=1;
begin
	select * into selected_film from film where id=wanted_film_id;
	raise notice 'The film whose id is % is %', wanted_film_id, selected_film.title;
	if not found then
		raise notice 'The film you looked for has not been found: %', wanted_film_id;
	end if;
end $$;

--IF-THEN-ELSE
--syntax:
/*
	if condition then --if found then/if not found then 
		statement;
	else
		alternative statement;
	end if;
*/

--Task: 1 id li film varsa title bilgisini yazınız yoksa uyarı yazısını ekrana basınız
do $$
declare
	selected_film film%rowtype;
	wanted_id film.id%type :=1;
begin 
	select * from film into selected_film where id=wanted_id;
	if not found then 
		raise notice 'The film you looked for has not been found: %', wanted_id;
	else
		raise notice 'The title of film whose id is % is %', wanted_id, selected_film.title;
	end if;
end $$;

--IF-THEN-ELSE-IF
--syntax:
/*
	if condition-1 then 
		statement-1;
	elseif condition-2 then
		statement-2;
	elseif condition-3 then
		statement-3;
	else
		statement-final;
	end if;
*/

--Task: 1 id li film varsa; süresi 50 dakikanın altında ise Short, 50<length<120 ise Medium, length>120 ise Long yazalım
do $$
declare
	selected_film film%rowtype;
	description varchar(50);
begin
	select * from film into selected_film where id=100;
	if not found then 
		raise notice 'The film you looked for has not been found';
	else
		if selected_film.length>0 and selected_film.length<=50 then description='short';
		elseif selected_film.length>50 and selected_film.length<120 then description='medium';
		elseif selected_film.length>120 then description='long';
		else description='undefined';
		end if;
	raise notice '% filminin suresi: %', selected_film.title, description;
	end if;
end $$;

--CASE STATEMENT
--syntax:
/*
	 CASE search-expression
	 WHEN expression_1 [, expression_2,..] THEN
	 	statement
	 [..]
	 [ELSE
	 	else-statement]
	 END case;
*/

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















