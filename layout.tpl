{extend::}-catalog/extend.tpl
{PRESENT:}
<div class="mt-2"><b>Комплектация</b></div>
{data.pos.kit::groups}
{data.pos:cost}
{cost:}
{min?(show?:extend.showonecost?:extend.showitemscost)?(~length(items)?:extend.showitemonecost?:extend.showonecost)}
{groups:}
	{::showkit}
{showkit:}
{Наименование}<br>
{article}