package au.com.viz.trackmyjobs.controller
{
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.ICommand;
	
	import au.com.viz.trackmyjobs.model.CustomerProxy;
	import au.com.viz.trackmyjobs.model.JobProxy;

	public class PrepModelCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			// setup Proxies
			facade.registerProxy(new CustomerProxy() );
			facade.registerProxy(new JobProxy() );
			
		}
		
	}
}