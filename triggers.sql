-- Триггер, проверяющий, можно ли ползователю добавить фильм по возрастному ограничению
delimiter %%
drop trigger if exists age_valid%%
create trigger age_valid before insert on user_list_of_media
for each row 
begin 
	declare restriction VARCHAR(3);
	declare user_age INT; 
	set restriction = (select age_restriction from media where id = new.media_id);
	set user_age = (select TIMESTAMPDIFF(year, birthday, NOW()) from profile where id = new.profile_id);

	if cast(left(restriction, 2) as unsigned) > user_age then
	
	signal sqlstate '45000' set MESSAGE_TEXT = 'Данный видеоматериал не предназначен вам для просмотра';

	end if;
end %%
delimiter ;
select * from profile;
select * from media;
insert into user_list_of_media (profile_id, media_id) values (104,1);

select * from media_types mt;
select * from media;
-- Триггер, запрещающий ставить возраст в будущем

delimiter &&
drop trigger if exists age_check&&
create trigger age_check before insert on profile
for each row
begin 
	if new.birthday > current_date() then 
	set new.birthday = current_date();
	end if;
	
end&&
