package com.renatus.games.reversi.model.field 
{
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface ICell 
	{
		/**
		 * Update current cell neighbors,
		 * save naighbor indexes and link on field.
		 * @param	field - Current game field.
		 */
		function updateNeighbors( field:Vector.<ICell> );
		
		/**
		 * Public property( read/write ).
		 * Current cell state, valid values 0- empty,
		 * 1- first player, 2- second player( @see enums.CellState )
		 */
		function get state():uint;
		function set state( value:uint ):void;
		
		
	}
	
}