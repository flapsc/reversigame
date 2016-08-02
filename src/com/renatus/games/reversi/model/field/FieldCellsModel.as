package com.renatus.games.reversi.model.field 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class FieldCellsModel implements IFieldCells 
	{
		/**
		 * Constructor.
		 */
		public function FieldCellsModel() 
		{
			
		}
		
		/**
		 * Initlize game field, 
		 * @param	size - Current size of field matrix size X size
		 * @param	initialState - Current field cells initial state.
		 */
		public function init( size:uint, initialState:Vector.<Vector.<uint>> ):void
		{
			
		}
		
		/**
		 * Reset field cells to initialize state
		 */
		public function reset(initialState:Vector.<Vector.<uint>>):void
		{
			
		}
		
		/**
		 * Clean up allocated data.
		 */
		public function destroy():void
		{
			
		}
		
		/**
		 * Current game field cell
		 * @param	x - Current cell x
		 * @param	y - Current cell y
		 * @return field cell model.
		 */
		public function getCellAt( x:uint, y:uint ):ICell
		{
			return null
		}
		
		/**
		 * Current game field cells model.
		 */
		public function get cells():Vector.<ICell>{ return null; }
	}

}