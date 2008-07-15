package au.com.viz.trackmyjobs.model.vo
{
	public class StateVO
	{
		
		public var id:int;
		public var name:String;
		public var description:String;

		public function StateVO(id:int = -1, name:String = null, description:String = null)
		{
			this.id = id;
			if (name != null) this.name = name;
			if (description != null) this.description = description;
		}

	}
}