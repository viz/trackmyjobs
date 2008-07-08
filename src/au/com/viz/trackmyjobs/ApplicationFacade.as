package au.com.viz.trackmyjobs
{
	import au.com.viz.trackmyjobs.controller.ApplicationStartupCommand;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	public class ApplicationFacade extends Facade implements IFacade
	{
		// general application notifications
		public static const APP_STARTUP:String = "AppStartup";

		public static const HOME_VIEW:String = "homeView";
		public static const SHOW_HOME_VIEW:String = "showHomeView";
		public static const NEW_ACTION:String = "newAction";

		// Customer related notifications
		public static const CUST_VIEW:String = "custView";
		public static const SHOW_CUST_VIEW:String = "showCustView";
		public static const SHOW_CUST_DETAIL:String = "showCustDetail";
		public static const CUST_SELECTED:String = "custSelected";
		public static const CUSTOMER_PROXY_AVAILABLE:String = "customerProxyAvailable";
		public static const CUSTOMER_PROXY_UPDATE:String = "customerProxyUpdate";
		public static const CUST_SEARCH_TEXT_CHANGED:String = "custSearchTextChanged";
        public static const NEW_CUST_ACTION:String = "newCustAction";
        public static const CUST_EDIT_CANCELLED:String = "custEditCancelled";
        public static const CUST_EDIT_SAVED:String = "custEditSaved";

		// Job related notifications
		public static const JOB_VIEW:String = "jobView";
		public static const SHOW_JOB_VIEW:String = "showJobView";

		
        public static function getInstance():ApplicationFacade
        {
            if (instance==null) instance = new ApplicationFacade();
            
            return instance as ApplicationFacade;
        }
        
        override protected function initializeController():void
        {
            super.initializeController();
            this.registerCommand(APP_STARTUP, ApplicationStartupCommand);
        }
		
	}
}