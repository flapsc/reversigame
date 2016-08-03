package com.renatus.games.reversi.model.field 
{
	import com.renatus.games.reversi.model.player.IPlayer;
	
	/**
	 * Base interface of field cells.
	 * @author Mihaylenko A.L.
	 */
	public interface IFieldCells 
	{
		/**
		 * Initlize game field, 
		 * @param	size - Current size of field matrix size X size
		 * @param	initialState - Current field cells initial state.
		 */
		function init( size:uint, initialState:Vector.<Vector.<uint>> ):void;
		
		/**
		 * Reset field cells to initialize state
		 */
		function reset(initialState:Vector.<Vector.<uint>>):void;
		
		/**
		 * Clean up allocated data.
		 */
		function destroy():void;
		
		function getCellAt(x:uint, y:uint):ICell;
		
		function get cells():Vector.<ICell>;
		
		/**
		 * Calculation of possible moves, for current player.
		 * @param	player - Player model, for calculate and cashed foundet moves.
		 */
		function calculatecPossibleMoves( player:IPlayer ):void;
		
		/**
		 * When player choose a move, then make move in a model
		 * @param	player - Current player model.
		 * @return	The result of a move by the player
		 */
		function makeMove( player:IPlayer ):Boolean;
		
		/**
		 * Calculate count cells with current cell state
		 * @param	cellState - Current cell state.
		 * @return calculated cells number.
		 */
		function getCountFieldCellsByState( cellState:uint ):uint;
		
	}
}