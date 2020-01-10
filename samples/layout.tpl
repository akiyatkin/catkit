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
			<div class="col-md-10 col-lg-8 col-xl-6">

				<pre><code>pos:extend.priceblockbig</code></pre>
				<div class="border p-3 my-3">{pos:extend.priceblockbig}</div>

				<pre><code>pos:extend.price</code></pre>
				<div class="border p-3 my-3">{pos:extend.price}</div>

				<code><pre>pos:extend.priceblock</pre></code>
				<div class="border p-3 my-3">{pos:extend.priceblock}</div>
				
				<code><pre>:extend.unit</pre></code>
				<div class="border p-3 my-3">{:extend.unit}</div>

				<code><pre>:extend.pricerow</pre></code>
				<div class="border p-3 my-3">{pos:extend.pricerow}</div>

				<code><pre>:extend.itemcost</pre></code>
				<div class="border p-3 my-3">{pos:extend.itemcost}</div>

				<code><pre>:extend.basketrow</pre></code>
				<div class="border p-3 my-3">{pos:extend.basketrow}</div>

				<code><pre>:extend.basketrow .between</pre></code>
				<div class="between border p-3 my-3">{pos:extend.basketrow}</div>
				
				<a href="/{Controller.names.catalog.crumb}/{crumb.name}/{crumb.child.name}">{pos.article}</a>
				<div class="border p-3 my-3" style="font-size:14px">
					<div>
						{pos:extend.itemcost}&nbsp;
						<span class="btn btn-sm btn-outline-warning catkit-ico"><i class="fas fa-plus"></i></span>
						<span class="disabled btn btn-sm btn-outline-warning catkit-ico"><i class="fas fa-sync"></i></span>
						<span class="active btn btn-sm btn-outline-warning catkit-ico"><i class="fas fa-minus"></i></span>
						<span class="btn btn-sm btn-warning catkit-ico"><i class="fas fa-plus"></i></span>
						<span class="disabled btn btn-sm btn-warning catkit-ico"><i class="fas fa-sync"></i></span>
						<span class="active btn btn-sm btn-warning catkit-ico"><i class="fas fa-minus"></i></span>

						<span class="btn btn-sm btn-outline-warning catkit-ico"><i class="fas fa-check"></i></span>
						<span class="btn btn-sm btn-warning catkit-ico"><i class="fas fa-times"></i></span>
					</div>
					<p>
						Мультивыбор, Выбор одного<br>
						multi = true, false<br>
						Вырана ли уже текущая опция<br>
						selected = true, false
					</p>
					<table class="table table-sm">
						<tr><td>selected \ multi</td><td>true</td><td>false</td></tr>
						<tr><td>true</td>	
							<td>
								<span class="btn btn-sm btn-warning catkit-ico"><i class="fas fa-plus"></i></span>
								<span class="btn btn-sm btn-warning catkit-ico"><i class="fas fa-minus"></i></span>
							</td>
							<td>
								<span class="btn btn-sm btn-warning catkit-ico"><i class="fas fa-times"></i></span>
							</td>
						</tr>
						<tr><td>false</td>
							<td>
								<span class="btn btn-sm btn-outline-warning catkit-ico"><i class="fas fa-plus"></i></span>
								
							</td>
							<td>
								<span class="btn btn-sm btn-outline-warning catkit-ico"><i class="fas fa-sync"></i></span>
							</td>
						</tr>
						<tr><td>empty</td>
							<td>
								<span class="btn btn-sm btn-outline-warning catkit-ico"><i class="fas fa-plus"></i></span>
							</td>
							<td>
								<span class="btn btn-sm btn-outline-warning catkit-ico"><i class="fas fa-plus"></i></span>
							</td>
						</tr>
					</table>

					
				</div>
			</div>
		</div>