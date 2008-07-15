package au.com.viz.trackmyjobs.controller
{
	import au.com.viz.trackmyjobs.model.StateProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class PrepStatesCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			facade.registerProxy(new StateProxy());
		}
		
	}
}