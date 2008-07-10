package au.com.viz.trackmyjobs.controller
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class ApplicationStartupCommand extends MacroCommand implements ICommand
	{
		public function ApplicationStartupCommand()
		{
			super();
		}
		
		override protected function initializeMacroCommand():void
		{
			addSubCommand(au.com.viz.trackmyjobs.controller.PrepViewCommand);
			addSubCommand(au.com.viz.trackmyjobs.controller.PrepStatesCommand);
		}
		
	}
}