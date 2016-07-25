package com.renatus.games.reversi 
{
	import com.renatus.games.reversi.controller.ICommandInfo;
	import com.renatus.games.reversi.services.view.IViewManager;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class GameContext extends EventDispatcher implements IGameContext
	{
		
		private var _commandMap:Vector.<ICommandInfo>;
		private var _commandMapLn:uint;
		
		public function GameContext()
		{
			_commandMap = Vector.<ICommandInfo>([]);
			_commandMapLn = 0;
		}
		
		/**
		 * 
		 * @param	eventType
		 * @param	commandImpl
		 */
		public function registrerCommand( eventType:String, commandImpl:Class ):void
		{
			if(!hasRegisteredCommand(eventType))
		}
		
		/**
		 * 
		 * @param	eventType
		 */
		public function unregisterCommand( eventType:String ):void
		{
			if (hasRegisteredCommand(eventType))
			{
				_commandMap.fixed = false;
			}
			else
			{
				//TODO
			}
		}
		
		public function hasRegisteredCommand(eventType:String):Boolean
		{
			return hasEventListener( eventType );
		}
		
		/**
		 * Public property
		 */
		public function set viewManager( val:IViewManager ):void
		{
			
		}
		public function get viewManager():IViewManager
		{
			
		}
		
		private function getCommandInfoByEventType( eventType:String ):ICommandInfo
		{
			_filterCmdInfoEventType = eventType;
			
			return _commandMap.filter(filterCmdInfoByEventType, this)[0];
		}
		
		private var _filterCmdInfoEventType:String;
		private function filterCmdInfoByEventType():Boolean
		
	}
}