import Fire from '/vendor/akiyatkin/load/Fire.js';
import Seq from '/vendor/infrajs/Sequence/Seq.js';
import Load from '/vendor/akiyatkin/load/Load.js';
export {Fire, Seq, Load};
export let Catkit = {
	row: () => {
		alert(1);
	},
	set: (now) => {
		let base = Controller.names.catalog.crumb.child.child;
		let go = '/' + (base.child ? base.child : base + '/1');
		go += (now.length ? ('/' + now.join("&")) : '') + location.search;
		
		history.pushState(null, null, go);
		let event = new Event("popstate");
  		window.dispatchEvent(event);
	},
	add: async (dataset) => {
		let now = await Catkit.now(dataset);
		now.unshift(Catkit.kit(dataset));//Добавили
		Catkit.set(now);
	},
	rep: async (dataset) => {
		let now = await Catkit.now(dataset);
		now = [Catkit.kit(dataset)];//Заменили
		Catkit.set(now);
	},
	kit: (dataset) => {
		let item_nick = dataset.item_nick;
		let kit = dataset.article_nick + (item_nick ? (':' + item_nick) : '');
		return kit;
	},
	del: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_nick&kit&kit?get
		Catkit.now(dataset).then((now) => {
			let index = now.lastIndexOf(Catkit.kit(dataset));
			if (index !== -1) now.splice(index, 1); //Удалили
			Catkit.set(now);
		});
	},
	now: async (dataset) => {
		let now = Seq.get(Controller.names.catalog.crumb, 'child.child.child.child.name','');
		if (!now) {
			let data = await Load.on('fetch', Controller.names.catkit.json);
			now = Seq.get(data,'pos.catkit','');
		}
		now = now.split('&').filter(Boolean);
		return now;
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
