<?php
use infrajs\event\Event;
use infrajs\path\Path;
use akiyatkin\showcase\Showcase;
use akiyatkin\showcase\Prices;
use infrajs\cart\Cart;
use akiyatkin\catkit\Catkit;

//showcase.php
	Event::handler('Showcase-catalog.onload', function ($obj) {
		$pos = &$obj['pos'];
		if (empty($pos['more']['Комплект'])) return; //Комплект к которому относится позиция
		$r = Catkit::explode($pos['more']['Комплект']);
		$pos['more']['kits'] = Catkit::implode($r,',');//kits комплекты в правильной записи
	});

	Event::handler('Showcase-priceonload', function () {
		//Нужно посчитать комплекты для всех позиций по умолчанию
		//Есть Комлпектация и нет Цены
		$mark = Showcase::getDefaultMark();
		$mark->setVal(':more.Комплектация.yes=1:count=5000');
		$md = $mark->getData();
		$data = Showcase::search($md);
		foreach ($data['list'] as $pos) {
			//Позиции у которых есть Комплектация, были найдены и для них рассчиталась цена, которую и нужно записать в цену по умаолчанию.
			//Event::fire('Showcase-position.onsearch', $pos);
			//$r = Catkit::init($pos);
			//if (!$r) continue;
			Prices::deleteProp($pos['model_id'], $pos['item_num'], 'Цена');
			if (isset($pos['Цена'])) Prices::insertProp($pos['model_id'], $pos['item_num'], 'Цена', $pos['Цена']);
		}
	});

Event::handler('Showcase-position.onsearch', function (&$pos){

	if (!empty($pos['catkit'])) {
		$catkit = $pos['catkit'];
		$pos['iscatkit'] = true; //Если новый catkit ec
	} else {
		if (empty($pos['Комплектация'])) return false;
		$catkit = $pos['Комплектация'];
	}
	
	$emptycat = [];
	$emptycost = [];
	$find = [];
	$r = Catkit::explode($catkit);
	$cost = 0;
	$kit = [];
	foreach ($r as $res) {
		$article_nick = $res['article_nick'];
		$item_nick = $res['item_nick'];
		$producer_nick = $pos['producer_nick'];
		$p = Showcase::getModel($producer_nick, $article_nick, $item_nick);
		if (!$p) {
			$emptycat[] = $res['present'];
			continue;
		} else if (empty($p['Цена'])) {
			$emptycost[] = $res['present'];
			$p['Цена'] = false;
			//continue;
		}
		$find[] = $res['present'];
		$kit[] = $p;

		
		$cost += $p['Цена'];
		
	}
	
	//if ($cost) {
	$pos['catkit'] = Catkit::implode($kit);
	$pos['catkits'] = explode('&',$pos['catkit']);
	$pos['Комплектация'] = Catkit::present($kit);
	$pos['Цена'] = $cost;
	$pos['kit'] = $kit;

	if ($emptycat) {
		$pos['more']['Нет информации по комплектующим'] = implode(', ', array_unique($emptycat));
	} else {
		unset($pos['more']['Нет информации по комплектующим']);
	}
	if ($emptycost) {
		$pos['more']['Нет цены по комплектующим'] = implode(', ', array_unique($emptycost));
	} else {
		unset($pos['more']['Нет цены по комплектующим']);
	}
		//return true;
	//} else {
		//var_dump($pos['Комплектация']);
		//exit;	
		//if (!empty($pos['iscatkit'])) {
		//	unset($pos['catkit']);
		//	unset($pos['iscatkit']);
			//Event::fire('Showcase-position.onsearch', $pos);
		//}
		//return false;
	//}
});

Event::handler('Showcase-position.onsearch', function (&$pos){

	if (empty($pos['kit'])) return; 
	
	//Ищем картинки если есть выбранный kit
	//Свойство kit содержит массив созданный из Комплектации это выбранные комплектующие
	setKitPhoto($pos);
});

Event::handler('Showcase-position.onshow', function (&$pos){
	if (empty($pos['kits'])) return;
	//Наполняем комплекты, к которым подходит текущая позиция
	$kits = Catkit::explode($pos['kits']);
	$pos['kits'] = array_map( function ($row) use ($pos) {
		$producer_nick = $pos['producer_nick'];
		$article_nick = $row['article_nick'];
		$item_nick = $row['item_nick'];
		return Showcase::getModel($producer_nick, $article_nick, $item_nick);
	}, $kits);
});
Event::handler('Showcase-position.onshow', function (&$pos){	
	//Проверяем у кого есть комплектующие
	$kit = Catkit::implode([$pos]);
	$mark = Showcase::getDefaultMark();
	$mark->setVal(':more.kits.'.$kit.'=1:count=50');
	$md = $mark->getData();
	$data = Showcase::search($md);
	if (empty($data['list'])) return;
	
	$pos['kitlist'] = array_reduce($data['list'], function ($carry, $p) {
		if (empty($p['Группа в комплекте'])) $p['Группа в комплекте'] = '';		
		if(empty($carry[$p['Группа в комплекте']])) $carry[$p['Группа в комплекте']] = [];
		$p['kitid'] = $p['article_nick'].($p['item_nick']?(':'.$p['item_nick']):'');
		$carry[$p['Группа в комплекте']][] = $p;

		return $carry;
	},[]);

	
	if (empty($pos['kitlist'])) unset($pos['kitlist']);
	setKitPhoto($pos);
});

function setKitPhoto(&$pos) {

	/*
		Если есть выбранные комплектации, то по одной фото каждого комплектующего добавляется в систему в добавленном порядке. В showcase.json добавлен параметр для групп firstkitphoto, в нём указывается "Группа в комплекте" фото комплектующих из этой группы встаёт на первое место. Но не выше, чем собственное фото системы.
	*/
	
	if (isset($pos['kit'])) {
		$group = Showcase::getGroup($pos['group_nick']);
		$firstkitphoto = empty($group['showcase']['firstkitphoto']) ? '' : $group['showcase']['firstkitphoto'];
		$images = [];
		if ($firstkitphoto) {
			$kitlist = array_reduce($pos['kit'], function ($carry, $p){
				if (empty($p['Группа в комплекте'])) $p['Группа в комплекте'] = '';
					
				if(empty($carry[$p['Группа в комплекте']])) $carry[$p['Группа в комплекте']] = [];
				$carry[$p['Группа в комплекте']][] = $p;
				return $carry;
			},[]);	
			if (isset($kitlist[$firstkitphoto])) { //и есть выбранный главный компонент
				foreach ($kitlist[$firstkitphoto] as $p) { //Берём фото главного
					if (empty($p['images'])) continue;
					$images[]= $p['images'][0];
				}
			}
		}
		foreach ($pos['kit'] as $p) { //Берём фото остальных
			if (empty($p['images'])) continue;
			$images[]= $p['images'][0];
		}

		if (empty($pos['images'])) $pos['images'] = [];
		$pos['images'] = array_unique(array_merge($pos['images'], $images));
	}
}