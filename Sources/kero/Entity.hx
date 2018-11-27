package kero;

import kero.util.GameLog.*;

class Entity
{

	public var id:String;

	var components:Map<String, Component> = new Map();
	var tags:Array<String> = [];

	public function new(id:String)
	{
		this.id = id;
	}

	public function add_component(component:Component)
	{
		if (components.exists(component.id)) LOG('[${this.id}] Component with ID [${component.id}] already exists!', WARNING);
		components.set(component.id, component);
		component.add(this);
	}

	public function remove_component(id:String)
	{
		if (components.exists(id)) components[id].on_removed();
		if (!components.remove(id)) LOG('[${this.id}] Component with ID [$id] not found, cannot be removed!', WARNING);
	}

	public function get_component(id:String):Null<Component>
	{
		if (components.exists(id)) return components[id];
		LOG('[${this.id}] Component with ID [$id] not found!', ERROR);
		return null;
	}

	public function has_component(id:String):Bool return components.exists(id);

	public function add_tag(tag:String) tags.push(tag);
	public function remove_tag(tag:String) tags.remove(tag);
	public function has_tag(tag:String):Bool return tags.indexOf(tag) >= 0;

	public function destroy()
	{
		EntityManager.remove(this);
		for (component in components)
		{
			remove_component(component.id);
			component.destroy();
		}
		components = null;
	}

}

class EntityManager
{

	public static var entities:Array<Entity> = [];

	public static function create(id:String):Entity
	{
		var entity = new Entity(id);
		add(entity);
		return entity;
	}

	public static function add(entity:Entity)
	{
		for (e in entities) if (e.id == entity.id) LOG('[ENTITY MANAGER] Entity with ID [${entity.id}] already exists! Be careful!', INFO);
		entities.push(entity);
	}

	public static function remove(entity:Entity)
	{
		if (!entities.remove(entity)) LOG('[ENTITY MANAGER] Entity [${entity.id}] has not been added, cannot remove!', WARNING);
	}

}