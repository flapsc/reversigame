package com.renatus.games.reversi.model.field 
{
	
	/**
	 * Base interface of cell model.
	 * @author Mihaylenko A.L.
	 */
	public interface ICell 
	{
		/**
		 * Initialize current cell
		 * @param	x field cell x.
		 * @param	y field cell y.
		 */
		function init(x:uint, y:uint):void;
		
		/**
		 * Update current cell neighbors,
		 * save naighbor indexes and link on field.
		 * @param	field - Current game field.
		 */
		function updateNeighbors( field:Vector.<ICell> ):void;
		
		/**
		 * Public property( read/write ).
		 * Current cell state, valid values 0- empty,
		 * 1- first player, 2- second player( @see enums.CellState )
		 */
		function get state():uint;
		function set state( value:uint ):void;
		
		/**
		 * Current field cells index.
		 */
		function get fieldIndex():uint;
		
		function get x():uint;
		function get y():uint;
	}
	
}