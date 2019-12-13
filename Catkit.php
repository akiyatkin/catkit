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
}