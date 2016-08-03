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
		 * @param	gridSize - grid cell size
		 */
		function init(x:uint, y:uint, gridSize:uint, initState:uint):void;
		
		/**
		 * Update current cell neighbors,
		 * save naighbor indexes and link on field.
		 * @param	field - Current game field.
		 */
		function updateNeighbors( grid:Vector.<Vector.<ICell>> ):void;
		
		/**
		 * Public property( read/write ).
		 * Current cell state, valid values 0- empty,
		 * 1- first player, 2- second player( @see enums.CellState )
		 */
		function get state():uint;
		function set state( value:uint ):void;
		
		/**
		 * Field cell grid x.
		 */
		function get x():uint;
		
		/**
		 * Field cell grid y.
		 */
		function get y():uint;
		
		/**
		 * 
		 * @param	state - current state to make move.
		 * @return length of move, if 0 - can't move.
		 */
		function canMove( state:uint ):uint;
		
		/**
		 * Make move to current cell.
		 * @param	state - current state to move.
		 */
		function makeMove( state:uint ):void;
		
		/**
		 * Destroy allocated data.
		 */
		function destroy():void;
		
		/**
		 * Get current neighbor at this cell.
		 * @param	value - neighbor predefine index( @see enums.CellNeighbors )
		 * @return cell neighbor mocel.
		 */
		function getNeighbor( value:uint ):ICell;
	}
}