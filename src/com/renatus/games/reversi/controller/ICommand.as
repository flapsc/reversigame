package com.renatus.games.reversi.controller 
{
	import com.renatus.games.reversi.IGameContext;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface ICommand 
	{
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		function execute( context:IGameContext, eventModel:Event ):Boolean;
	}
	
}