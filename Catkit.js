import Fire from '/vendor/akiyatkin/load/Fire.js';
import Seq from '/vendor/infrajs/sequence/Seq.js';
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
		let now = await Catkit.now();
		now.unshift(Catkit.kit(dataset));//Добавили
		Catkit.set(now);
	},
	run: (kitlist, callback) => {
		for (let g in kitlist) {
			for (let i = 0, l = kitlist[g].length; i < l; i++){
				let pos = kitlist[g][i];
				let r = callback(pos, g);
				if (r != null) return r;
			};
		}
	},
	group: async (dataset) => {
		let data = await Catkit.data();
		let origkit = Catkit.kit(dataset);
		//ищем группу с нашим китом	
		return Catkit.run(data.pos.kitlist, (pos, group) => {
			let kit = Catkit.kit(pos);
			if (kit == origkit) return group;
		});
	},
	rep: async (dataset) => {
		let now = await Catkit.now();
		let group = await Catkit.group(dataset);
		let data = await Catkit.data();
		
		for (let i = 0, l = data.pos.kitlist[group].length; i < l; i++) {
			let pos = data.pos.kitlist[group][i]
			let items = pos.items;
			if (!items) items = {'':pos};
			for (let j in items) {
				let ikit = Catkit.kit(pos,items[j]['item_num']);
				console.log(ikit);
				do var index = now.indexOf(ikit);
				while (~index && now.splice(index,1));
			}
			
		}
		now.unshift(Catkit.kit(dataset));//Добавили
		Catkit.set(now);
	},
	kit: (pos, item_num = pos.item_num) => {
		//item_num = item_num || pos.item_num;
		let kit = pos.article_nick + (item_num != 1 ? (':' + item_num) : '');
		return kit;
	},
	del: (dataset) => {
		//Работает только на странице вида .../producer_nick/article_nick/item_num/kit&kit?get
		Catkit.now().then((now) => {
			let index = now.lastIndexOf(Catkit.kit(dataset));
			if (index !== -1) now.splice(index, 1); //Удалили
			Catkit.set(now);
		});
	},
	wait: () => {
		if (Catkit.wait.promise) return Catkit.wait.promise;
		return Catkit.wait.promise = new Promise((resolve, reject) => 
			domready(() => Event.one('Controller.onshow', resolve)));
	},
	data: async () => {
		await Catkit.wait();
		return Load.on('fetch', Controller.names.catkit.json);
	},
	now: async () => {
		await Catkit.wait();
		let now = Seq.get(Controller.names.catalog.crumb, 'child.child.child.child.name','');
		if (!now) {
			let data = await Catkit.data();
			now = Seq.get(data,'pos.catkit','');
		}
		return now.split('&').filter(Boolean);
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
//debug
window.Catkit = Catkit;
export default Catkit;
