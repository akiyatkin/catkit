{LIST:}
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/">Главная</a></li>
		<li class="active breadcrumb-item">Шаблоны цен</li>
	</ol>
	<h1>Шаблоны для цены в каталоге</h1>
	{data.list::name}
	{name:}<a href="/{crumb}/{producer_nick}/{article_nick}">{producer} {article}</a>{Цена?:cost}<br>
	{cost:} &mdash; {~cost(Цена)}&nbsp;руб.
{extend::}-catalog/extend.tpl
{ITEM:}
	{data:show}
		{show:}
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="/">Главная</a></li>
			<li class="breadcrumb-item"><a href="/{crumb.parent}">Шаблоны цен</a></li>
			<li class="active breadcrumb-item">{pos.producer} {pos.article}</li>
		</ol>
	
		<h1>{pos.producer} {pos.article}</h1>
		<div class="row">
			<div class="col-sm-6 col-md-4">
				<pre><code>pos:extend.priceblockbig</code></pre>
				<div class="border p-3 my-3">
					{pos:extend.priceblockbig}
				</div>
				<pre><code>pos:extend.price</code></pre>
				<div class="border p-3 my-3">
					{pos:extend.price}
				</div>
				<code><pre>pos:extend.priceblock</pre></code>
				<div class="border p-3 my-3">
					{pos:extend.priceblock}
				</div>
				
				<code><pre>:extend.unit</pre></code>
				<div class="border p-3 my-3">
					{:extend.unit}
				</div>

				<code><pre>:extend.pricerow</pre></code>
				<div class="border p-3 my-3">
					{pos:extend.pricerow}
				</div>

				<code><pre>:extend.itemcost</pre></code>
				<div class="border p-3 my-3">
					{pos:extend.itemcost}
				</div>
				
			</div>
		</div>