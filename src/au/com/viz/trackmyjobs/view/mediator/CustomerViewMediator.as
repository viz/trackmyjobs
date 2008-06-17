package au.com.viz.trackmyjobs.view.mediator
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	import au.com.viz.trackmyjobs.model.CustomerProxy;
	import au.com.viz.trackmyjobs.view.components.CustomerView;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
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
			return [
			        ApplicationFacade.CUSTOMER_PROXY_AVAILABLE
			       ];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch ( notification.getName() )
			{
				case ApplicationFacade.CUSTOMER_PROXY_AVAILABLE:
			      var cp:CustomerProxy = facade.retrieveProxy(CustomerProxy.NAME) as CustomerProxy;
			      customerView.customerList.dataProvider = (facade.retrieveProxy(CustomerProxy.NAME) as CustomerProxy).activeCustomers;
			      break;
				  
			}
		}
				
	}
}