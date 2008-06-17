package au.com.viz.trackmyjobs.controller
{
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.ICommand;
	
	import au.com.viz.trackmyjobs.view.mediator.TrackMyJobsMediator;

	public class PrepViewCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			var app:TrackMyJobs = notification.getBody() as TrackMyJobs;

			facade.registerMediator(new TrackMyJobsMediator(app));
			
		}
		
	}
}