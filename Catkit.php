<?php
namespace akiyatkin\catkit;
use infrajs\path\Path;
use akiyatkin\showcase\Showcase;

class Catkit {
	public static $conf;
	public static function implode($kit, $char = '&') {
		$catkit = [];
		foreach ($kit as $p) {
			$c = $p['article_nick'];
			if ($p['item_nick']) $c .= ':'.$p['item_nick'];
			$catkit[] = $c;
		}
		$catkit = implode($char, $catkit);
		return $catkit;
	}
	public static function explode($catkit) {
		$r = preg_split('/[&,]/', $catkit);
		$catkit = array_map(function ($catkit){
			$r = explode(':', $catkit);
			$res = [];
			$res['present'] = trim($catkit);
			$res['article_nick'] = Path::encode($r[0]);
			if (!empty($r[1])) $res['item_nick'] = Path::encode($r[1]);
			else $res['item_nick'] = '';
			return $res;
		}, $r);
		return $catkit;
	}
	public static function present($kit) {
		$catkit = [];
		foreach ($kit as $p) {
			$c = $p['article'];
			if ($p['item']) $c .= ':'.$p['item'];
			$catkit[] = $c;
		}
		$catkit = implode(', ', $catkit);
		return $catkit;
	}

	//Ответ - установлена ли новая цена
	public static function init(&$pos) {
		
		if (!empty($pos['catkit'])) {
			$catkit = $pos['catkit'];
			$pos['iscatkit'] = true; //Если новый catkit
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
				continue;
			}
			$find[] = $res['present'];
			$kit[] = $p;
			$cost += $p['Цена'];
		}
		if ($cost) {
			$pos['catkit'] = Catkit::implode($kit);
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
			return true;
		} else {
			if (!empty($pos['iscatkit'])) {
				unset($pos['catkit']);
				unset($pos['iscatkit']);
				Catkit::init($pos);
			}
			return false;
		}

	}
}