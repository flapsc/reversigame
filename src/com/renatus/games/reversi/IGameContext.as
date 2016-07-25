package com.renatus.games.reversi 
{
	import com.renatus.games.reversi.services.log.ILogger;
	import com.renatus.games.reversi.services.view.IViewManager;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * Dispatched when game context are initialization ready
	 * @eventType	flash.events.Event.COMPLETE
	 */
	[Event(name = "complete", type = "flash.events.Event")] 	
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface IGameContext extends IEventDispatcher
	{
		
		/**
		 * Initialize game context
		 * @param	stage - current application flash.display.stage
		 * @param	viewManagerClassImpl IViewManager class implementation.
		 */
		function init( stage:Stage, viewManagerClassImpl:Class, loggerClassImpl:Class ):void;
		
		/**
		 * 
		 * @param	eventType - Current event type.
		 * @param	commandImpl - Command implementation
		 * @param	once - flag, for execute command one time, and after unregister it.
		 */
		function registrerCommand( eventType:String, commandImpl:Class, once:Boolean=false ):void;
		
		/**
		 * 
		 * @param	eventType
		 */
		function unregisterCommand( eventType:String ):void;
		
		function hasRegisteredCommand( eventType:String ):Boolean;
		
		/**
		 * Public property( read only ).
		 */
		function get viewManager():IViewManager;
		
		function get logger():ILogger;
	}
}