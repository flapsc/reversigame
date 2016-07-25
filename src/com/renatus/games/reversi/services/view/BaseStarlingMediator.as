package com.renatus.games.reversi.services.view 
{
	import com.renatus.games.reversi.IGameContext;
	import flash.geom.Rectangle;
	import starling.animation.Transitions;
	import starling.display.DisplayObject;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class BaseStarlingMediator implements IBaseMediator 
	{
		/**
		 * TODO
		 * need move to UIConfig.
		 */
		static private const TWEEN_SHOW_TIME:Number = .7;
		static private const TWEEN_HIDE_TIME:Number = .4;
		static private const SHOW_TRAMSITION:String = Transitions.EASE_OUT;
		static private const SHOW_DELAY:Number = .3;//delay before show( check create, construct view instance ).
		static private const HIDE_TRAMSITION:String = Transitions.EASE_IN;
		//////////////////////////////
		
		protected var _baseView:DisplayObject;
		protected var _gameContext:IGameContext;
		
		private var _hideComplete:Function;
		
		public function BaseStarlingMediator() 
		{
			
		}
		
		/**
		 * Initielize current mediator.
		 * @param	view - Current view.
		 */
		public function init( view:Object, gameContext:IGameContext ):void
		{
			_baseView = view as DisplayObject;
			_gameContext = gameContext;
		}
		
		/**
		 * Show target view.
		 * @param	displayList - Current display list, for add view.
		 */
		public function show( displayList:Object ):void
		{
			const viewPort:Rectangle = _gameContext.viewManager.viewPort;
			_baseView.x = viewPort.x + (viewPort.width - _baseView.width) * .5;
			_baseView.y = viewPort.y - _baseView.height;
			
			const tweenToY:int = viewPort.y + (viewPort.height - _baseView.height) * .5;
			
			_gameContext.viewManager.tween
			(
				_baseView,
				TWEEN_SHOW_TIME,
				{y:tweenToY, transition:SHOW_TRAMSITION, onComplete:showComplete, delay:SHOW_DELAY}
			);
			
		}
		
		/**
		 * Hide current view, 
		 */
		public function hide( hideComplete:Function ):void
		{
			
		}
		
		/**
		 * Destroy allocated data.
		 */
		public function destroy():void
		{
			_baseView.removeFromParent(true);
			_baseView = null;
			_gameContext = null;
		}
		/**
		 * Ovveride, and start mediate here
		 */
		protected function showComplete():void
		{
			
		}
		
		/**
		 * Stop mediate
		 */
		protected function hideComplete():void
		{
			if (_hideComplete != null)
			{
				_hideComplete.apply(this);
				_hideComplete = null;
			}
			destroy();
		}
		
	}

}