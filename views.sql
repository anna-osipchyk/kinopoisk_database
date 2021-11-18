-- представление "Платные фильмы"
create view toll_films
as select name, age_restriction,price, types 
from media
join media_types mt
on types = 'Фильмы' and is_for_free = 0
where price > 0 and media_types_id in
(select id from media_types where is_for_free = 0 and types = 'Фильмы');


-- представление "Все совершеннолетние женщины-вип пользователи"
create view adult_vip_women
as
select u.name, u.surname, p.birthday
from users u 
join profile p 
on u.id = p.user_id 
where p.gender = 'Ж'
and p.is_vip = 1
and TIMESTAMPDIFF(year, p.birthday, NOW()) > 17;


-- представление " Топ 5 самых новых фильмов"

create view the_newest_films as
select m.name, m.year_of_release, m.media_types_id 
from media m 
join media_types mt 
on mt.id =m.media_types_id 
where mt.types = 'Фильмы'
order by year_of_release limit 5;


-- представление "Все категории и скидки на них, что еще действуют"

insert into discounts (on_what_media_types_id, percent_of_discount, starts_at, ends_at) 
values (25, 15, '2019-10-10', '2022-10-10');

create view still_lasting_discounts
AS
select mt.types, d.percent_of_discount, d.ends_at 
from media_types mt 
join discounts d 
on d.on_what_media_types_id = mt.id 
where TIMESTAMPDIFF(year, d.ends_at , NOW()) < 0;


-- представление "10 самых богатых впи-пользователей"
create view the_wealthiest_vip_users
as
select u.name, u.surname, p.money as cash
from users u 
join profile p 
on p.user_id = u.id 
where p.is_vip = 1
order by cash desc 
limit 10;
