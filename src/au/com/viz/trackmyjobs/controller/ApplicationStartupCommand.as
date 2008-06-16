package au.com.viz.trackmyjobs.controller
{
	import au.com.viz.trackmyjobs.view.mediator.TrackMyJobsMediator;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ApplicationStartupCommand extends SimpleCommand implements ICommand
	{
		public function ApplicationStartupCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var app:TrackMyJobs = notification.getBody() as TrackMyJobs;

			facade.registerMediator(new TrackMyJobsMediator(app));
			
		}
		
	}
}