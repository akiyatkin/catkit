#Как добавлять комплекты
Как добавить 2 комплектующих? просто перечислить.


kemppi/fastmig-m/item_nick&power-source-fastmig-m-320:item_nick&..

prodart = article_nick item_nick&prodart&prodart
prodart = article_nick item_nick
prodart = article_nick


Комплектация - Производитель Артикул item, Производитель Артикул item, Производитель Артикул item
producer_nick article_nick &producer_nick2 article_nick2 item_nick2&producer_nick3 article_nick3 item_nick3&article_nick4



	Группа в комплекте
	Комплект

Showcase-catalog.onload
	kits - Комплект-nick
onpriceload, onsearch
	iscatkit - динамический комплект
	kit - какие комплектующие у меня сейчас
	catkit - &prodart&prodart (Комплектация)
onshow
	kitlist - все варианты которые мне подходят
	kits - в какие комплекты я вхожу


У пользователя в Session хранятся его сформированные Комплектации подменяющие занчения по умолчанию.
search (комплектация не показывается. Цена определяется по комплектации по умолчанию (если её нет в прайсе))
show (Все варианты из колонки "Комплект". Цена определяется по комплектации в сессии)
basket (Цена по подменённой комплектации в позиции со списокм позиции в "kit". Подмена шаблона с данными из kit(cart, print, props)
kit (шаблон на странице позиции с данным из сессии или по умолчанию в колонке)

# Showcase-catalog.onload
# Showcase-position.onsearch
Определяется kit по умолчанию и цена
# В корзине Showcase-position.onsearch
Определяется kit из сессии и цена
# Showcase-position.onshow
Определяется kitlist разбитые по группам в

В параметрах
params.Группа в комплекте {
	"multi":true,
	"filter":false - только отмеченные позиции
}