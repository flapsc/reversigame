package com.renatus.games.reversi.view.gameend 
{
	import com.renatus.games.reversi.controller.view.events.ViewEvent;
	import com.renatus.games.reversi.services.view.impl.starling.BaseStarlingMediator;
	import com.renatus.games.reversi.view.GameViewEnums;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class GameEndMediator extends BaseStarlingMediator 
	{
		private var _gameEndView:GameEndView;
		
		public function GameEndMediator(){}
		
		override protected function drawView():void 
		{
			super.drawView();
			_gameEndView = _baseView as GameEndView;
			_gameEndView.drawWinner(_gameContext.gameModel.dataConfig.fieldCellEntityAssetNamePrefix, _gameContext.gameModel.winner );
		}
		
		
		override protected function showComplete():void 
		{
			_gameEndView.restartBtn.addEventListener(Event.TRIGGERED, restartBtnTriggered);
		}
		
		private function restartBtnTriggered(e:Event):void 
		{
			_gameEndView.restartBtn.removeEventListener(Event.TRIGGERED, restartBtnTriggered);
			_gameEndView.restartBtn.useHandCursor = false;
			
			_gameContext.dispatchEvent( new ViewEvent( ViewEvent.HIDE_VIEW, GameViewEnums.GAME_END ) );
			
		}
		
		override protected function hideComplete():void 
		{
			_gameContext.dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, GameViewEnums.INTRO ) );
			super.hideComplete();
		}
		
	}

}