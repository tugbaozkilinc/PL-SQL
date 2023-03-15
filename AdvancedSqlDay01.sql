CREATE TABLE film
(
id int, title VARCHAR(50), type VARCHAR(50), length int
);
INSERT INTO film VALUES(1, 'Kuzuların Sessizliği', 'Korku', 130);
INSERT INTO film VALUES(2, 'Esaretin Bedeli', 'Macera', 125);
INSERT INTO film VALUES(3, 'Kısa Film', 'Macera', 40);
INSERT INTO film VALUES(4, 'Shrek', 'Animasyon', 85);

CREATE TABLE actor
(
id int, isim VARCHAR(50), soyisim VARCHAR(50)
);
INSERT INTO actor VALUES(1, 'Christian', 'Bale');
INSERT INTO actor VALUES(2, 'Kevin', 'Spacey');
INSERT INTO actor VALUES(3, 'Edward', 'Norton');

do $$ 
declare
	film_count integer :=0;
begin
	select count(*) --kac tane film varsa sayisini getirir
	into film_count --query den gelen sonucu film_count isimli degiskene atar
	from film;
	raise notice 'The number of films is %', film_count; --% yer tutucu olarak kullanilir
end $$;
--NOTE: $$ isareti zorunlu degildir, ama kodu daha okunakli hale getirir ve noktalama isaretlerinden dolayı olusabilecek karısıklıgı onler. do(anonim method) anonim block olusturuken
--kullanılır, yani degerini dondurur fakat tekrar cagıramazsın(function, procedure gibi programın her yerinden cagıramazsın, cagirmak icin kodu tekrar yazmalisin, db de kaydedilmez)
--raise notice consol a uyari yazdirmak icin kullanilir, sout() gibi dusunebilirsin

--VARIABLES CONSTANT
do $$
declare 
	counter integer :=1;
	first_name varchar(50) :='John';
	last_name varchar(50) :='Doe';
	payment numeric(4,2) :=20.5;
begin
	raise notice '% % % has been paid % USD', counter, first_name, last_name, payment;
end $$;

--Task 1: değişkenler oluşturarak ekrana "Ahmet ve Mehmet beyler 120 tl ye bilet aldılar." cümlesini ekrana basınız
do $$
declare
	first_name varchar(10) :='Ahmet';
	second_name varchar(10) :='Mehmet';
	fee numeric(3) :=120;
begin
	raise notice '% ve % beyler % tl ye bilet aldilar.', first_name, second_name, fee;
end $$;

--BEKLEME KOMUTU
do $$
declare
	created_at time :=now();
begin
	raise notice 'Time is %', created_at;
	perform pg_sleep(10); --10 saniye beklenir
	raise notice 'Time is %', created_at; --ciktida ayni deger gorulur, cunku degiskene atanan time degeri bellidir, degismez.
end $$;

--TABLODAN DATA TYPE I KOPYALAMA
--variable_name table_name.column_name%type; (Tablodaki datanın aynı data türünde variable oluşturmaya yarıyor)
do $$
declare
	film_name film.title%type;
begin
	--1 id li filmin ismini getirelim
	select title from film into film_name where id=1; --select title into film_name from film where id=1;
	raise notice 'Film name whose id is 1 %', film_name;
end $$;

--IC ICE BLOK YAPILARI
do $$
<<outer_block>>
declare
	counter integer :=0;
begin
	counter := counter+1;
	raise notice 'The current value of counter is %', counter;
		<<inner_block>> --optional
		declare
			counter integer :=0; --dis block taki counter i gormedigi icin burda ayni isimle bir variable tanimlayabiliyorum
		begin
			counter := counter+10;
			raise notice 'Counter in the sub block is %', counter;
			raise notice 'Counter in the outer block is %', outer_block.counter;
		end;
	raise notice 'Counter in the outer block is %', counter;
end outer_block $$;	--end $$;

--ROW TYPE
do $$
declare
	selected_actor actor%rowtype; --record, row or object
begin
	select * from actor
	into selected_actor --id, isim, soyisim
	where id=1;
	raise notice 'The actor name is % %', selected_actor.isim, selected_actor.soyisim; --, selected_actor; -> (1,Christian,Bale) 
end $$;

--RECORD TYPE
--Row type gibi calisir ama record in tamami degil de belli basliklari almak istersek kullanilabilir. Performansi arttirir, memory kullanımı acısından faydalıdır.
do $$
declare
	object record;
begin
	select id, title, type into object from film where id=1;
	raise notice '% % %', object.id, object.title, object.type;
end $$;	






