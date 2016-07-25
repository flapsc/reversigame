package com.renatus.games.reversi.controller 
{
	import com.renatus.games.reversi.IGameContext;
	import flash.events.Event;
	/**
	 * Startup game command, executes when game context are ready.
	 * @author Mihaylenko A.L.
	 */
	public final class StartupCommand implements ICommand 
	{
		
		public function StartupCommand() 
		{
			
		}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		public function execute( context:IGameContext, eventModel:Event ):Boolean
		{
			/**
			 * Entry point,
			 * start application here.
			 */
			//context.registrerCommand(
			return true;
			
		}
		
	}

}