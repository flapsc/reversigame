package com.renatus.games.reversi.model.field 
{
	import com.renatus.games.reversi.model.player.IPlayer;
	/**
	 * Base implementation of field cells model interface( IFieldCells )
	 * @author Mihaylenko A.L.
	 */
	public final class ReversiFieldCellsModel implements IFieldCells 
	{
		//Current cells model.
		private var _cells:Vector.<ICell>;
		private var _gridCells:Vector.<Vector.<ICell>>;
		private var _cellsLength:uint;
		private var _gridSize:uint;
		
		/**
		 * Constructor.
		 */
		public function ReversiFieldCellsModel() 
		{
			
		}
		
		/**
		 * Initlize game field, 
		 * @param	size - Current size of field matrix size X size
		 * @param	initialState - Current field cells initial state.
		 */
		public function init( size:uint, initialState:Vector.<Vector.<uint>> ):void
		{
			_gridSize = size;
			_cellsLength = size * size;
			reset(initialState);
		}
		
		/**
		 * Reset field cells to initialize state
		 */
		public function reset(initialState:Vector.<Vector.<uint>>):void
		{
			var x:uint;
			var y:uint;
			
			if (!_cells)
			{
				_cells = Vector.<ICell>([]);
				_cells.length = _cellsLength;
				_cells.fixed = true;
				
				
				
				_gridCells = Vector.<Vector.<ICell>>(([]));
				
				_gridCells.length = _gridSize;
				_gridCells.fixed = true;
				
				var cell:ICell;
				var column:Vector.<ICell>;
				var cellsLn:uint = 0;
				//Fill cells and grid.
				for ( x=0; x < _gridSize; x++ )
				{
					column = Vector.<ICell>([]);
					column.length = _gridSize;
					column.fixed = true;
					
					for ( y = 0; y < _gridSize; y++ )
					{
						cell = new ReversiCellModel();
						cell.init(x, y, _gridSize, initialState[x][y]);
						
						_cells[cellsLn++]=
						column[y] = cell;
					}
					_gridCells[x] = column;
				}
				
				//Update cells neighbors
				for ( x = 0; x < _cellsLength; x++ )
					_cells[x].updateNeighbors(_gridCells);
			}
			else
			{
				for ( x=0; x < _gridSize; x++ )
					for ( y = 0; y < _gridSize; y++ )
						_gridCells[x][y].state = initialState[x][y];
			}
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
			return x < _gridSize && y < _gridSize?_gridCells[x][y]:null;
		}
		
		/**
		 * Calculation of possible moves, for current player.
		 * @param	player - Player model, for calculate and cashed foundet moves.
		 */
		public function calculatecPossibleMoves( player:IPlayer ):void
		{
			cellStateTypeFilter = player.targetCellState;
			const moves:Vector.<ICell> = _cells.filter(filterCellsByPossibleMoves, this);
			player.possibleMoves = moves.length?moves:null;

		}
		
		/**
		 * When player choose a move, then make move in a model
		 * @param	player - Current player model.
		 * @return	The result of a move by the player
		 */
		public function makeMove( player:IPlayer ):Boolean
		{
			if ( player.currentMove )
			{
				player.currentMove.makeMove( player.targetCellState );
				
				player.possibleMoves = null;
				player.currentMove = null;
				return true;
			}
			else
			{
				return false;
			}
		}
		/**
		 * Calculate count cells with current cell state
		 * @param	cellState - Current cell state.
		 * @return calculated cells number.
		 */
		public function getCountFieldCellsByState( cellState:uint ):uint
		{
			cellStateTypeFilter = cellState;
			
			return _cells.filter(filterCellsByState,this).length;
		}
		public function get cells():Vector.<ICell>{ return _cells; }
		
		/////////////////////////////////////////////////////////////////////
		//				Vector.<Cell> helper filter inline methods.
		/////////////////////////////////////////////////////////////////////
		
		private static var cellStateTypeFilter:uint;
		/**
		 * Filter template function,
		 * filter cells by cell state.
		 */
		[Inline]
		private static function filterCellsByState( cell:ICell, index:int, vec:Vector.<ICell> ):Boolean
		{
			return cell.state == cellStateTypeFilter;
		}
		
		[Inline]
		private static function filterCellsByPossibleMoves(cell:ICell, index:int, vec:Vector.<ICell>):Boolean
		{
			return cell.canMove(cellStateTypeFilter);
		}
		
	}
}