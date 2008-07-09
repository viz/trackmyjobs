package au.com.viz.trackmyjobs.view.mediator
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notification;

	public class TrackMyJobsMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "JobsMediator";
		
		public function TrackMyJobsMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			//facade.registerMediator(new ActionBarMediator(trackMyJobs.actionBar));
			facade.registerMediator(new CustomerViewMediator(trackMyJobs.custView));
			facade.registerMediator(new JobViewMediator(trackMyJobs.jobView));
			trackMyJobs.newButton.addEventListener(MouseEvent.CLICK, newButtonClicked);
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
			         ApplicationFacade.SHOW_JOB_VIEW,
			         ApplicationFacade.NEW_ACTION
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
				  
				case ApplicationFacade.NEW_ACTION:
				  switch (trackMyJobs.mainTabContainer.selectedChild.id)
				  {
				  	case "custView":
				  	  facade.notifyObservers(new Notification(ApplicationFacade.NEW_CUST_ACTION));
				  	  break;
				  	  
				  	case "jobView":
				  	  facade.notifyObservers(new Notification(ApplicationFacade.NEW_JOB_ACTION));
				  	  break;
				  	
				  }
			}
		}
		
		private function newButtonClicked(event:Event):void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.NEW_ACTION));
		}
		
	}
}