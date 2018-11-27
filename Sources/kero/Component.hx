package kero;

class Component
{

	public var id:String;
	public var entity:Entity;
	public var data:Dynamic = {};
	public var on_added:Void -> Void = () -> {};
	public var on_removed:Void -> Void = () -> {};

	public function new(id:String, data:Dynamic)
	{
		this.id = id;
		this.data = data;
	}

	public function add(entity:Entity)
	{
		this.entity = entity;
		on_added();
	}

	public function remove()
	{
		this.entity = null;
		on_removed();
	}

	public function destroy() data = null;

}