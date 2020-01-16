{extend::}-catalog/extend.tpl
{CATKITPRESENT:}
	<div>
		<style>
			#{div} .openinfo {
				display:none;
				/*visibility: hidden;*/
			}
			@media (max-width: 991px) {
				body.hiddenoverflow {
					overflow: hidden;
				}
				#{div} .openinfo {
					/*visibility: visible;*/
					display:inline-block;
				}
				#{div} .openinfo.show {
					visibility: hidden;
				}
				
				
			}
		</style>
		{data:show}
	</div>
	<script async type="module">
		let iscontext = () => {
			if (!window.Controller) return true;
			let layer = Controller.ids[{id}];
			if (!layer) return true;
			return layer.counter == {counter};
		}
		let div = document.getElementById('{div}');
		
		let col = document.getElementById('COLUMN');

		let hide = () => {
			col.classList.remove('show');
			document.body.classList.remove('hiddenoverflow');
			var elements = col.getElementsByClassName('biginfo');
			for (let i = 0; i < elements.length; i++) {
				elements[i].classList.remove('show');
			}

			var elements = col.getElementsByClassName('closeinfo');
			for (let i = 0; i < elements.length; i++) {
				elements[i].classList.remove('show');
			}
			var elements = col.getElementsByClassName('openinfo');
			for (let i = 0; i < elements.length; i++) {
				elements[i].classList.remove('show');
			}

		}
		let show = () => {
			col.classList.add('show');
			document.body.classList.add('hiddenoverflow');
			var elements = col.getElementsByClassName('biginfo');
			for (let i = 0; i < elements.length; i++) {
				elements[i].classList.add('show');
			}

			var elements = col.getElementsByClassName('closeinfo');
			for (let i = 0; i < elements.length; i++) {
				elements[i].classList.add('show');
			}
			var elements = col.getElementsByClassName('openinfo');
			for (let i = 0; i < elements.length; i++) {
				elements[i].classList.add('show');
			}
		}
		domready(() => {
			Event.handler('Controller.onshow', () => {
				if (!iscontext()) return;
				if (col.classList.contains('show')) show();
			});	
		});
		
		var elements = col.getElementsByTagName('a');
		for (let i = 0; i < elements.length; i++) {
			elements[i].addEventListener('click', (e) => {
				if (!iscontext()) return;
				hide();
				e.stopPropagation();
			});
		}
		var elements = col.getElementsByClassName('a');
		for (let i = 0; i < elements.length; i++) {
			elements[i].addEventListener('click', (e) => {
				if (!iscontext()) return;
				if (elements[i].classList.contains('openinfo')) show();
				else hide();
				e.stopPropagation();
			});
		}

	</script>
	<script async type="module">
		
	</script>
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
		<div class="biginfo">
			<hr>
			{~length(pos.kit)?:showkits}
		</div>
		{~length(pos.kit)?:showkitcost?:showposcost}
		<div class="between mt-2">{pos:extend.basketrow}</div>
	</div>
	{showposcost:}
		<span class="a openinfo" style="color:red">Меню модели</span>
		<div class="d-flex justify-content-between align-items-end"><div>Официальная цена:&nbsp;</div><div>{pos:extend.itemcost}</div></div>
	{showkits:}
		<div style="overflow-y: auto">
			{pos.kit::groups}
		</div>
	{showkitcost:}
		
		<div class="d-flex justify-content-between align-items-end">
			<div><b class="openinfo">{pos.article} {item}</b></div>
			<div>
				<span class="a openinfo" style="color:red">Показать комплектацию</span>
				<!--<span class="a closeinfo" style="color:red">Свернуть</span>-->
			</div>
		</div>
		<div class="d-flex justify-content-between align-items-end">
			<div class="text-right text-lg-left flex-grow-1">Цена комплекта ({pos.kitcount}):&nbsp;</div>
			<div><b>{pos:extend.itemcost}</b></div>
		</div>
{groups:}
	{::showkit}
{showkit:}
	<div class="clearfix mb-2">
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
			</div>
			<div title="Рекомендуемая цена" class="text-right ml-2">{Цена?:extend.itemcost}</div>
		</div>
		
		
		
	</div>
	{deftitle:} title="Комплектация по умолчанию" 