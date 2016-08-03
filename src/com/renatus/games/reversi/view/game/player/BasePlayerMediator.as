package com.renatus.games.reversi.view.game.player 
{
	import com.renatus.games.reversi.model.field.IFieldCells;
	import com.renatus.games.reversi.model.player.IPlayer;
	import com.renatus.games.reversi.view.game.GameView;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class BasePlayerMediator extends EventDispatcher
	{
		
		static public const PLAYER_MOVEMENT_COMPLETE:String = "PlayerMovementComplete";
		
		//Current player model
		internal var _playerModel:IPlayer;
		
		//Current cells movel
		internal var _cellsModel:IFieldCells;
		
		//Corrent game view.
		internal var _gameView:GameView;
		
		//
		internal var _hasNoMovesForPlayer:Boolean;
		
		/**
		 * Constructor.
		 */
		public function BasePlayerMediator( gameView:GameView, playerModel:IPlayer, cellsModel:IFieldCells ) 
		{
			_playerModel = playerModel;
			_cellsModel = cellsModel;
			_gameView = gameView;
		}
		
		public final function acivate():void
		{
			_hasNoMovesForPlayer = false;
			
			_cellsModel.calculatecPossibleMoves(_playerModel);
			
			if ( _playerModel.possibleMoves )
			{
				extendMove();
			}
			else
			{
				_hasNoMovesForPlayer = true;
				moveComplete();
			}
		}
		
		/**
		 * Override in extension for make move.
		 */
		internal function extendMove():void{}
		
		
		internal function moveComplete():void
		{
			dispatchEventWith(PLAYER_MOVEMENT_COMPLETE, false, {hasNoMoves:_hasNoMovesForPlayer});
		}
		
		public function destroy():void
		{
			_playerModel = null;
			_cellsModel = null;
			_gameView = null;
		}
	}

}