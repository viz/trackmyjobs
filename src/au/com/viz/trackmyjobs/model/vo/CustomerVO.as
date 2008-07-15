package au.com.viz.trackmyjobs.model.vo
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	import au.com.viz.trackmyjobs.model.JobProxy;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class CustomerVO
	{
		public var id:int;
		public var name:String ='';
		
		public function CustomerVO( id:int, name:String=null )
		{
			this.id = id;
			if(name != null) this.name = name;
		}
		
		public function get jobs():ArrayCollection
		{
			var facade:ApplicationFacade = ApplicationFacade.getInstance();
			var jobProxy:JobProxy = ApplicationFacade.getInstance().retrieveProxy(JobProxy.NAME) as JobProxy;
			return jobProxy.jobsForCustomer(this);
		}
		
		public function copyCustomer(cust:CustomerVO):void
		{
			id = cust.id;
			name = cust.name;
		}

	}
}