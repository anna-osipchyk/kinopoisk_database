


-- Все платные фильмы
select name, age_restriction,price, types 
from media
join media_types mt
on types = 'Фильмы' and is_for_free = 0
where price > 0 and media_types_id in
(select id from media_types where is_for_free = 0 and types = 'Фильмы');
-- -----------

-- Все фильмы пользователей
select u.name, u.surname, m.name as film_name
from users as u
join profile as p
on p.user_id = u.id
join user_list_of_media as ul
on ul.profile_id = p.id
join media as m 
on ul.media_id = m.id;
-- ------------------


-- Медиа и их награды и категории
select m.name, m.year_of_release, a.name, mt.types 
from media m 
join media_with_awards mwa 
on m.id = mwa.media_id 
join awards a 
on mwa.award_id = a.id
join media_types mt;
-- ----------

-- Очень странно, но как есть.
-- Все категории и скидки на них, если размер скидки > 20% с указанным временным промежутком
select mt.types, d.percent_of_discount
from media_types mt 
join discounts d 
on d.on_what_media_types_id = mt.id 
where d.percent_of_discount > 20
and TIME(d.ends_at) between '1990-10-10' and NOW();
-- -------------------------------


-- Самый богатый вип-пользователь и все его оценки
select u.name, u.surname, MAX(p.money) as cash, r.info as review
from users u 
join profile p 
on p.user_id = u.id 
join rewiew r 
on r.user_id = u.id
where p.is_vip = 1;

