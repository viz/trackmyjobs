package au.com.viz.trackmyjobs.model.vo
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	import au.com.viz.trackmyjobs.model.vo.StateVO;
	
	[Bindable]
	public class JobVO
	{
		public var id:int;
		public var name:String = "";
		public var description:String = "";
		public var dateRequired:Date;
		public var priority:int = 3;
		public var quoteNum:int;
		public var invoiceNum:int;
		public var poNum:String;
		public var proofs:Boolean = true;
		public var clientId:int;
		public var payerId:int;
		public var currentState:StateVO;
		public var productionArea:int;		
		
		public function JobVO( id:int,
							   name:String = null,
		                       desc:String = null,
		                       dateReq:Date = null,
		                       prior:int = 0,
		                       quote:int = 0,
		                       invoice:int = 0,
		                       po:String = null,
		                       proof:Boolean = true,
		                       client:int = -1,
		                       payer:int = -1,
		                       curstate:StateVO = null,
		                       prodArea:int = 0
		                     )
		{
			this.id = id;
			if( name!= null ) this.name = name;
			if( desc!= null ) this.description = desc;
			if( dateReq!= null ) this.dateRequired = dateReq;
			this.priority = prior;
			this.quoteNum = quote;
			this.invoiceNum = invoice;
			if( po!= null ) this.poNum = po;
			this.proofs = proof;
			this.clientId = client;
			this.payerId = payer;
			this.currentState = curstate;
			this.productionArea = prodArea;
			
			
		}
		
		public function copyJob(job:JobVO):void
		{
			id = job.id;
			name = job.name;
		}


	}
}