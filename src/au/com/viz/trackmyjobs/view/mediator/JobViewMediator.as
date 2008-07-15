package au.com.viz.trackmyjobs.view.mediator
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	import au.com.viz.trackmyjobs.model.JobProxy;
	import au.com.viz.trackmyjobs.model.StateProxy;
	import au.com.viz.trackmyjobs.model.vo.JobVO;
	import au.com.viz.trackmyjobs.model.vo.StateVO;
	import au.com.viz.trackmyjobs.view.components.JobView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.ListEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notification;

	public class JobViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "JobViewMediator";
		private var sp:StateProxy;
		private var jp:JobProxy;
		
		public function JobViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);

			jobView.jobList.addEventListener(ListEvent.CHANGE, jobSelected);
			jobView.jobDetail.cancelButton.addEventListener(MouseEvent.CLICK, cancelJobEdit);
			jobView.jobDetail.saveButton.addEventListener(MouseEvent.CLICK, saveJob);
			
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		public function get jobView():JobView
		{
			return viewComponent as JobView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ ApplicationFacade.JOB_PROXY_UPDATE,
			         ApplicationFacade.JOB_SELECTED,
			         ApplicationFacade.NEW_JOB_ACTION,
			         ApplicationFacade.JOB_EDIT_CANCELLED,
			         ApplicationFacade.JOB_EDIT_SAVED,
			         ApplicationFacade.EDIT_JOB_ACTION
			       ];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			jp = facade.retrieveProxy(JobProxy.NAME) as JobProxy;
			sp = facade.retrieveProxy(StateProxy.NAME) as StateProxy;
			jobView.jobDetail.statePicker.dataProvider = sp.states;
			
			
			switch (notification.getName())
			{
				case ApplicationFacade.JOB_PROXY_UPDATE:
				  jobView.jobList.dataProvider = jp.jobs;
				  break;
				  
				case ApplicationFacade.JOB_SELECTED:
				  jp.currentJob = notification.getBody() as JobVO;
				  jobView.jobDetail.job = jp.currentJob;
				  break;
				  
				case ApplicationFacade.NEW_JOB_ACTION:
				  jobView.jobDetail.job = jp.newJob();
				  jobView.jobDetail.statePicker.selectedItem = sp.state("New");
				  jobView.jobDetail.selectedChild = jobView.jobDetail.edit;
		          break;
		          
		        case ApplicationFacade.JOB_EDIT_CANCELLED:
		          jobView.jobDetail.job = jp.currentJob;
		          jobView.jobDetail.selectedChild = jobView.jobDetail.view;
		          break;
		          
		        case ApplicationFacade.JOB_EDIT_SAVED:
		          var job:JobVO = notification.getBody() as JobVO;
		          job.currentState = jobView.jobDetail.statePicker.selectedItem as StateVO;
		          jp.saveJob(job);
		          jobView.jobDetail.selectedChild = jobView.jobDetail.view;
		          break;
		          
		        case ApplicationFacade.EDIT_JOB_ACTION:
		          jobView.jobDetail.job = jp.cloneJob(jp.currentJob);
		          jobView.jobDetail.statePicker.selectedItem = jp.currentJob.currentState;
		          jobView.jobDetail.selectedChild = jobView.jobDetail.edit;
			}
		}
		
		override public function onRegister():void
		{
		}
		
		override public function onRemove():void
		{
		}
		
		// Event Handlers
		
		private function jobSelected(event:Event):void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.JOB_SELECTED, event.currentTarget.selectedItem));
		}
		
		private function cancelJobEdit(event:Event):void
		{
		    facade.notifyObservers(new Notification(ApplicationFacade.JOB_EDIT_CANCELLED));	
		}
		
		private function saveJob(event:Event):void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.JOB_EDIT_SAVED, jobView.jobDetail.job));
		}
	}
}