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
	{kitprops:}
		<div class="mb-1">{Наименование}<br><a href="/catalog/{producer_nick}/{article_nick}{item:slpr}">{article}{item:pr}</a> <div class="float-right ml-1">{~cost(Цена)}{:orig.extend.unit}</div></div>
	{pospath:}{producer_nick}/{article_nick}{item_nick?:itnick}
	{itnick:}/{item_nick}
{pritem:}
	<p>
		{Наименование} {producer} {article}{item:pr}{kit?:addkit}<br><b>{count}</b> по <b>{~cost(cost)}&nbsp;руб.</b> = <b>{~cost(sum)}&nbsp;руб.</b>
	</p>
{pr:} {.}
{addkit:} ({kit::prkit})
{prkit:}{article}{~last()??:comma}
{comma:}, 
{slpr:}/{.}
{ORDER:}{:orig.ORDER}