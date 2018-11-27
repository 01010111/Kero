package kero;

import kero.util.GameLog.*;
import kero.Entity.EntityManager;

class System
{

	public  var id:String;

	var priority:Int = 0;
	var required_components:Array<String>;

	public function new(options:SystemOptions)
	{
		id = options.id;
		required_components = options.required_components;
		if (options.priority != null) priority = options.priority;
	}

	public function update(dt:Float)
	{
		for (entity in get_entities()) on_update(dt, entity);
	}

	function get_entities():Array<Entity>
	{
		var a = [];
		for (e in EntityManager.entities)
		{
			var entity_has_required_components = true;
			for (id in required_components) if (!e.has_component(id)) entity_has_required_components = false;
			if (!entity_has_required_components) continue;
			a.push(e);
		}
		return a;
	}

	public function on_update(dt:Float, entity:Entity)
	{

	}

	public function get_priority():Int return priority;

}

class SystemManager
{

	public static var systems:Array<System> = [];

	public static function add(system:System)
	{
		for (i in 0...systems.length) if (systems[i].id == system.id)
		{
			LOG('[SYSTEM MANAGER] System with id ${system.id} already exists! Overriding...', WARNING);
			systems.remove(systems[i]);
		}
		for (i in 0...systems.length) if (systems[i].get_priority() < system.get_priority())
		{
			systems.insert(i, system);
			return;
		}
		systems.push(system);
	}

	public static function remove(id:String)
	{
		var index = -1;
		for (i in 0...systems.length) if (systems[i].id == id) index = i;
		index < 0 ? LOG('[SYSTEM MANAGER] System with id ${id} not found, cannot remove!', WARNING) : systems.remove(systems[index]);
	}

	public static function update(dt:Float)
	{
		for (system in systems) system.update(dt);
	}

}

typedef SystemOptions =
{
	id:String,
	required_components:Array<String>,
	?priority:Int,
}