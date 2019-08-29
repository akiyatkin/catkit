<?php
use infrajs\config\Config;
use akiyatkin\showcase\Showcase;
use infrajs\sequence\Sequence;

$r = ['catkit']; //Способ передать переменную без создания ссылки
Sequence::add(Showcase::$conf['dependencies'],[],$r[0]); //Добавлена массив в конфиг текущей сессии установки
Sequence::set(Config::$sys, ['showcase','dependencies'], Showcase::$conf['dependencies']);