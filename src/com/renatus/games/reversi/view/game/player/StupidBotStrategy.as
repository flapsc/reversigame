package com.renatus.games.reversi.view.game.player 
{
	import com.renatus.games.reversi.model.field.ICell;
	import com.renatus.games.reversi.model.field.IFieldCells;
	import com.renatus.games.reversi.model.player.IPlayer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	/**
	 * Base implementation bot movement strategy.
	 * @author Mihaylenko A.L.
	 */
	public final class StupidBotStrategy implements IBotMoveStrategy
	{
		
		/**
		 * 2 sec delay, for simulate move.
		 */
		static private const DELAY_SIMULATE_STUPID:int = 100;
		
		private var _moveCompleteCallback:Function;
		
		private var _timeOutId:uint;
		
		/**
		 * Constructor.
		 */
		public function StupidBotStrategy(){}
		
		
		/**
		 * @param	field
		 */
		public final function makeMove( botPlayerModel:IPlayer, field:IFieldCells, moveCompleteCallback:Function ):void
		{
			_moveState = botPlayerModel.targetCellState;
			
			botPlayerModel.currentMove = botPlayerModel.possibleMoves.sort(sortByBestMove)[0];
			field.makeMove(botPlayerModel);
			_moveCompleteCallback = moveCompleteCallback;
			//TODO after test and debug mechanics.
			_timeOutId = setTimeout(setTimeCallback, DELAY_SIMULATE_STUPID);
			
		}
		
		private function setTimeCallback():void
		{
			_timeOutId = 0;
			_moveCompleteCallback.apply(this);
		}
		
		
		
		public function destroy():void
		{
			if ( _timeOutId )
			{
				clearTimeout(_timeOutId);
			}
			
			_moveCompleteCallback = null;
		}
		
		private  static var _moveState:uint;
		[Inline]
		static private function sortByBestMove( cellA:ICell, cellB:ICell ):Number
		{
			return cellB.canMove(_moveState) - cellA.canMove(_moveState);
		}
	}
}