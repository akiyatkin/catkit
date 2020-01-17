#Установка

Подключить окружение с колонкой для страницы позиции
{
	"tpl":"-catkit/layout.tpl",
	"tplroot":"rowCONTENTandCOLUMN",
	"env":"catkit"
}

Подключение позиции
{
	"myenv":{
		"catkit":true
	},
	"external":"-catalog/position.layer.json"
}
Подключение колонки
"COLUMN":{
	"deep":2,
	"tpl":"-index.tpl",
	"dataroot":"data.pos",
	"tplroot":"POSCOLUMN",
	"jsontpl":"-showcase/api/pos/{crumb.child.name}/{crumb.child.child.name}"
}
Подключение списка комплектующих
"CATKITPRESENT":{
	"external":"-catkit/layer.json"
}

Добавляем примеры
"samples":{
	"external":"-catkit/samples/layer.json"
}

В шаблоне позиции добавляем вывод
{catkit::}-catkit/layout.tpl
{:catkit.COMPATIBILITIES}
{:catkit.KITLIST}


#Как добавлять комплекты
Как добавить 2 комплектующих? просто перечислить в адресе.
kemppi/fastmig-m/item_num/power-source-fastmig-m-320:item_num&...




Showcase-catalog.onload
	kits - Комплект-nick
onpriceload, onsearch
	iscatkit - динамический комплект
	kit - какие комплектующие у меня сейчас
	catkit - &prodart&prodart (Комплектация)
onshow
	kitlist - все варианты которые мне подходят
	kits - в какие комплекты я вхожу

# Фото
Какая группа комплектующих определяет фото указыавется в showcase.json в секции groups в firstkitphoto

# Showcase-catalog.onload
# Showcase-position.onsearch
Определяется kit по умолчанию и цена
# В корзине Showcase-position.onsearch
Определяется kit из сессии и цена
# Showcase-position.onshow
Определяется kitlist разбитые по группам в
