<?php
use infrajs\event\Event;
use infrajs\path\Path;
use akiyatkin\showcase\Showcase;
use akiyatkin\showcase\Prices;
use infrajs\cart\Cart;
use akiyatkin\catkit\Catkit;


Event::handler('Showcase-catalog.onload', function ($obj) {
	$pos = &$obj['pos'];
	if (empty($pos['more']['Комплект'])) return;
	$r = Catkit::explode($pos['more']['Комплект']);
	$pos['more']['kits'] = Catkit::implode($r);
});
Event::handler('Showcase-priceonload', function () {
	//Нужно посчитать комплекты для всех позиций по умолчанию
	//Есть Комлпектация и нет Цены
	$mark = Showcase::getDefaultMark();
	//$mark->setVal(':more.Цена.no=1:more.Комплектация.yes=1:count=5000');
	$mark->setVal(':more.Комплектация.yes=1:count=5000');
	$md = $mark->getData();
	$data = Showcase::search($md);
	foreach($data['list'] as $pos) {
		$r = Catkit::init($pos);
		if (!$r) continue;
		Prices::deleteProp($pos['model_id'], $pos['item_num'], 'Цена');
		if (isset($pos['Цена'])) Prices::insertProp($pos['model_id'], $pos['item_num'], 'Цена', $pos['Цена']);
	}
});



Event::handler('Showcase-position.onsearch', function (&$pos){
	Catkit::init($pos);
});

Event::handler('Showcase-position.onshow', function (&$pos){
	if (empty($pos['kits'])) return;
	$kits = Catkit::explode($pos['kits']);
	$pos['kits'] = array_map( function ($row) use ($pos) {
		$producer_nick = $pos['producer_nick'];
		$article_nick = $row['article_nick'];
		$item_nick = $row['item_nick'];
		return Showcase::getModel($producer_nick, $article_nick, $item_nick);
	}, $kits);
	return;
	$mark = Showcase::getDefaultMark();
	
	//$mark->setVal(':more.kits.'.$kit.'=1:count=50');
	$mark->setVal(':more.kits.yes=1:count=50');
	$md = $mark->getData();
	echo $kit;
	echo '<pre>';
	$data = Showcase::search($md);
	print_r($data);
	exit;
	//kitlist
});