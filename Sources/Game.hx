package;

import kha.graphics2.Graphics;
import kha.Color;
import kero.System;
import kero.Component;

using kha.graphics2.GraphicsExtension;

class Game
{

	public var renderer:RenderSystem = new RenderSystem();

	public function new()
	{
		SystemManager.add(renderer);
		var e = EntityManager.create('circle');
		e.add_component(new Transform(10, 100));
		e.add_component(new Rect(50, 100, kha.Color.Red, e.get_component('transform').data));
	}

}

class Transform extends Component
{

	public function new(x:Float, y:Float) super('transform', {
		position: { x: x, y: y },
		rotation: 0.0,
		scale: { x: 1, y: 1 }
	});

}

class Drawable extends Component
{

	public function new(data:Dynamic)
	{
		super('drawable', data);
	}

	public function draw(g:Graphics) {}

}

class Circle extends Drawable
{

	var transform:Dynamic;

	public function new(radius:Float, color:Color, transform:Dynamic)
	{
		super({ radius: radius, color: color });
		this.transform = transform;
	}

	override public function draw(g:Graphics)
	{
		g.color = data.color;
		g.fillCircle(transform.x, transform.y, data.radius);
	}

}

class Rect extends Drawable
{

	var transform:Dynamic;

	public function new(width:Float, height:Float, color:Color, transform:Dynamic)
	{
		super({ width: width, height: height, color: color });
		this.transform = transform;
	}

	override public function draw(g:Graphics)
	{
		g.color = data.color;
		g.fillRect(transform.position.x, transform.position.y, data.width, data.height);
	}

}

class RenderSystem extends System
{

	public function new()
	{
		super({id: 'render system', required_components: ['drawable'] });
	}

	public function draw(graphics:Graphics)
	{
		graphics.begin();

		for (e in get_entities())
		{
			var d = cast(e.get_component('drawable'), Drawable);
			d.draw(graphics);
		}

		graphics.end();
	}

}