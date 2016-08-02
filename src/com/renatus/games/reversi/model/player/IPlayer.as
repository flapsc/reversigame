package com.renatus.games.reversi.model.player 
{
	
	/**
	 * Base interrface of player model
	 * @author Mihaylenko A.L.
	 */
	public interface IPlayer 
	{
		
		/**
		 * Initialize current player model.
		 * @param	Current player cell state, valid values !CellState.EMPTY
		 */
		function init( targetCellState:uint ):void;
		
		/**
		 * Public property( read only ).
		 * Current player cell state, valid values !CellState.EMPTY
		 */
		function get targetCellState():uint;
		
		/**
		 * If current player model is bot.
		 */
		function get isBot():Boolean;
		
		function get isFirstToMove():Boolean;
		function set isFirstToMove( val:Boolean ):void;
	}
	
}