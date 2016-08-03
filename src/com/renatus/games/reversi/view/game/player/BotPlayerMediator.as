package com.renatus.games.reversi.view.game.player 
{
	import com.renatus.games.reversi.model.field.IFieldCells;
	import com.renatus.games.reversi.model.player.IPlayer;
	import com.renatus.games.reversi.view.game.GameView;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class BotPlayerMediator extends BasePlayerMediator
	{
		/**
		 * Constructor.
		 */
		public function BotPlayerMediator( gameView:GameView, playerModel:IPlayer, cellsModel:IFieldCells ) 
		{
			super(gameView, playerModel, cellsModel);
		}
		
		private var _strategy:IBotMoveStrategy;
		/**
		 * Set current bot move strategy
		 */
		public function set currentMoveStrategy( strategy:IBotMoveStrategy ):void{_strategy = strategy;}
		
		/**
		 * @inheritDoc
		 */
		internal override  function extendMove():void 
		{
			_strategy.makeMove(_playerModel, _cellsModel, moveComplete);
		}
		
		
		override public function destroy():void 
		{
			_strategy.destroy();
			_strategy = null;
			super.destroy();
		}
	}

}