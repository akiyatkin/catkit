{orig::}vendor/infrajs/cart/basket.tpl
{root:}{:orig.root}
{props:}
	<table class="props">
		<tr>
			<td class="d-flex"><nobr class="d-none d-sm-block">Производитель:</nobr><div class="line"></div></td><td>{producer}</td>
		</tr>
		<tr>
			<td class="d-flex"><nobr class="d-none d-sm-block">Артикул:</nobr><div class="line"></div></td><td>{article}{item:pr}</td>
		</tr>
		{kit?:trkit}
	</table>
	{trkit:}
		<tr>
			<td class="d-flex"><nobr class="d-none d-sm-block">Комплектация:</nobr><div class="line"></div></td>
			<td style="font-size:12px">
				{kit::kitprops}
			</td>
		</tr>
	{cat::}-catalog/cat.tpl
	{kitprops:}
		{::kitp}
		{kitp:}
		<div class="mb-1">{Наименование}<br><a href="/{:cat.pospath}">{article}{item:pr}</a> <div class="float-right ml-1">{Цена?:orig.extend.itemcost}</div></div>
{pritem:}
	<p>
		{Наименование} {producer} {article}{item:pr}{kit?:addkit}<br><b>{count}</b> по <b>{~cost(cost)}&nbsp;руб.</b> = <b>{~cost(sum)}&nbsp;руб.</b>
	</p>
{pr:} {.}
{addkit:} ({kit::prkit})
{prkit:}{::prkitnow}{prkitnow:}{article}{~last()??:comma}
{comma:}, 
{slpr:}/{.}
{ORDER:}{:orig.ORDER}