<?php
use infrajs\event\Event;
use infrajs\path\Path;
use akiyatkin\showcase\Showcase;

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