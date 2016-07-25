package com.renatus.games.reversi 
{
	import com.renatus.games.reversi.controller.CommandInfo;
	import com.renatus.games.reversi.controller.ICommand;
	import com.renatus.games.reversi.controller.ICommandInfo;
	import com.renatus.games.reversi.services.log.ILogger;
	import com.renatus.games.reversi.services.view.IViewManager;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class GameContext extends EventDispatcher implements IGameContext
	{
		
		private var _commandMap:Vector.<ICommandInfo>;
		private var _commandMapLn:uint;
		
		private var _viewManager:IViewManager;
		private var _logger:ILogger;
		
		public function GameContext()
		{
			_commandMap = Vector.<ICommandInfo>([]);
			_commandMapLn = 0;
		}
		
		
		/**
		 * Initialize game context
		 * @param	stage - current application flash.display.stage
		 * @param	viewManagerClassImpl IViewManager class implementation.
		 */
		public function init( stage:Stage, viewManagerClassImpl:Class, loggerClassImpl:Class):void
		{			

			_viewManager = new viewManagerClassImpl();
			_viewManager.init(stage, viewManagerComplete);
			
			_logger = new loggerClassImpl();
		}
		
		/**
		 * 
		 * @param	eventType
		 * @param	commandImpl
		 */
		public function registrerCommand( eventType:String, commandImpl:Class, once:Boolean=false ):void
		{
			if (!hasRegisteredCommand(eventType))
			{
				
				addEventListener(eventType, globalContextEventListener, false, int.MAX_VALUE);
				_commandMap.fixed = false;
				_commandMap[_commandMapLn] = new CommandInfo(eventType, commandImpl, _commandMapLn, once);
				_commandMapLn++;
				_commandMap.fixed = true;
			}
			else
			{
				//TODO
			}
		}
		
		/**
		 * 
		 * @param	eventType
		 */
		public function unregisterCommand( eventType:String ):void
		{
			
			if (hasRegisteredCommand(eventType))
			{
				removeEventListener(eventType, globalContextEventListener);
				
				const idx:int = getCommandInfoByEventType(eventType).mapIndex;
				_commandMap.fixed = false;
				_commandMap.splice(idx, 1)[0].destroy();
				_commandMapLn--;
				_commandMap.fixed = true;
			}
			else
			{
				//TODO
			}
		}
		
		public function hasRegisteredCommand(eventType:String):Boolean
		{
			_filterCmdInfoEventType = eventType;
			return _commandMap.filter(filterCmdInfoByEventType, this).length;
		}
		
		/**
		 * Public property( read only )
		 */
		public function get viewManager():IViewManager{return _viewManager; }
		
		
		private function viewManagerComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function globalContextEventListener( event:Event ):void
		{
			const info:ICommandInfo = getCommandInfoByEventType( event.type )
			if ( info )
			{
				const cmd:ICommand = new info.commandImpl();
				
				if ( !cmd.execute(this, event) )
				{
					
				}
			}
		}
		
		private function getCommandInfoByEventType( eventType:String ):ICommandInfo
		{
			_filterCmdInfoEventType = eventType;
			
			return _commandMap.filter(filterCmdInfoByEventType, this)[0];
		}
		private var _filterCmdInfoEventType:String;
		private function filterCmdInfoByEventType( item:ICommandInfo, index:int, orig:Vector.<ICommandInfo> ):Boolean
		{
			return item.eventType == _filterCmdInfoEventType;
		}
		
		public function get logger():ILogger{ return _logger; }
	}
}