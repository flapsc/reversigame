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
		
		/**
		 * Current game field cell
		 * @param	x - Current cell x
		 * @param	y - Current cell y
		 * @return field cell model.
		 */
		function getCellAt( x:uint, y:uint ):ICell;
		
		/**
		 * Current game field cells model.
		 */
		function get cells():Vector.<ICell>;
	}
}