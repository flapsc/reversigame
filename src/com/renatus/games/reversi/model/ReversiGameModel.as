package com.renatus.games.reversi.model 
{
	import com.renatus.games.reversi.model.field.ReversiFieldCellsModel;
	import com.renatus.games.reversi.model.field.IFieldCells;
	import com.renatus.games.reversi.model.field.enums.CellState;
	import com.renatus.games.reversi.model.player.IPlayer;
	import com.renatus.games.reversi.model.vo.config.IReversiDataConfig;
	import com.renatus.games.reversi.model.vo.config.ReversiDataConfig;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class ReversiGameModel implements IReversiGameModel 
	{
		private var _dataConfig:IReversiDataConfig;
		private var _fieldCells:IFieldCells;
		private var _humanStateChoose:uint;
		private var _players:Vector.<IPlayer>;
		private var _playerForMoveIdx:uint;
		private var _playerNoMovesCount:uint;
		private var _playersLength:uint;
		private var _winnerPlayer:IPlayer;
		/**
		 * Constructor.
		 */
		public function ReversiGameModel()
		{
			_dataConfig = new ReversiDataConfig();
		}

		/**
		 * Public property( read only ).
		 */
		public function get dataConfig():IReversiDataConfig{ return _dataConfig; }
		
		
		/**
		 * Start current game.
		 * @param	players - Current game players.
		 * @param	gameFieldState - Initial game( if null set from default congig )
		 */
		public function startGame( players:Vector.<IPlayer>, gameFieldState:Vector.<Vector.<uint>> = null ):void
		{
			if ( _players )
			{
				_players.fixed = false;
				while (_players.length)
				{
					_players.pop().destroy();
				}
				_players = null;
			}
			
			_playerNoMovesCount = 0;
			_players = players;
			_players.fixed = true;
			_playersLength = _players.length;
			_playerForMoveIdx = 0;
			
			const playersLn:uint = _players.length;
			for ( _playerForMoveIdx; _playerForMoveIdx < playersLn; _playerForMoveIdx++ )
				if (_players[_playerForMoveIdx].targetCellState == CellState.PLAYER_FIRST)
					break;
			
			const initialeState:Vector.<Vector.<uint>> = gameFieldState?gameFieldState:_dataConfig.defaultInitialState;
			
			if ( !_fieldCells )
			{
				_fieldCells = new ReversiFieldCellsModel();
				_fieldCells.init(_dataConfig.fieldSize, initialeState);
			}
			else
			{
				_fieldCells.reset( initialeState );
			}
		}
		
		/**
		 * Public property( read only ).
		 * Current game field cells.
		 */
		public function get fieldCells():IFieldCells{ return _fieldCells; }
		
		
		/**
		 * Current player for move.
		 */
		public function get playerForMove():IPlayer{ return _players[_playerForMoveIdx]; }
		public function get playerForMoveIndex():uint{ return _playerForMoveIdx; }
		/**
		 * Switch player for move.
		 */
		public function switchPlayer():void
		{
			_playerForMoveIdx++;
			_playerForMoveIdx = _playerForMoveIdx == _playersLength?0:_playerForMoveIdx;
		}
		
		/**
		 * Current human state choose.
		 */
		public function set humanStateChoose( value:uint ):void{ _humanStateChoose = value; }
		public function get humanStateChoose():uint{ return _humanStateChoose; }
		
		public function set playerNoMovesCount(value:uint):void{ _playerNoMovesCount = value;  }
		public function get playerNoMovesCount():uint{ return _playerNoMovesCount; }
		
		public function isGameEnd():Boolean
		{
			var res:Boolean = Boolean(_playerNoMovesCount >= _playersLength || _fieldCells.getCountFieldCellsByState(CellState.EMPTY) == 0);
			if ( res )
			{
				checkWinner();
			}
			return res;
		}
		
		private function checkWinner():void
		{
			var currScore:uint;
			for ( var i:uint = 0;  i < _playersLength; i++)
			{
				var playerScore:uint = _fieldCells.getCountFieldCellsByState( _players[i].targetCellState );
				if ( currScore < playerScore )
				{
					_winnerPlayer = _players[ i ];
				}
			}
		}
		
		public function get players():Vector.<IPlayer>
		{
			return _players;
			
		}
		public function get winner():IPlayer{ return _winnerPlayer; }
	}
}