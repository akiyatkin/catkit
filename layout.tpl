{extend::}-catalog/extend.tpl
{rowCONTENTandCOLUMN:}
	<section class="container">
		<style>
			@media (max-width: 991px) {
				body.hiddenoverflow {
					overflow: hidden;
				}
				#{div} .boomrow {
					display: block;
				}
				#CONTENT {
					max-width:100%;
				}
				#COLUMN {
					position: sticky;
					bottom:0;
					background-color: white;
				    padding-right: 0px;
				    padding-left: 0px;
				    margin-right: auto;
				    margin-left: auto;
				    z-index:100;
				    box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.5);
				}
				#COLUMN.show {
					border: none;
					box-shadow:none;
					position: fixed;
					bottom: 0;
					left:0; 
					right:0;
					height:100%;
				   
				}
			}
		</style>

		<div class="row boomrow">
			<div class="col-lg-8 col-xl-8" id="CONTENT"></div>
			<div class="col-lg-4 col-xl-4" id="COLUMN"></div>
		</div>
	</section>
{CATKITPRESENT:}
	<div>
		<style>
			#{div} .openinfo {
				display:none;
				/*visibility: hidden;*/
			}
			@media (max-width: 991px) {
				
				#{div} .openinfo {
					/*visibility: visible;*/
					display:inline-block;
				}
				#{div} .openinfo.show {
					display:none;
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
			let Catkit = await Load.on('import-default', '/vendor/akiyatkin/catkit/Catkit.js');
			
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
	{kitopen:}Показать комплектацию
	{posopen:}Навигация по описанию
	{show:}
	<div>
		<div class="mb-1 d-flex flex-column flex-md-row justify-content-between">
			
			<div class="order-2 order-md-1"><b>{pos.Наименование} {pos.article} {pos.item}</b></div>
			<div class="order-1 order-md-2 text-right">
				<nobr class="mb-1 mb-md-0 a openinfo" style="color:red">
					{~length(pos.kit)?:kitopen?:posopen}
				</nobr>
			</div>
		</div>
		<div class="biginfo">

			{~length(pos.kit)?:showkits}
		</div>
		{~length(pos.kit)?:showkitcost?:showposcost}
		<div class="between mt-2">{pos:extend.basketrow}</div>
	</div>
	{showposcost:}
		<div class="d-flex justify-content-between align-items-end"><div>Официальная цена:&nbsp;</div><div>{pos:extend.itemcost}</div></div>
	{showkits:}
		<div style="overflow-y: auto">
			{pos.kit::groups}
		</div>
	{showkitcost:}
		
		<div class="d-flex justify-content-between align-items-end">
			<!--<div><b class="openinfo">{pos.article} {pos.item}</b></div>-->
			<div>
				<!--<span class="a openinfo" style="color:red">Показать комплектацию</span>-->
				<!--<span class="a closeinfo" style="color:red">Свернуть</span>-->
			</div>
		</div>
		<div class="d-flex justify-content-between align-items-end">
			<div class="text-right text-lg-left flex-grow-1">Цена комплекта ({pos.kitcount}):&nbsp;</div>
			<div><b>{pos:extend.itemcost}</b></div>
		</div>
{groups:}
	{::showkit}
{cat::}-catalog/cat.tpl
{odin:}1
{showkit:}
	<div class="clearfix mb-2">
		<div class="d-flex justify-content-between">
			<div style="white-space:nowrap; display:block; overflow:hidden; text-overflow: ellipsis;">
				<a onclick="//Ascroll.go('#kitlist'); return false;" data-crumb2="false" href="/{Controller.names.catalog.crumb}/{producer_nick}/{article_nick}{item_num!:odin?item_num:cat.slval}">{Наименование}</a>
			</div>
			<div>
				<span {....iscatkit??:deftitle} 
					class="{....iscatkit??:disabled} btn btn-sm btn-outline-warning catkit-ico catkit del ml-2"
					data-crumb="false" 
					onclick="return false"

					data-article_nick="{article_nick}" 
					data-item_num="{item_num}"

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
{COMPATIBILITIES:}
	{~length(compatibilities)?:showCOMPATIBILITIES}
	{showCOMPATIBILITIES:}
		<h2 id="kits">Совместимость</h2>
		<div class="row">
			{compatibilities::prmykit2}
		</div>
		{prmykit2:}{::prmykit}
		{prmykit:}
			<div class="col-sm-4 d-flex align-items-center justify-content-center space" 
				style="
					background-image:url('/-imager/?w=528&src={images.0}'); 
					background-size: contain;
					background-position: center;
					background-repeat: no-repeat;
					color:white;
				">

				<div class="my-5 px-2 py-2" style="text-align:center; width:100%; background-color:rgba(0,0,0,0.5);">{Наименование}<br>
					<a href="/{:cat.pospathadd}{data.pos:cat.kit}{:cat.mark.set}"><b>{article}</b></a>
				</div>
			</div>

