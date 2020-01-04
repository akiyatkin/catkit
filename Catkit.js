import Fire from '/vendor/akiyatkin/load/Fire.js';
export {Fire};
export let Catkit = {
	row: () => {
		alert(1);
	},
	set: (go) => {
		go += location.search;
		history.pushState(null, null, go);
		let event = new Event("popstate");
  		window.dispatchEvent(event);
	},
	add: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_nick&kit&kit?get
		let item_nick = dataset.item_nick;
		let kit = dataset.article_nick + (item_nick ? (':' + item_nick) : '');

		let now = dataset.now.split('&');
		let master_item = dataset.master_item;

		now.push(kit);//Добавили

		
		let go = '/' + dataset.base + '/' + master_item + (now.length ? ('&' + now.join("&")) : '');
		Catkit.set(go);
		
	},
	rep: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_nick&kit&kit?get
		let item_nick = dataset.item_nick;
		let kit = dataset.article_nick + (item_nick ? (':' + item_nick) : '');

		let now = dataset.now.split('&');
		let master_item = dataset.master_item;

		now = [kit];//Заменили

		
		let go = '/' + dataset.base + '/' + master_item + (now.length ? ('&' + now.join("&")) : '');
		Catkit.set(go);
		
	},
	del: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_nick&kit&kit?get
		let item_nick = dataset.item_nick;
		let kit = dataset.article_nick + (item_nick ? (':' + item_nick) : '');

		let now = dataset.now.split('&');
		let master_item = dataset.master_item;

		let index = now.lastIndexOf(kit);
		if (index !== -1) now.splice(index, 1); //Удалили

		let go = '/' + dataset.base + '/' + master_item + (now.length ? ('&' + now.join("&")) : '');
		Catkit.set(go);
		
	},
	hand: (div) => {
		div.querySelectorAll('.catkit.add').forEach(a => {
			a.addEventListener('click', (e) => {
				Catkit.add(a.dataset);
			});
		});
		div.querySelectorAll('.catkit.rep').forEach(a => {
			a.addEventListener('click', (e) => {
				Catkit.rep(a.dataset);
			});
		});
		div.querySelectorAll('.catkit.del').forEach(a => {
			a.addEventListener('click', (e) => {
				Catkit.del(a.dataset);
			});
		});
	}

}

export default Catkit;
