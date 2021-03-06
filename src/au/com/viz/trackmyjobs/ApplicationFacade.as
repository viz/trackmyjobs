package au.com.viz.trackmyjobs
{
	import au.com.viz.trackmyjobs.controller.ApplicationStartupCommand;
	import au.com.viz.trackmyjobs.controller.PrepModelCommand;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	public class ApplicationFacade extends Facade implements IFacade
	{
		// General definitions
		public static const NO_STATE:int = -1;
		
		// general application notifications
		public static const APP_STARTUP:String = "AppStartup";
		public static const STATE_PROXY_READY:String = "stateProxyReady";

		public static const HOME_VIEW:String = "homeView";
		public static const SHOW_HOME_VIEW:String = "showHomeView";
		public static const NEW_ACTION:String = "newAction";
		public static const EDIT_ACTION:String = "ediAction";

		// Customer related notifications
		public static const CUST_VIEW:String = "custView";
		public static const SHOW_CUST_VIEW:String = "showCustView";
		public static const SHOW_CUST_DETAIL:String = "showCustDetail";
		public static const CUST_SELECTED:String = "custSelected";
		public static const CUSTOMER_PROXY_UPDATE:String = "customerProxyUpdate";
		public static const CUST_SEARCH_TEXT_CHANGED:String = "custSearchTextChanged";
        public static const NEW_CUST_ACTION:String = "newCustAction";
        public static const EDIT_CUST_ACTION:String = "editCustAction";
        public static const CUST_EDIT_CANCELLED:String = "custEditCancelled";
        public static const CUST_EDIT_SAVED:String = "custEditSaved";

		// Job related notifications
		public static const JOB_VIEW:String = "jobView";
		public static const SHOW_JOB_VIEW:String = "showJobView";
		public static const JOB_PROXY_UPDATE:String = "jobProxyUpdate";
		public static const JOB_SELECTED:String = "jobSelected";
		public static const NEW_JOB_ACTION:String = "newJobAction";
		public static const EDIT_JOB_ACTION:String = "editJobAction";
        public static const JOB_EDIT_CANCELLED:String = "jobEditCancelled";
        public static const JOB_EDIT_SAVED:String = "jobEditSaved";

		
        public static function getInstance():ApplicationFacade
        {
            if (instance==null) instance = new ApplicationFacade();
            
            return instance as ApplicationFacade;
        }
        
        override protected function initializeController():void
        {
            super.initializeController();
            this.registerCommand(APP_STARTUP, ApplicationStartupCommand);
            this.registerCommand(STATE_PROXY_READY, PrepModelCommand);
        }
		
	}
}