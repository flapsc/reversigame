package com.renatus.games.reversi.model.field 
{
	import com.renatus.games.reversi.model.field.enums.CellNeighbors;
	import com.renatus.games.reversi.model.field.enums.CellState;
	/**
	 * Base reversi grid cell model implementation
	 * @author Mihaylenko A.L.
	 */
	public final class ReversiCellModel implements ICell
	{
		//
		private var _x:uint;
		
		//
		private var _y:uint;
		
		//
		private var _state:uint;
		
		//
		private var _neighbors:Vector.<ICell>;
		
		//
		private var _gridSize:uint;
		
		/**
		 * Constructor.
		 */
		public function ReversiCellModel(){}
	
		/**
		 * Initialize current cell
		 * @param	x field cell x.
		 * @param	y field cell y.
		 * @param	gridSize - grid cell size
		 */
		public function init(x:uint, y:uint, gridSize:uint, initState:uint):void
		{
			_x = x;
			_y = y;
			_state = initState;
			// need to calculate bounds 0... to check neighbors.
			_gridSize = gridSize-1;
		}
		
		/**
		 * Update current cell neighbors,
		 * save naighbor indexes and link on field.
		 * @param	field - Current game field.
		 */
		public function updateNeighbors( grid:Vector.<Vector.<ICell>> ):void
		{
			_neighbors = Vector.<ICell>([]);
			_neighbors.length = CellNeighbors.NEIGHBORS_LENGTH;
			_neighbors.fixed = true;
			
			_neighbors[CellNeighbors.LEFT] = _x > 0?grid[_x - 1][_y]:null;
			_neighbors[CellNeighbors.LEFT_BOTTOM] = _x > 0 && _y < _gridSize?grid[_x - 1][_y + 1]:null;
			_neighbors[CellNeighbors.BOTTOM] = _y < _gridSize?grid[_x][_y + 1]:null;
			_neighbors[CellNeighbors.BOTTOM_RIGHT] = _y < _gridSize && _x < _gridSize?grid[_x + 1][_y + 1]:null;
			_neighbors[CellNeighbors.RIGHT] = _x < _gridSize?grid[_x + 1][_y]:null;
			_neighbors[CellNeighbors.RIGHT_TOP] = _x < _gridSize && _y>0 ? grid[_x+1][_y-1]:null;
			_neighbors[CellNeighbors.TOP] = _y > 0?grid[_x][_y - 1]:null;
			_neighbors[CellNeighbors.LEFT_TOP] = _x > 0 && _y > 0?grid[_x - 1][_y - 1]:null;
		}
		
		/**
		 * Public property( read/write ).
		 * Current cell state, valid values 0- empty,
		 * 1- first player, 2- second player( @see enums.CellState )
		 */
		public function get state():uint{ return _state; }
		public function set state( value:uint ):void{ _state = value; }
		
		
		/**
		 * Field cell grid x.
		 */
		public function get x():uint{return _x; }
		
		/**
		 * Field cell grid y.
		 */
		public function get y():uint{ return _y; }
		
		/**
		 * 
		 * @param	state - current state to make move.
		 * @return length of move, if 0 - can't move.
		 */
		public function canMove( state:uint ):uint
		{
			if (_state != CellState.EMPTY)
				return 0;
			
			var moveLength:uint;
			for ( var idx:uint = 0; idx < CellNeighbors.NEIGHBORS_LENGTH; idx++ )
			{
				moveLength += canMoveToNaighbor( idx, state );
			}
			
			return moveLength;
		}
		
		
		
		/**
		 * Make move to current cell.
		 * @param	state - current state to move.
		 */
		public function makeMove( state:uint ):void
		{
			_state = state;
			
			for ( var idx:uint = 0; idx < CellNeighbors.NEIGHBORS_LENGTH; idx++ )
			{
				if ( canMoveToNaighbor( idx, _state ) )
					makeMoveToNaighbor(idx);
			}
		}
		/**
		 * Get current neighbor at this cell.
		 * @param	value - neighbor predefine index( @see enums.CellNeighbors )
		 * @return cell neighbor mocel.
		 */
		public function getNeighbor( value:uint ):ICell
		{
			return _neighbors[value];
		}
		/**
		 * Destroy allocated data.
		 */
		public function destroy():void
		{
			_neighbors.fixed = false;
			_neighbors.length = 0;
			_neighbors = null;
		}
		
		private function canMoveToNaighbor( neighborIdx:uint, toState:uint ):uint
		{
			var length:uint = 0;
			var cell:ICell = this;
			while ( cell = cell.getNeighbor(neighborIdx) )
			{
				if (cell.state == CellState.EMPTY)
					return 0;
				else if (cell.state == toState)
					return length;
					
				length++;
			}
			return 0;
		}
		
		/**
		 * Make move to current neighbor.
		 * @param	neighborIdx - current neighbor index( @see enums.CellNeighbors )
		 */
		private function makeMoveToNaighbor( neighborIdx:uint ):void
		{
			var cell:ICell = this;
			while ( cell = cell.getNeighbor(neighborIdx) )
			{
				if (cell.state == _state)
					break;
					
				cell.state = _state;
			}
		}
	}
}