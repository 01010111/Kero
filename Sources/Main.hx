package;

import kha.Assets;
import kha.Scheduler;
import kha.System;

class Main
{

	public static function main()
	{
		System.start({title: "Project", width: 1024, height: 768}, function (_) {
			Assets.loadEverything(() -> {
				Scheduler.addTimeTask(() -> kero.System.SystemManager.update(1/60), 0, 1/60);
				var game = new Game();
				System.notifyOnRender((_) -> game.renderer.draw(_.g2));
			});
		});
	}
}