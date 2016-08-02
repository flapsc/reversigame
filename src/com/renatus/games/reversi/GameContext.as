package com.renatus.games.reversi 
{
	import com.renatus.games.reversi.controller.CommandInfo;
	import com.renatus.games.reversi.controller.ICommand;
	import com.renatus.games.reversi.controller.ICommandInfo;
	import com.renatus.games.reversi.model.IReversiGameModel;
	import com.renatus.games.reversi.services.log.ILogger;
	import com.renatus.games.reversi.services.view.api.IViewManager;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import flash.utils.getQualifiedClassName;
	import starling.utils.AssetManager;
	
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
		private var _assetManager:AssetManager;
		private var _gameModel:IReversiGameModel;
		
		public function GameContext()
		{
			_commandMap = Vector.<ICommandInfo>([]);
			_commandMapLn = 0;
		}
		
		
		/**
		 * Initialize game context
		 * @param	stage - current application flash.display.stage
		 * @param	viewManagerClassImpl IViewManager class implementation.
		 * @param	gameModelClassImpl IReversiGameModel class implementation
		 * @param	loggerClassImpl ILogger class implementation.
		 */
		public function init
		( 
			stage:Stage, 
			viewManagerClassImpl:Class, 
			gameModelClassImpl:Class,
			loggerClassImpl:Class
		):void	
		{
			_logger = new loggerClassImpl();	
			_gameModel = new gameModelClassImpl();
			_viewManager = new viewManagerClassImpl();
			_viewManager.init(stage, _logger, viewManagerComplete);
			
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
				
				
				_commandMap.fixed = false;
				_commandMap[_commandMapLn] = new CommandInfo(eventType, commandImpl, _commandMapLn, once);
				_commandMapLn++;
				_commandMap.fixed = true;
				
				addEventListener(eventType, globalContextEventListener, false, int.MAX_VALUE);
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
				
				var idx:int = _commandMap.indexOf(getCommandInfoByEventType(eventType));
				if ( idx >= 0 )
				{
					_commandMap.fixed = false;
					_commandMap.splice(idx, 1)[0].destroy();
					_commandMapLn--;
					_commandMap.fixed = true;
				}
				else
				{
					_logger.log( "[GameContext]::unregisterCommand(", eventType, ") command not registered" );
				}
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
		
		/**
		 * Current reversi game model
		 */
		public function get gameModel():IReversiGameModel{ return _gameModel; }
		
		/**
		 * Public property( read only )
		 */
		public function get logger():ILogger{ return _logger; }
		
		/**
		 * Public property( read only )
		 * Current starling asset manager instance.
		 */
		public function get assetManager():AssetManager{ return _assetManager; }
		
		
		
		private function viewManagerComplete():void
		{
			createAssetManager();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function globalContextEventListener( event:Event ):void
		{
			const info:ICommandInfo = getCommandInfoByEventType( event.type )
			if ( info )
			{
				const cmd:ICommand = new info.commandImpl();
				
				if ( !cmd.execute(this, event) )
					_logger.log("Error execute command", getQualifiedClassName(cmd));
				
				if ( info.isSingleExecutable )
					unregisterCommand(event.type);
				
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
		
		private function createAssetManager():void
		{
			_assetManager = new AssetManager();
			_assetManager.verbose = Capabilities.isDebugger;
		}
	}
}