package com.renatus.games.reversi 
{
	import com.renatus.games.reversi.services.view.IViewManager;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface IGameContext extends IEventDispatcher
	{
		/**
		 * 
		 * @param	eventType
		 * @param	commandImpl
		 */
		function registrerCommand( eventType:String, commandImpl:Class ):void;
		
		/**
		 * 
		 * @param	eventType
		 */
		function unregisterCommand( eventType:String ):void;
		
		function hasRegisteredCommand( eventType:String ):Boolean;
		
		/**
		 * Public property
		 */
		function set viewManager( val:IViewManager ):void;
		function get viewManager():IViewManager;
	}
}