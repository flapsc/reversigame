package com.renatus.games.reversi.controller 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class CommandInfo implements ICommandInfo
	{
		
		
		
		public function CommandInfo(eventType:String, commandImpl:Class, mapIndex:uint) 
		{
			_eventType = eventType;
			_commandImpl = commandImpl;
		}
		
		private var _eventType:String;
		public function get eventType():String{return _eventType; }
		
		private var _commandImpl:Class;
		public function get commandImpl():Class{ return _commandImpl; }
		
		public function destroy():void
		{
			_commandImpl = null;
			_eventType = null;
		}
	}

}