package au.com.viz.trackmyjobs.view.mediator
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	import au.com.viz.trackmyjobs.view.components.CustomerView;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notification;

	public class CustomerViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "CustomerViewMediator";
		
		public function CustomerViewMediator( viewComponent:Object = null)
		{
			super(NAME, viewComponent);
			
			customerView.searchInput.addEventListener(Event.CHANGE, searchInputChanged);
			
		}
		
		public function get customerView():CustomerView
		{
			return viewComponent as CustomerView;
		}
		
		private function searchInputChanged(event:Event):void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.CUST_SEARCH_TEXT_CHANGED));
		}
				
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(notification:INotification):void
		{
		}
				
	}
}