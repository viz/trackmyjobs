package au.com.viz.trackmyjobs.model
{
	import au.com.viz.trackmyjobs.ApplicationFacade;
	import au.com.viz.trackmyjobs.model.vo.StateVO;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.observer.Notification;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class StateProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "StateProxy";
		
		public function StateProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME, new ArrayCollection());
			
			states.addItem(new StateVO(0,"Quote"));
			states.addItem(new StateVO(1,"Design"));
			states.addItem(new StateVO(2,"Proof"));
			states.addItem(new StateVO(3,"Production"));
			states.addItem(new StateVO(4,"Invoice"));
			states.addItem(new StateVO(5,"Complete"));
			states.addItem(new StateVO(6,"New"));
			
			
			
		}
		
		public function get states():ArrayCollection
		{
			return data as ArrayCollection;
		}
		
		public function state(name:String):StateVO
		{
			var i:int;
			for ( i = 0; i< states.length; i++)
			{
				var s:StateVO = states.getItemAt(i) as StateVO;
				if (s.name == name) return s;
			}
			return null;
		}
		
		override public function onRegister():void
		{
			facade.notifyObservers(new Notification(ApplicationFacade.STATE_PROXY_READY));
		}
			
	}
}