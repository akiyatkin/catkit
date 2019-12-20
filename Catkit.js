import Fire from '/vendor/akiyatkin/load/Fire.js';
export {Fire};
export let Catkit = {
	row: () => {
		alert(1);
	},
	set: (go) => {
		history.pushState(null, null, go);
		let event = new Event("popstate");
  		window.dispatchEvent(event);
	},
	add: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_nick&kit&kit?get
		let item_nick = dataset.item_nick;
		let kit = dataset.article_nick + (item_nick ? (':' + item_nick) : '');

		let now = dataset.now.split('&');
		let master_item = now.shift();
		now.push(kit);//Добавили

		
		let go = '/' + dataset.base + '/' + master_item + (now.length ? ('&' + now.join("&")) : '');
		Catkit.set(go);
		
	},
	rep: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_nick&kit&kit?get
		let item_nick = dataset.item_nick;
		let kit = dataset.article_nick + (item_nick ? (':' + item_nick) : '');

		let now = dataset.now.split('&');
		let master_item = now.shift();
		now=[kit];//Заменили

		
		let go = '/' + dataset.base + '/' + master_item + (now.length ? ('&' + now.join("&")) : '');
		Catkit.set(go);
		
	},
	del: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_nick&kit&kit?get
		let item_nick = dataset.item_nick;
		let kit = dataset.article_nick + (item_nick ? (':' + item_nick) : '');

		let now = dataset.now.split('&');
		let master_item = now.shift();

		let index = now.lastIndexOf(kit);
		if (index !== -1) now.splice(index, 1); //Удалили

		let go = '/' + dataset.base + '/' + master_item + (now.length ? ('&' + now.join("&")) : '');
		Catkit.set(go);
		
	}

}

export default Catkit;
