package com.renatus.games.reversi.model.field 
{
	
	/**
	 * Base interface of field cells.
	 * @author Mihaylenko A.L.
	 */
	public interface IFieldCells 
	{
		/**
		 * Initlize game field, 
		 * @param	Current size of field matrix size X size
		 */
		function init( size:uint ):void;
		
		/**
		 * Reset field cells to initialize state( all cells is empty @see enums.CellState.EMPTY )
		 */
		function reset():void;
		
		/**
		 * Clean up allocated data.
		 */
		function destroy():void;
		
		/**
		 * Current game field cell
		 * @param	x - Current cell x
		 * @param	y - Current cell y
		 * @return field cell model.
		 */
		function getCellAt( x:uint, y:uint ):ICell;
	}
}