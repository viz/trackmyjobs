package au.com.viz.trackmyjobs.model
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	import au.com.viz.trackmyjobs.model.vo.CustomerVO;
	import au.com.viz.trackmyjobs.model.vo.JobVO;
	import au.com.viz.trackmyjobs.model.StateProxy;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.observer.Notification;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class JobProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "JobProxy";
		
		public var currentJob:JobVO;
		private var filterCust:CustomerVO;
		
		public function JobProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, new ArrayCollection() );
			
			var sp:StateProxy = facade.retrieveProxy(StateProxy.NAME) as StateProxy;
			
			jobs.addItem( new JobVO(0, "Sample Job 1","This is a sample job",new Date(), 3, 12345, 54321, "PO12345", true, 1, 1, sp.state("Quote"), 2));
			jobs.addItem( new JobVO(1, "Sample Job 2","This is a sample job",new Date(), 3, 12345, 54321, "PO12345", true, 1, 1, sp.state("Design"), 2));
			jobs.addItem( new JobVO(2, "Sample Job 3","This is a sample job",new Date(), 3, 12345, 54321, "PO12345", true, 3, 1, sp.state("Proof"), 2));
			jobs.addItem( new JobVO(3, "Sample Job 4","This is a sample job",new Date(), 3, 12345, 54321, "PO12345", true, 5, 1, sp.state("Complete"), 2));
		}
		
		public function get activeJobs():ArrayCollection
		{
			return jobs;
		}
		
		public function get jobs():ArrayCollection
		{
			return data as ArrayCollection;
		}
		
		public function jobsForCustomer(cust:CustomerVO):ArrayCollection
		{
			var jobs:ArrayCollection = new ArrayCollection((data as ArrayCollection).toArray());
			filterCust = cust;
			jobs.filterFunction = filterJobsByCustomer;
			jobs.refresh();
			return jobs;
		}
		
		public function newJob():JobVO
		{
			return new JobVO(-1);
		}
		
		public function saveJob(job:JobVO):void
		{
		    if (job.id == -1)
		    {
		    	job.id = nextId();
		    	jobs.addItem(job);
		    } else
		    {
		    	jobs.setItemAt(job, job.id);
		    }	
		    facade.notifyObservers(new Notification( ApplicationFacade.JOB_PROXY_UPDATE));
		}
		
		public function cloneJob(job:JobVO):JobVO
		{
			var newJob:JobVO = newJob();
			newJob.copyJob(job);
			return newJob;
		}
		
		override public function onRegister():void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.JOB_PROXY_UPDATE));
		}
/*
		public function jobsForState(state:StateVO):ArrayCollection
		{
			
		}
*/
		private function filterJobsByCustomer(job:JobVO):Boolean
		{			
			return job.clientId == filterCust.id;
		}
		
		private function nextId():int
		{
			return jobs.length;
		}


	}
}