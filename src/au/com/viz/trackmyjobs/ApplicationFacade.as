package au.com.viz.trackmyjobs
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	import au.com.viz.trackmyjobs.controller.ApplicationStartupCommand;

	public class ApplicationFacade extends Facade implements IFacade
	{
		public static const APP_STARTUP:String = "AppStartup";
		public static const HOME_VIEW:String = "homeView";
		public static const SHOW_HOME_VIEW:String = "showHomeView";
		public static const CUST_VIEW:String = "custView";
		public static const SHOW_CUST_VIEW:String = "showCustView";
		public static const JOB_VIEW:String = "jobView";
		public static const SHOW_JOB_VIEW:String = "showJobView";

		public static const CUST_SEARCH_TEXT_CHANGED:String = "custSearchTextChanged";
		
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