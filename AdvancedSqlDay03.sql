--Task 1: Film tablosundaki film sayısı 10 dan az ise "Film sayısı az" yazdırın, 10 dan çok ise "Film sayısı yeterli" yazdıralım 
do $$
declare
	film_number integer :=0;
begin
	select count(*) from film into film_number;	
	if (film_number<10) then 
		raise notice 'Film sayısı az';
	else 
		raise notice 'Film sayısı yeterli';
	end if;
end $$;

--Task 2: user_age isminde integer data türünde bir değişken tanımlayıp default olarak bir değer verelim, If yapısı ile girilen değer 18 den büyük ise Access Granted,
--küçük ise Access Denied yazdıralım
do $$
declare
	user_age integer :=18;
begin
	if(user_age>=18) then 
		raise notice 'Access Granted';
	else 
		raise notice 'Access Denied';
	end if;
end $$;

--Task 3: a ve b isimli integer türünde 2 değişken tanımlayıp default değerlerini verelim, eğer a nın değeri b den büyükse "a, b den büyüktür" yazalım, 
--tam tersi durum için "b, a dan büyüktür" yazalım, iki değer birbirine eşit ise "a, b'ye eşittir" yazalım:
do $$
declare
	a integer := 0;
	b numeric := 0;
begin
	if(a>b) then
		raise notice 'a, b den büyüktür';
	elseif(b>a) then 
		raise notice 'b, a dan büyüktür';
	else
		raise notice 'a, b ye eşittir';
	end if;
end $$;

--Task 4: kullaniciYasi isimli bir değişken oluşturup default değerini verin, girilen yaş 18 den büyükse "Oy kullanabilirsiniz", 18 den küçük ise "Oy kullanamazsınız" yazısını yazalım.
do $$
declare
	user_age integer :=18;
begin
	if(user_age>=18) then
		raise notice 'You can vote';
	else 
		raise notice 'You can not vote';
	end if;	
end $$;

--LOOP
--syntax
LOOP
	statement;
	IF condition then
		exit; --loop tan cıkmayı saglar(loop u sonlandırmak icin loop un icinde if yapisi kullanabiliriz	)
	END IF;
END LOOP;

--NESTED LOOP
<<outer>>
LOOP
	statement;
	<<inner>>
	LOOP
		.....
		exit <<inner>>
	END LOOP;
END LOOP;	

--Task: Fibonacci serisinde, belli bir sıradaki sayıyı ekrana getirelim
do $$
declare
	n integer :=3;
	counter integer :=0;
	i integer :=0;
	j integer :=1;
	fib integer :=0;
begin
	if(n<1) then
		fib :=0;
	end if;
	loop
		exit when counter=n;
		counter=counter+1;
		select j, (i+j) into i, j;
	end loop;
	fib :=i;
	raise notice '%', fib;
end $$;

--WHILE LOOP
--syntax;
WHILE condition LOOP
	statement;
END LOOP;

--Task: 1 den 4 e kadar counter değerlerini ekrana basalım
do $$
declare
	counter integer :=0;
	n integer :=4;
begin
	while counter<n loop
		counter=counter+1;
		raise notice '%', counter;
	end loop;	
end $$;
--2. yol:
do $$
declare
	counter integer :=0;
begin
	while counter<4 loop
		counter=counter+1;
		raise notice '%', counter;
	end loop;	
end $$;
--3. yol:
do $$
declare
	counter numeric :=0;
begin
	loop
		exit when counter=4;
		counter=counter+1;
		raise notice '%', counter;
	end loop;	
end $$;
--4. yol:
do $$
declare
	counter numeric :=0;
begin
	loop
		if counter=4 then
			exit;
		end if;	
		counter=counter+1;
		raise notice '%', counter;
	end loop;	
end $$;






