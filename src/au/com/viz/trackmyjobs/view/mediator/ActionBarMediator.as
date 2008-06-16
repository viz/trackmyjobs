package au.com.viz.trackmyjobs.view.mediator
{
	import au.com.viz.trackmyjobs.view.components.ActionBar;
	import au.com.viz.trackmyjobs.ApplicationFacade;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notification;

	public class ActionBarMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ActionBarMediator";
		
		public function ActionBarMediator(viewComponent:Object=null)
		{
			super( NAME, viewComponent);
			
			actionBar.homeButton.addEventListener(MouseEvent.CLICK, homeButtonClicked);
			actionBar.custButton.addEventListener(MouseEvent.CLICK, custButtonClicked);
			actionBar.jobButton.addEventListener(MouseEvent.CLICK, jobButtonClicked);
		}
		
		private function get actionBar():ActionBar
		{
			return viewComponent as ActionBar;
		}
		
		private function homeButtonClicked(event:Event):void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.SHOW_HOME_VIEW));
		}
		
		private function custButtonClicked(event:Event):void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.SHOW_CUST_VIEW));
		}
		
		private function jobButtonClicked(event:Event):void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.SHOW_JOB_VIEW));
		}
		
	}
}