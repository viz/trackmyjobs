package au.com.viz.trackmyjobs.view.mediator
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class TrackMyJobsMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "JobsMediator";
		
		public function TrackMyJobsMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			facade.registerMediator(new ActionBarMediator(trackMyJobs.actionBar));
			facade.registerMediator(new CustomerViewMediator(trackMyJobs.custView));
		}
		
		private function get trackMyJobs():TrackMyJobs
		{
			return viewComponent as TrackMyJobs;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
			         ApplicationFacade.SHOW_HOME_VIEW,
			         ApplicationFacade.SHOW_CUST_VIEW,
			         ApplicationFacade.SHOW_JOB_VIEW
		           ];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case ApplicationFacade.SHOW_HOME_VIEW:
				  trackMyJobs.currentState = ApplicationFacade.HOME_VIEW;
				  break;
				case ApplicationFacade.SHOW_CUST_VIEW:
				  trackMyJobs.currentState = ApplicationFacade.CUST_VIEW;
				  
				  break;
				case ApplicationFacade.SHOW_JOB_VIEW:
				  trackMyJobs.currentState = ApplicationFacade.JOB_VIEW;
				  break;
			}
		}
	}
}