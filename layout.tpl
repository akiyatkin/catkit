{extend::}-catalog/extend.tpl
{PRESENT:}
	{data:show}
	<script type="module">
		(async () => {
			let Load = (await import('/vendor/akiyatkin/load/Load.js')).default;
			let Catkit = await Load.on('import default', '/vendor/akiyatkin/catkit/Catkit.js');
			let layer = Controller.ids[{id}]; //Слоя может не быть в точке входа
			if (layer && layer.counter != {counter}) return; 

			let div = document.getElementById('{div}');	
			Catkit.hand(div);
		})();
	</script>
	{show:}
	<div>
		<!--<div class="mt-2">Комплектация<br>
			<b>{pos.article}</b>
		</div>-->
		<hr>
		{~length(pos.kit)?:showkits}
		<div class="d-flex justify-content-between"><div>Рекомендуемая цена:&nbsp;</div><div>{pos:extend.itemcost}</div></div>
		<div class="between mt-2">
			{pos:extend.basketrow}
		</div>
	</div>
	{showkits:}
		{pos.kit::groups}
		<hr>
{groups:}
	{::showkit}
{showkit:}
	<div class="mt-2 clearfix">
		<div class="d-flex justify-content-between">
			<div style="white-space:nowrap; display:block; overflow:hidden; text-overflow: ellipsis;">
				<a onclick="Ascroll.go('#kitlist'); return false;" data-crumb="false" href="/{Controller.names.catalog.crumb}/{producer_nick}/{article_nick}/{item_nick}">{Наименование}</a>
			</div>
			<div>
				<span {....iscatkit??:deftitle} 
					class="{....iscatkit??:disabled} btn btn-sm btn-outline-warning catkit-ico catkit del ml-2"
					data-crumb="false" 
					onclick="return false"
					data-article_nick="{article_nick}" 
					data-item_nick="{item_nick}"

				><i class="fas fa-times"></i></span>
			</div>
		</div>

		
		<div style="display: flex;">
			<div>
				<img class="mr-1" width="40" src="/-imager?src={images.0}&w=40">
			</div>
			<div style="flex-grow: 1; min-width:0">
				<div style="white-space:nowrap; overflow:hidden; text-overflow: ellipsis;">
					{article}
				</div>
				<div style="white-space:nowrap; overflow:hidden; text-overflow: ellipsis;">
					{item}
				</div>
				<div title="Рекомендуемая цена" class="text-right ml-2">{Цена?:extend.itemcost}</div>
			</div>
		</div>
		
		
		
	</div>
	{deftitle:} title="Комплектация по умолчанию" 