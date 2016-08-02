package com.renatus.games.reversi.model 
{
	import com.renatus.games.reversi.model.field.FieldCellsModel;
	import com.renatus.games.reversi.model.field.IFieldCells;
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
		
		/**
		 * Constructor.
		 */
		public function ReversiGameModel()
		{
			_dataConfig = new ReversiDataConfig();
			_fieldCells = new FieldCellsModel();
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
			
		}
		
		/**
		 * Public property( read only ).
		 * Current game field cells.
		 */
		public function get fieldCells():IFieldCells{ return _fieldCells; }
		
		/**
		 * Current human state choose.
		 */
		public function set humanStateChoose( value:uint ):void{ _humanStateChoose = value; }
		public function get humanStateChoose():uint{ return _humanStateChoose; }
		
		
		
	}

}