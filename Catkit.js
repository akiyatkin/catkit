import Fire from '/vendor/akiyatkin/load/Fire.js';
export {Fire};
export let Catkit = {
	row: () => {
		alert(1);
	},
	set: (base, master_item, now) => {

		let go = '/' + base;
		//go += (master_item || now.length) ? '/' + (master_item||1) : '';
		go += '/' + (master_item||1);
		go += (now.length ? ('/' + now.join("&")) : '');

		go += location.search;
		history.pushState(null, null, go);
		let event = new Event("popstate");
  		window.dispatchEvent(event);
	},
	add: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_nick&kit&kit?get
		let item_nick = dataset.item_nick;
		let kit = dataset.article_nick + (item_nick ? (':' + item_nick) : '');
		let master_item = dataset.master_item;
		let layer = Controller.names.catalog;
		let now = layer.crumb.child.child.child.child.name;
		now = now.split('&');

		now.push(kit);//Добавили
		
		Catkit.set(dataset.base, master_item, now);
		
	},
	rep: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_nick&kit&kit?get
		let item_nick = dataset.item_nick;
		let kit = dataset.article_nick + (item_nick ? (':' + item_nick) : '');
		let master_item = dataset.master_item;
		let layer = Controller.names.catalog;
		let now = layer.crumb.child.child.child.child.name;
		now = now.split('&');

		now = [kit];//Заменили
		
		Catkit.set(dataset.base, master_item, now);
		
	},
	del: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_nick&kit&kit?get
		let item_nick = dataset.item_nick;
		let kit = dataset.article_nick + (item_nick ? (':' + item_nick) : '');
		let master_item = dataset.master_item;
		let layer = Controller.names.catalog;
		let now = layer.crumb.child.child.child.child.name;

		now = now.split('&');
		let index = now.lastIndexOf(kit);
		if (index !== -1) now.splice(index, 1); //Удалили
		Catkit.set(dataset.base, master_item, now);		
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
