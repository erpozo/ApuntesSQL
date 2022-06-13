/*En españa no se habla "Spanish", se habla espaÑol*/
update world.countrylanguage
set world.countrylanguage.Language = "Español"
where world.countrylanguage.Language = "Spanish";

update world.country
set world.country.Name = "España"
where world.country.Name = "Spanish";

Select
	world.country.Name as "En españa",
    world.countrylanguage.Language as "se habla"
from world.country
	left join world.countrylanguage on world.country.Code = world.countrylanguage.CountryCode<
where world.country.Name = "España";