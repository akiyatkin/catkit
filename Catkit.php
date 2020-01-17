<?php
namespace akiyatkin\catkit;
use infrajs\path\Path;
use akiyatkin\showcase\Showcase;

class Catkit {
	public static $conf;
	public static function implode($kit, $char = '&') {

		$kit = array_reduce($kit, function ($gr, $k){
			return array_merge($gr, $k);
		}, []);
		$catkit = [];
		foreach ($kit as $p) {
			if (!empty($p['article_nick'])) {
				$c = $p['article_nick'];
				if ($p['item_num'] != 1) $c .= ':'.$p['item_num'];
			} else {
				$c = $p['present'];
			}
			$catkit[] = $c;
		}
		$catkit = implode($char, $catkit);
				
		return $catkit;
	}
	public static function run(&$kit, $callback) {
		foreach ($kit as $group => $list) {
			foreach ($list as $k => &$pos) {
				$r = $callback($pos, $group, $k);
				if (!is_null($r)) return $r;
			}
		}
	}
	public static function explode($catkit, $producer_nick) {
		$r = preg_split('/[&,]/', $catkit);
		$catkit = array_map( function ($catkit) use ($producer_nick) {
			$r = explode(':', $catkit);
			$article_nick = Path::encode($r[0]);
			if (!empty($r[1])) $item_num = Path::encode($r[1]);
			else $item_num = 1;
			$p = Showcase::getModel($producer_nick, $article_nick, $item_num);
			if (!$p) $p = [];
			$p['present'] = trim($catkit);
			return $p;
		}, $r);
		$kit = [];

		foreach ($catkit as $res) {
			$group = empty($res["Группа в комплекте"]) ? (empty($res["group"]) ? '' : $res["group"]) : $res["Группа в комплекте"];
			if (empty($kit[$group])) $kit[$group] = [];
			$kit[$group][] = $res;
		}
		return $kit;
	}
	public static function present($kit) {
		$kit = array_reduce($kit, function ($gr, $k){
			return array_merge($gr, $k);
		}, []);
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