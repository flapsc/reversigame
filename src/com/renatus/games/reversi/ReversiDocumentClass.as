package com.renatus.games.reversi 
{
	import com.renatus.games.reversi.controller.StartupCommand;
	import com.renatus.games.reversi.model.ReversiGameModel;
	import com.renatus.games.reversi.services.log.TraceLogger;
	import com.renatus.games.reversi.services.view.impl.starling.StarlingViewManager;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class ReversiDocumentClass extends Sprite 
	{
		
		private var _gameContext:IGameContext;
		
		/**
		 * Constructor.
		 */
		public function ReversiDocumentClass() 
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		private function init( event:Event=null ):void
		{
			if ( event )
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			
			
			
			_gameContext = new GameContext();
			_gameContext.registrerCommand(Event.COMPLETE, StartupCommand, true);
			_gameContext.init(stage, StarlingViewManager, ReversiGameModel, TraceLogger);
		}
	}
}