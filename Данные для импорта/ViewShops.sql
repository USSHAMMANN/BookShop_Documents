Select ShopId 'Номер магазина', concat(ShopCity, ', ', ShopStreet, ', ', ShopRegeon) 'Адрес', sum(StoredProductCount) 'Количество товара'
	from storedproducts
    join shops on StoredProductIdShop = ShopId
    group by ShopId;