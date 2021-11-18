-- Процедура, позволяющая за определенную плату делать аккаунт пользователя vip

drop procedure if exists make_vip_acc;

delimiter %%
create procedure make_vip_acc(in for_user_id BIGINT)
	begin
		
		declare is_he_vip BOOL;
		declare cash_statement DECIMAL;
		set is_he_vip = (select is_vip from profile where user_id = for_user_id);
		set cash_statement = (select money from profile where user_id = for_user_id);

		if is_he_vip = 0 then
		select 'Вы и так вип пользователь';
		end if;
	
	
		if cash_statement < 1000 then
		select 'У вас недостаточно средств';
		else
		update profile 
		set money = money - 1000
		where user_id = for_user_id;
		update profile 
		set is_vip = 1
		where user_id = for_user_id;
		select 'Операция успешно завершена';
		end if;
	
		
	end %%
delimiter ;

select * from profile p;
call make_vip_acc(105);
 

-- Процедура, позволяющая добавить медиа по названию к себе
drop procedure if exists add_media;

delimiter %%
create procedure add_media(in for_user_id BIGINT, for_media_name VARCHAR(50))
	begin

		declare price_us DECIMAL;
		declare media_name_id BIGINT;
		declare user_cash DECIMAL;
	
		set media_name_id = (select id from media where name = for_media_name);
		set price_us = (select price from media where name = for_media_name);

		if isnull (media_name_id) then
		select 'Такого фильма не существует';

		elseif price_us = 0 then
		select 'Фильм успешно добавлен';
		insert into user_list_of_media values((select id from profile where user_id = for_user_id), media_name_id, NOW());
		
		elseif price_us > 0 then
		
			set user_cash = (select money from profile where user_id = for_user_id);
		
			select 'Данный фильм платный';
			
			if user_cash >= price_us then
			
			update profile 
			set money = money - price_us
			where user_id = for_user_id;
		
			insert into user_list_of_media 
			values((select id from profile where user_id = for_user_id), media_name_id, NOW());
			select 'Фильм успешно добавлен';
		
			else
			select 'У вас недостаточно средств';
			end if;
		end if;
		
	end %%
delimiter ;
truncate user_list_of_media;
select * from media;
call add_media(105, 'До встречи с тобой');

select * from profile;
select *from user_list_of_media where profile_id = (select id from profile where user_id = 101);
select * from user_list_of_media ulom ;
