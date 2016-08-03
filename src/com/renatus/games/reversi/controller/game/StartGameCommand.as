package com.renatus.games.reversi.controller.game 
{
	import com.renatus.games.reversi.IGameContext;
	import com.renatus.games.reversi.controller.ICommand;
	import com.renatus.games.reversi.controller.view.events.ViewEvent;
	import com.renatus.games.reversi.model.field.enums.CellState;
	import com.renatus.games.reversi.model.player.IPlayer;
	import com.renatus.games.reversi.model.player.ReversiPlayerModel;
	import com.renatus.games.reversi.view.GameViewEnums;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class StartGameCommand implements ICommand
	{
		/**
		 * Constructor.
		 */
		public function StartGameCommand(){}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		public function execute( context:IGameContext, eventModel:Event ):Boolean
		{
			
			var firstPlayer:IPlayer = new ReversiPlayerModel();
			if (context.gameModel.humanStateChoose == CellState.EMPTY)
			{
				context.gameModel.humanStateChoose = CellState.PLAYER_FIRST;
				firstPlayer.init(CellState.PLAYER_FIRST, true);
				
			}
			else
			{
				
				firstPlayer.init( context.gameModel.humanStateChoose );
			}
			
			var secondPlayer:IPlayer = new ReversiPlayerModel();
			secondPlayer.init
			( 
				context.gameModel.humanStateChoose == CellState.PLAYER_FIRST
					?
					CellState.PLAYER_SECOND
					:
					CellState.PLAYER_FIRST,
				true
			);
			context.gameModel.startGame(Vector.<IPlayer>([firstPlayer, secondPlayer]));
			
			context.dispatchEvent( new ViewEvent(ViewEvent.SHOW_VIEW, GameViewEnums.GAME_STATE) );
			
			return true;
		}
		
	}

}