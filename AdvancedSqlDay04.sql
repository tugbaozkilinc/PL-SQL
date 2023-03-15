--Task: sayac isminde bir degisken olusturun ve dongu icinde sayaci birer artirin, her dongude sayacin degerini ekrana basin ve sayac degeri 5 e esit olunca donguden cikin
do $$
declare
	counter integer :=0;
begin
	loop
		raise notice '%', counter;
		counter := counter+1;
		exit when counter=5;	
	end loop;	
end $$;

--FOR LOOP
--syntax
for loop_counter in [reverse] from..to [by step] loop
    statement;
end loop ;

--Example 1
do $$
begin
    for counter in 1..6 loop --(counter: 1, counter: 2..)
        raise notice 'counter: %', counter;
    end loop;   
end $$;

--Example 2
do $$
begin
    for counter in reverse 5..1 loop
        raise notice 'counter : %', counter;
    end loop;
end $$;

--Example 3
do $$
begin
    for counter in 0..10 by 2 loop
        raise notice 'counter : %', counter;
    end loop;   
end $$;

--Task: 10 dan 20 ye kadar 2 ser 2 ser ekrana sayilari basalim : 
do $$
begin
    for counter in 10..20 by 2 loop
        raise notice 'counter: %', counter ;
    end loop;
end $$;

--Task: olusturulan array'in elemanlarini array seklinde gosterelim : 
do $$
declare
    array_int int[] := array[11, 22, 33, 44, 55, 66, 77, 88];
    var int[];
begin
    for var in select array_int loop
        raise notice '%', var;
    end loop;   
end $$;

-- DB de loop kullanimi
--syntax :
for target in query loop
    statement;
end loop;

-- Task : Filmleri süresine göre sıraladığımızda en uzun 2 filmi gösterelim
do $$
declare
    selected_film record;
begin
    for selected_film in select title, length from film order by length desc limit 2 loop
        raise notice '% (% dakika)', selected_film.title, selected_film.length;
    end loop;
end $$;

CREATE TABLE employees(
  employee_id serial PRIMARY KEY, full_name VARCHAR NOT NULL, manager_id INT
);

INSERT INTO employees(
  employee_id, full_name, manager_id
)
VALUES
  (1, 'M.S Dhoni', NULL),
  (2, 'Sachin Tendulkar', 1),
  (3, 'R. Sharma', 1),
  (4, 'S. Raina', 1),
  (5, 'B. Kumar', 1),
  (6, 'Y. Singh', 2),
  (7, 'Virender Sehwag ', 2),
  (8, 'Ajinkya Rahane', 2),
  (9, 'Shikhar Dhawan', 2),
  (10, 'Mohammed Shami', 3),
  (11, 'Shreyas Iyer', 3),
  (12, 'Mayank Agarwal', 3),
  (13, 'K. L. Rahul', 3),
  (14, 'Hardik Pandya', 4),
  (15, 'Dinesh Karthik', 4),
  (16, 'Jasprit Bumrah', 7),
  (17, 'Kuldeep Yadav', 7),
  (18, 'Yuzvendra Chahal', 8),
  (19, 'Rishabh Pant', 8),
  (20, 'Sanju Samson', 8);
  
--Task: employee ID si en buyuk ilk 10 kisiyi ekrana yazalim 
do $$
declare
    selected_person record;
begin
    for selected_person in select employee_id, full_name from employees order by employee_id desc limit(10) loop
        raise notice '% - %', selected_person.employee_id, selected_person.full_name;
    end loop;
end $$;

--EXIT
exit when counter>10;
--yukardakini if ile yazmak istersem(alttaki ve ustteki kod ayni isi yapiyor)
if counter>10 then 
    exit;
end if;

--Ornek 
do $$
<<outer_block>>
begin
	<<inner_block>>
	begin
		exit inner_block; --bunu raise in altına yazarsan iki yazıyı da consol da gorursun.
		raise notice 'hello from inner block';
	end;
	raise notice 'hello from outer block';
end $$; --yukarıya end $$; yazınca hata veriyor.

--CONTINUE
--mevcut iterasyonu atlamak icin kullanilir
--syntax :
continue [loop_label] [when condition] --[] bu kısımlar opsiyoneldir

--Task: continue yapisi kullanarak 1 dahil 10 a kadar olan tek sayilari ekrana basalim
do $$
declare
    counter integer :=0;
begin
    loop
        counter :=counter+1; --loop icinde counter degerim 1 artiriliyor
        exit when counter>10; --counter degerim 10 dan buyuk olursa loop dan cik
        continue when mod(counter,2)=0; --counter cift ise bu iterasyonu terk et, mod(counter,2)=0 method
        raise notice '%', counter; --counter degerimi ekrana basiyorum
    end loop;
end $$;
--2. yol:
do $$
declare
	counter int :=0;
begin
	while counter<10 loop
		counter:=counter+1;
		continue when mod(counter,2)=0;
		raise notice '%', counter;
	end loop;
end $$;

--FUNCTION
--syntax :
create [or replace] function function_name(param_list)
returns return_type --donen data turunu belirliyorum
language plpgsql --kullanilan prosedurel dili tanimliyor
as    
$$
declare
begin   
end $$;

--Film tablomuzdaki belirli sure arasindaki filmlerin sayisini getiren bir fonsiyon yazalim  
create or replace function find_film_count(length_from int, length_to int)
returns int
language plpgsql
as
$$
declare
	film_count integer;
begin
	select count(*) from film into film_count where length between length_from and length_to;
	return film_count;
end $$;
--Note: ilk defa oluşturacaksan or replace yazmana gerek yok(ama yazarsan garantiye alırsın update ihtimaline karşı), yoksa create et varsa replace

--1.yol: (positional notation) yani parametreleri duzgun sırada girmelisin
select find_film_count(40, 190);  
--2. yol: (named notation)
select find_film_count(   
    length_from:=40,
    length_to:=135
);

--HAZIR METHOD 
select MIN(length) from film;
select MAX(length) from film;
select AVG(length) from film;
select round(AVG(length),2) from film;

--Task: parametre olarak girilen iki sayının toplamını veren sayi toplama adında fonksiyon yazalım
create or replace function sum_two_integer(x int, y int)
returns integer
language plpgsql
as
$$
declare
	sum int :=0;
begin
	sum := x+y;
	return sum;
end $$;
select sum_two_integer(50, 40);

--Odev: Büyük harfle girilen değeri küçük harfle yazılsın ve içerisinde ı,ş,ç,ö,ğ,ü geçen harfleri sırasıyla i,s,c,o,g,u harflerine çeviren bir fonksiyon yazalım
create or replace function turn_into_lower_case(text varchar(100))
returns varchar(100)
language plpgsql
as
$$
declare
	writing varchar(100);
begin
	writing = text;
	writing = lower(writing);
	writing = replace(writing, 'ı', 'i');
	writing = replace(writing, 'ü', 'u');
	writing = replace(writing, 'ş', 's');
	writing = replace(writing, 'ğ', 'g');
	writing = replace(writing, 'ç', 'c');
	writing = replace(writing, 'ö', 'o');
	return writing;
end $$;
select turn_into_lower_case('ĞŞÜASÇIÖ');





  
  
  