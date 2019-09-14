<?php
use infrajs\event\Event;
use infrajs\path\Path;
use akiyatkin\showcase\Showcase;
use akiyatkin\showcase\Prices;


Event::handler('Showcase-priceonload', function () {
	//Нужно посчитать комплекты для всех позиций по умолчанию
	//Есть Комлпектация и нет Цены
	$mark = Showcase::getDefaultMark();
	//$mark->setVal(':more.Цена.no=1:more.Комплектация.yes=1:count=5000');
	$mark->setVal(':more.Комплектация.yes=1:count=5000');
	$md = $mark->getData();
	$data = Showcase::search($md);
	foreach($data['list'] as $pos) {
		$r = explode(',', $pos['Комплектация']);
		$cost = 0;
		$model_id = $pos['model_id'];
		$item_num = $pos['item_num'];
		$emptycat = [];
		$emptycost = [];
		$find = [];
		$kit = [];
		foreach ($r as $k => $art) {
			$art = trim($art);
			$art_nick = Path::encode($art);
			$producer_nick = $pos['producer_nick'];
			$p = Showcase::getModel($producer_nick, $art_nick);
			if (!$p) {
				$emptycat[] = $art;
				continue;
			} else if (empty($p['Цена'])) {
				$emptycost[] = $art;
				continue;
			}
			$kit[] = $p;
			$cost += $p['Цена'];
			$find[] = $art;
		}
		Prices::deleteProp($model_id, $item_num, 'Комплектация для расчёта цены');
		if ($find) {
			Prices::insertProp($model_id, $item_num, 'Комплектация для расчёта цены', implode(', ', $find));
		}

		Prices::deleteProp($model_id, $item_num, 'Нет цены по комплектующим');
		if ($emptycost) {
			Prices::insertProp($model_id, $item_num, 'Нет цены по комплектующим', implode(', ', $emptycost));
		}

		Prices::deleteProp($model_id, $item_num, 'Нет информации по комплектующим');
		if ($emptycat) {
			Prices::insertProp($model_id, $item_num, 'Нет информации по комплектующим', implode(', ', $emptycat));
		}
		//Нельзя записывать цену, ненайдены комплектующие
		Prices::deleteProp($model_id, $item_num, 'Цена');
		if (!$emptycost && !$emptycat) Prices::insertProp($model_id, $item_num, 'Цена', $cost);
	}
});



Event::handler('Showcase-position.onsearch', function (&$pos){
	if (empty($pos['Комплектация'])) return;
	$r = explode(',', $pos['Комплектация']);
	$cost = 0;
	$emptycat = [];
	$emptycost = [];
	$find = [];
	$kit = [];
	foreach ($r as $k => $art) {
		$art = trim($art);
		$art_nick = Path::encode($art);
		$producer_nick = $pos['producer_nick'];
		$p = Showcase::getModel($producer_nick, $art_nick);
		if (!$p) {
			$emptycat[] = $art;
			continue;
		} else if (empty($p['Цена'])) {
			$emptycost[] = $art;
			continue;
		}
		$kit[] = $p;
		$cost += $p['Цена'];
		$find[] = $art;
	}
	$pos['kit'] = $kit;
	$pos['Цена'] = $cost;

	if ($find) $pos['more']['Комплектация для расчёта цены'] = implode(', ', $find);
	if ($emptycat) $pos['more']['Нет информации по комплектующим'] = implode(', ', $emptycat);
	if ($emptycost) $pos['more']['Нет цены по комплектующим'] = implode(', ', $emptycost);
	
});