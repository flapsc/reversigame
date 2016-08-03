package com.renatus.games.reversi.model.player 
{
	import com.renatus.games.reversi.model.field.ICell;
	
	/**
	 * Base interrface of player model
	 * @author Mihaylenko A.L.
	 */
	public interface IPlayer 
	{
		/**
		 * Initialize current player model.
		 * @param	Current player cell state, valid values !CellState.EMPTY
		 * @param	isBot - true if this bot model.
		 */
		function init( targetCellState:uint, isBot:Boolean=false ):void;
		
		/**
		 * Public property( read only ).
		 * Current player cell state, valid values !CellState.EMPTY
		 */
		function get targetCellState():uint;
		
		/**
		 * If current player model is bot.
		 */
		function get isBot():Boolean;
		
		/**
		 * Public property( read/write ).
		 * When model calculate possible moves for this player,
		 * then cashed this cells.
		 * @default null when not have moves for this player.
		 */
		function set possibleMoves( value:Vector.<ICell> ):void;
		function get possibleMoves():Vector.<ICell>;
		
		/**
		 * Set current player move.
		 */
		function set currentMove( value:ICell ):void;
		function get currentMove():ICell;
		
		/**
		 * Destroy allocated data.
		 */
		function destroy():void;
	}
	
}