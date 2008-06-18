package au.com.viz.trackmyjobs.view.mediator
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	import au.com.viz.trackmyjobs.model.CustomerProxy;
	import au.com.viz.trackmyjobs.model.vo.CustomerVO;
	import au.com.viz.trackmyjobs.view.components.CustomerView;
	
	import flash.events.Event;
	
	import mx.events.ListEvent;
	
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
			customerView.customerList.addEventListener(ListEvent.ITEM_CLICK, customerSelected);
			
		}
		
		public function get customerView():CustomerView
		{
			return viewComponent as CustomerView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
			        ApplicationFacade.CUSTOMER_PROXY_AVAILABLE,
			        ApplicationFacade.CUST_SELECTED
			       ];
		}
		
		override public function handleNotification(notification:INotification):void
		{
            var cp:CustomerProxy = facade.retrieveProxy(CustomerProxy.NAME) as CustomerProxy;

			switch ( notification.getName() )
			{
				case ApplicationFacade.CUSTOMER_PROXY_AVAILABLE:
			      customerView.customerList.dataProvider = cp.activeCustomers;
			      break;
			      
			    case ApplicationFacade.CUST_SELECTED:
			      cp.currentCustomer = notification.getBody() as CustomerVO;
			      customerView.customerDetail.customer = cp.currentCustomer;
			      customerView.currentState = ApplicationFacade.SHOW_CUST_DETAIL;
			      break;
				  
			}
		}
		
	/* Event Handlers */
	
		private function searchInputChanged(event:Event):void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.CUST_SEARCH_TEXT_CHANGED));
		}
				
		private function customerSelected(event:Event):void
		{
			var listdata:Object = event.currentTarget.selectedItem;
			facade.notifyObservers(new Notification(ApplicationFacade.CUST_SELECTED, listdata));
		}		

	}
}