package com.renatus.games.reversi.view.game 
{
	import com.renatus.games.reversi.controller.view.events.ViewEvent;
	import com.renatus.games.reversi.model.IReversiGameModel;
	import com.renatus.games.reversi.model.field.enums.CellState;
	import com.renatus.games.reversi.model.player.IPlayer;
	import com.renatus.games.reversi.model.vo.config.IReversiDataConfig;
	import com.renatus.games.reversi.services.view.impl.starling.BaseStarlingMediator;
	import com.renatus.games.reversi.view.GameViewEnums;
	import com.renatus.games.reversi.view.game.player.BasePlayerMediator;
	import com.renatus.games.reversi.view.game.player.BotPlayerMediator;
	import com.renatus.games.reversi.view.game.player.InteractivePlayerMediator;
	import com.renatus.games.reversi.view.game.player.PlayerInfoView;
	import com.renatus.games.reversi.view.game.player.StupidBotStrategy;
	import flash.geom.Rectangle;
	import starling.animation.Transitions;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class GameViewMediator extends BaseStarlingMediator
	{
		//Current game view
		private var _gameView:GameView;
		
		//Current game model
		private var _gameModel:IReversiGameModel;
		
		//Current player mediators.
		private var _playerMediators:Vector.<BasePlayerMediator>;
		
		private var _playersInfoView:Vector.<PlayerInfoView>;
		
		private var _isRestart:Boolean;
		
		/**
		 * Constructor.
		 */
		public function GameViewMediator() 
		{
			super();
		}
		
		public override  function destroy():void 
		{
			_playerMediators.fixed = false;
			
			while (_playerMediators.length)
			{
				_playerMediators.pop().destroy();
				
			}

			
			_playerMediators = null;
			_playersInfoView = null;
			_gameView = null;
			_gameModel = null;
			
			
			super.destroy();
		}
		
		public override  function show(displayList:Object):void 
		{
			_baseView.alpha = 0;
			
			displayList.addChild(_baseView);
			
			_gameContext.viewManager.tween
			(
				_baseView,
				.6,
				{alpha:1, transition:Transitions.EASE_OUT, onComplete:showComplete}
			);
			
		}
		
		
		protected override  function drawView():void 
		{
			super.drawView();
			
			_gameModel = _gameContext.gameModel;
			const config:IReversiDataConfig = _gameModel.dataConfig;
			const assetManager:AssetManager = _gameContext.assetManager;
			
			const entityViewStates:Vector.<Texture> =
			Vector.<Texture>
			(
				[ 
					null,
					assetManager.getTexture( config.fieldCellEntityAssetNamePrefix + CellState.PLAYER_FIRST.toString() ), 
					assetManager.getTexture( config.fieldCellEntityAssetNamePrefix + CellState.PLAYER_SECOND.toString() )
				]
			);
			entityViewStates.fixed = true;
			
			_gameView = _baseView as GameView;
			
			_gameView.drawFieldCellsBackground( config.filedViewSize, config.fieldSize, config.fieldViewCellBgFillColor, config.fieldViewCellBgLineColor );
			_gameView.createFieldCellsEntityContainers( config.fieldEntityViewSize, config.fieldSize, entityViewStates);
			_gameView.updateEntityStatesFromModel( _gameModel.fieldCells.cells );
			
			_gameView.drawUI( _gameModel.players, config.fieldCellEntityAssetNamePrefix  );
			
		}
		
		/**
		 * @inheritDoc
		 */
		protected override function showComplete():void 
		{
			// start game logic here.
			startGame();
		}
		
		private function startGame():void
		{
			createPlayerMediators();
			activateCurrentPlayerMediator();
			addUIEventListeners();
		}
		
		private function addUIEventListeners():void
		{
			_gameView.restartButton.addEventListener(Event.TRIGGERED, restartButton_TRIGGERED_Handler);
		}
		
		private function removeUIEventListeners():void
		{
			_gameView.restartButton.removeEventListener(Event.TRIGGERED, restartButton_TRIGGERED_Handler);
		}
		
		private function restartButton_TRIGGERED_Handler(e:Event):void 
		{
			removeUIEventListeners();
			_isRestart = true;
			_gameContext.dispatchEvent( new ViewEvent(ViewEvent.HIDE_VIEW, GameViewEnums.GAME_STATE) );
			
		}
		
		private function activateCurrentPlayerMediator():void
		{
			_playerMediators[_gameModel.playerForMoveIndex].acivate();
			_gameView.activateCurrentPlayerInfoView( _gameModel.playerForMove );
		}
		
		private function createPlayerMediators(  ):void
		{
			const players:Vector.<IPlayer> = _gameModel.players;
			const playersLn:uint = players.length;
			
			_playerMediators = Vector.<BasePlayerMediator>([]);
			_playerMediators.length = playersLn;
			_playerMediators.fixed = true;
			
			for ( var i:uint = 0; i < playersLn; i++ )
			{
				_playerMediators[i] = createMediatorByPlayerModel(players[i]);
				_playerMediators[i].addEventListener(BasePlayerMediator.PLAYER_MOVEMENT_COMPLETE, playerMediator_MovementComplete);
			}
		}
		
		private function playerMediator_MovementComplete( event:Event ):void
		{
			if ( event.data.hasNoMoves )
			{
				_gameModel.playerNoMovesCount++;
			}
			else
			{
				_gameModel.playerNoMovesCount = 0;
				_gameView.updateEntityStatesFromModel( _gameModel.fieldCells.cells );
			}
			
			if ( _gameModel.isGameEnd() )
			{
				gameEnd();
			}
			else
			{
				updatePlayersScores();
				_gameModel.switchPlayer();
				activateCurrentPlayerMediator();
			}
		}
		
		private function gameEnd():void
		{
			_gameContext.dispatchEvent( new ViewEvent(ViewEvent.HIDE_VIEW, GameViewEnums.GAME_STATE) );
		}
		
		private function updatePlayersScores():void
		{
			_gameView.updateScores( _gameModel );
		}
		
		
		override protected function hideComplete():void 
		{
			
			if ( _isRestart )
			{
				_gameContext.dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, GameViewEnums.INTRO ) );
			}
			else
			{
				_gameContext.dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, GameViewEnums.GAME_END ) );
			}
			super.hideComplete();
		}
		
		/**
		 * TODO need implement fabric mediator.
		 */
		private function createMediatorByPlayerModel( player:IPlayer ):BasePlayerMediator
		{
			if ( player.isBot )
			{
				var botPlayerMediator:BotPlayerMediator = new BotPlayerMediator( _gameView, player, _gameModel.fieldCells )
				
				botPlayerMediator.currentMoveStrategy = new StupidBotStrategy();
				
				return botPlayerMediator;
			}
			else
			{
				return new InteractivePlayerMediator( _gameView, player, _gameModel.fieldCells);
			}
		}
	}
}