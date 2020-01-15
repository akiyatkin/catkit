{extend::}-catalog/extend.tpl
{PRESENT:}
	{data:show}
	<script async type="module">
		(async () => {
			let Load = (await import('/vendor/akiyatkin/load/Load.js')).default;
			let Catkit = await Load.on('import default', '/vendor/akiyatkin/catkit/Catkit.js');
			
			let iscontext = () => {
				if (!window.Controller) return true;
				let layer = Controller.ids[{id}];
				if (!layer) return true;
				return layer.counter == {counter};
			}

			if (!iscontext()) return;
			let div = document.getElementById('{div}');	
			Catkit.hand(div);
		})();
	</script>
	{show:}
	<div>
		<!--<div class="mt-2">Комплектация<br>
			<b>{pos.article}</b>
		</div>-->

		<div class="biginfo">
			<hr>
			{~length(pos.kit)?:showkits}
		</div>
		{~length(pos.kit)?:showkitcost?:showposcost}
		<div class="between mt-2">{pos:extend.basketrow}</div>
	</div>
	{showposcost:}
		<div class="d-flex justify-content-between align-items-end"><div>Официальная цена производителя:&nbsp;</div><div>{pos:extend.itemcost}</div></div>
	{showkits:}
		<div style="overflow-y: auto">
			{pos.kit::groups}
		</div>
		<hr>
	{showkitcost:}
		<div class="d-flex justify-content-between align-items-end"><div>Официальная цена комплекта:&nbsp;</div><div><b>{pos:extend.itemcost}</b></div></div>
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