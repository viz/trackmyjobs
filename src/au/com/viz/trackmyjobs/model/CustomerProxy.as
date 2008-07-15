package au.com.viz.trackmyjobs.model
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	import au.com.viz.trackmyjobs.model.vo.CustomerVO;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.observer.Notification;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class CustomerProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "CustomerProxy";
		
		public var currentCustomer:CustomerVO;
		private var filterPattern:RegExp = /.*/;
		
		public function CustomerProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, new ArrayCollection() );
			
			// temp data setup
			customers.addItem( new CustomerVO(0, "VizAbility Pty Ltd") );
			customers.addItem( new CustomerVO(1, "Wild Digital Pty Ltd") );
			customers.addItem( new CustomerVO(2, "Wild West Productions Pty Ltd") );
			customers.addItem( new CustomerVO(3, "Whitfield Bros.") );
			customers.addItem( new CustomerVO(4, "University of Sydney") );
			customers.addItem( new CustomerVO(5, "Ace Electrical") );
			
			
		}
		
		public function get customers():ArrayCollection
		{
			return data as ArrayCollection;
		}
		
		public function get activeCustomers():ArrayCollection
		{
			var active:ArrayCollection = new ArrayCollection((data as ArrayCollection).toArray());
			active.filterFunction = filterCustomer;
			active.refresh();
			return active;
		}
		
		public function findCustomers(pattern:String = ""):ArrayCollection
		{
			filterPattern = new RegExp("^"+pattern+".*");
			activeCustomers.refresh();
			return activeCustomers;
		}
		
		public function newCustomer():CustomerVO
		{
			return new CustomerVO(-1);
		}
		
		public function saveCustomer(cust:CustomerVO):void
		{
			if (cust.id==-1)
			{
			  cust.id=nextId();
			  customers.addItem(cust);
			} else
			{
			  customers.setItemAt(cust, cust.id);
			}
			facade.notifyObservers(new Notification(ApplicationFacade.CUSTOMER_PROXY_UPDATE));
		}
		
		public function cloneCustomer(cust:CustomerVO):CustomerVO
		{
			var newCust:CustomerVO = newCustomer();
			newCust.copyCustomer(cust);
			return newCust;
		}
		
		override public function onRegister():void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.CUSTOMER_PROXY_UPDATE));
			
		}
		
		private function filterCustomer(cust:Object):Boolean
		{
			return filterPattern.test((cust as CustomerVO).name);
		}
		
		private function nextId():int
		{
			return customers.length;
		}
	}
}