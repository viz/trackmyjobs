package au.com.viz.trackmyjobs.view.mediator
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	import au.com.viz.trackmyjobs.model.CustomerProxy;
	import au.com.viz.trackmyjobs.model.vo.CustomerVO;
	import au.com.viz.trackmyjobs.view.components.CustomerView;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
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
			customerView.customerList.addEventListener(ListEvent.CHANGE, customerSelected);
			
		}
		
		public function get customerView():CustomerView
		{
			return viewComponent as CustomerView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
			        ApplicationFacade.CUSTOMER_PROXY_AVAILABLE,
			        ApplicationFacade.CUST_SELECTED,
			        ApplicationFacade.CUST_SEARCH_TEXT_CHANGED
			       ];
		}
		
		override public function handleNotification(notification:INotification):void
		{
            var cp:CustomerProxy = facade.retrieveProxy(CustomerProxy.NAME) as CustomerProxy;

			switch ( notification.getName() )
			{
				case ApplicationFacade.CUSTOMER_PROXY_AVAILABLE:
//			      customerView.customerList.dataProvider = cp.activeCustomers;
			      customerView.customerList.dataProvider = cp.findCustomers();
			      break;
			      
			    case ApplicationFacade.CUST_SELECTED:
			      cp.currentCustomer = notification.getBody() as CustomerVO;
			      customerView.customerDetail.customer = cp.currentCustomer;
			      // if we want to do more complex animations like panels shinking and new ones appearing, code the behaviour in the view components and
			      // trigger them from the mediator. Example - a new customer is selected, the customer list shinks horizontally to make room 
			      // for a new detail panel that grows to fill the space.
			      break;
			      
			    case ApplicationFacade.CUST_SEARCH_TEXT_CHANGED:
			      //get results from CustomerProxy
			      var patt:String = customerView.searchInput.text;
			      customerView.customerList.dataProvider = cp.findCustomers(patt);
			      //var custs:ArrayCollection = (facade.retrieveProxy(CustomerProxy.NAME) as CustomerProxy).findCustomers(patt)
			      // populate Customer List
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