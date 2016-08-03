package com.renatus.games.reversi.model.player 
{
	import com.renatus.games.reversi.model.field.ICell;
	/**
	 * Reversi game player model
	 * @author Mihaylenko A.L.
	 */
	public final class ReversiPlayerModel implements IPlayer
	{
		
		private var _targetCellState:uint;
		private var _isBot:Boolean;
		private var _possibleMoves:Vector.<ICell>;
		private var _currentMove:ICell;
		
		/**
		 * Constructor
		 */
		public function ReversiPlayerModel(){}
		
		/**
		 * Initialize current player model.
		 * @param	Current player cell state, valid values !CellState.EMPTY
		 * @param	isBot - true if this bot model.
		 */
		public function init( targetCellState:uint, isBot:Boolean=false ):void
		{
			_targetCellState = targetCellState;
			_isBot = isBot;
		}
		
		/**
		 * Public property( read only ).
		 * Current player cell state, valid values !CellState.EMPTY
		 */
		public function get targetCellState():uint
		{
			return _targetCellState;
		}
		
		
		/**
		 * If current player model is bot.
		 */
		public function get isBot():Boolean{ return _isBot; }
		
		
		/**
		 * Public property( read/write ).
		 * When model calculate possible moves for this player,
		 * then cashed this cells.
		 * @default null when not have moves for this player.
		 */
		public function set possibleMoves( value:Vector.<ICell> ):void
		{
			_possibleMoves = value;
		}
		public function get possibleMoves():Vector.<ICell>
		{
			return _possibleMoves;
		}
		
		/**
		 * Public property( read/write ).
		 * Set current player cell for make move.
		 */
		public function set currentMove( value:ICell ):void
		{
			_currentMove = value;
		}
		public function get currentMove():ICell
		{
			return _currentMove;
		}
		
		/**
		 * Destroy allocated data.
		 */
		public function destroy():void
		{
			_currentMove = null;
			_possibleMoves = null;
		}
	}

}