{KITLIST:}
	{~length(kitlist)?:showKITLIST}
	{showKITLIST:}
	<h2 id="kitlist">Компоненты</h2>
	{kitlist::kitlistgroup}
	<script async type="module">
		(async () => {
			let iscontext = () => {
				if (!window.Controller) return true;
				let layer = Controller.ids[{id}];
				if (!layer) return true;
				return layer.counter == {counter};
			}

			let Load = (await import('/vendor/akiyatkin/load/Load.js')).default;
			let Catkit = await Load.on('import-default', '/vendor/akiyatkin/catkit/Catkit.js');
			
			if (!iscontext()) return;
			let div = document.getElementById('{div}');	
			Catkit.hand(div);
		})();
	</script>
	{kitlistgroup:}
		<h3>{~key}</h3>
		<div class="row">{::prkit}</div>
		{prkit2:}
			<div class="col-sm-4 d-flex align-items-center justify-content-center space" 
				style="
					background-image:url('/-imager/?w=528&src={images.0}'); 
					background-size: contain;
					background-position: center;
					background-repeat: no-repeat;
					color:white;
				">

				<div class="my-5 px-2 py-2" style="text-align:center; width:100%; background-color:rgba(0,0,0,0.5);">
					
					<span class="{~inArray(kitid,data.pos.catkits)?:font-weight-bold} a catkit add" data-crumb="false" 
					onclick="return false"
					data-article_nick="{article_nick}" 
					data-item_num="{item_num}"
					href="/{crumb}">Добавить</span>
					
					<span class="{~inArray(kitid,data.pos.catkits)??:d-none}"> | 
						<span class="a catkit del" data-crumb="false" 
						onclick="return false"
						data-article_nick="{article_nick}" 
						data-item_num="{item_num}"
						href="/{crumb}">Убрать</span><br></span>

					<span class="a catkit rep" data-crumb="false" 
					onclick="return false"
					data-article_nick="{article_nick}" 
					data-item_num="{item_num}"
					href="/{crumb}">Заменить</span><br>


					{Наименование}<br>
					<a href="/{:cat.pospath}{:cat.mark.set}"><b>{article}</b></a>
				</div>
			</div>
		{prkit:}
			<div class="col-sm-4 space" style="font-size:13px">
				<center><img class="img-fluid" src="/-imager/?h=400&w=400&crop=1&src={images.0}"></center>

				<div >
					<div class="d-flex flex-column" style="min-width:0;">
						<div style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">{Наименование}&nbsp;</div>
						<div style="flex-grow:1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
							<a href="/{:cat.pospath}{:cat.mark.set}">
								<b>{article}</b>
							</a>
						</div>
					</div>
				</div>
				<div class="">
					{~length(items)?items::prkititems?:prkitone}
					


					
				</div>
			</div>
			{prkititems:}
				<div style="flex-grow:1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">{item}</div>
				<div class="text-right">{:extend.itemcost}
					&nbsp;
					<span class="{~inArray(kitid,data.pos.catkits)?:font-weight-bold} catkit add btn btn-sm btn-warning catkit-ico"
					data-article_nick="{...article_nick}" 
					data-item_num="{item_num}"><i class="fas fa-plus"></i></span>
				</div>
				
			{prkitone:}
				<div class="text-right">{:extend.itemcost}
					&nbsp;
					<span class="{~inArray(kitid,data.pos.catkits)?:font-weight-bold} catkit add btn btn-sm btn-warning catkit-ico"
					data-article_nick="{article_nick}" 
					data-item_num="{item_num}"><i class="fas fa-plus"></i></span>
				</div>
{POSCOLUMN:}
	<div class="stick-cont">
		<style>
			#{div} .stick-cont {
				border-right:1px solid rgba(128, 128, 128, 0.3);
				height:100%;

			}

			#{div} .stick {
				position: sticky;
				top:0;
			}
			#{div} .stick-el {
				padding: .75rem 1rem 1rem 0;
				font-size:13px;
				
			}
			#{div} .closeinfo {
				display:none;
			}
			@media (max-width: 991px) {
				#{div} .closeinfo.show {
					display:inline;
				}
				
				#{div} .biginfo {
					display: none;
				}
				#{div} .biginfo.show {
					display: block;
				}
				
				#{div} .stick-cont {
					border-right:none;
				}
				#{div} .stick-el {
					background-color: rgba(255,255,255,1);
					padding: .75rem 15px;
					height: 100%;
    				overflow-y: auto;
				}
				#{div} .stick {
					position: sticky;
					top:auto;
					bottom:0;
				}
			}
		</style>
		<div class="stick-el stick">
			<div class="biginfo mb-3">
				<span style="color:red" class="closeinfo a float-right">Свернуть</span>
				<span class="a" onclick="Ascroll.go('.cat-position')">Общая информация</span><br>
				{~length(compatibilities)?:linkkits}
				{~length(texts)?:linktexts}
				{~length(features)?:linkfeatures}
				{~length(kitlist)?:linkkitlist}
				{~length(Видео с Youtube)?:linkyoutube}
				{~length(files)?:linkfiles}
			</div>
			<div id="CATKITPRESENT"></div>
		</div>
	</div>
	
	<script async type="module">
		let iscontext = () => {
			if (!window.Controller) return true;
			let layer = Controller.ids[{id}];
			if (!layer) return true;
			return layer.counter == {counter};
		}
		let div = document.getElementById('{div}');
		let el = div.getElementsByClassName('stick-el')[0];
		let lastScrollTop = 0;
		window.addEventListener('scroll', () => {
		  	if (!iscontext()) return;
			let eh = el.offsetHeight;
			let wh = window.innerHeight;
			let makeStick = (margin = 0) => {
				el.style.marginTop = 0;
				el.style.top = -margin+'px';
				el.classList.add('stick');
			}
			let makeStatic = () => {
				let top = el.offsetTop;
				el.style.marginTop = top + 'px';
				el.style.top = 0;
				el.classList.remove('stick');
			}
			if (eh < wh) { 
				makeStick(); //Помещается
			} else { //Не помещается
				let st = window.pageYOffset;
				let c = el.getBoundingClientRect();
				let bot = c.height + c.top - wh;
				if (st > lastScrollTop) { // downscroll code
					if (bot <= 0) makeStick(c.height - wh);
					else makeStatic();
				} else { // upscroll code
					if (c.top >= 0) makeStick();
					else makeStatic();
				}
				lastScrollTop = st < 0 ? 0 : st;
			}  

		});
	</script>
	{linkkitlist:}<span class="a" onclick="Ascroll.go('#kitlist')"><b>Компоненты</b></span><br>
	{linkkits:}<span class="a" onclick="Ascroll.go('#kits')">Совместимость</span><br>
	{linktexts:}<span class="a" onclick="Ascroll.go('#texts')">Технические характеристики</span><br>
	{linkfeatures:}<span class="a" onclick="Ascroll.go('#features')">Особенности</span><br>
	{linkyoutube:}<span class="a" onclick="Ascroll.go('#youtubevideo')">Отзывы и видео с Youtube</span><br>
	{linkfiles:}<span class="a" onclick="Ascroll.go('#files')">Файлы</span><br>