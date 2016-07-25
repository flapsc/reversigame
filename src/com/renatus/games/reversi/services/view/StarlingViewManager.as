package com.renatus.games.reversi.services.view 
{
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import starling.animation.Juggler;
	import starling.core.Starling;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class StarlingViewManager implements IViewManager 
	{
		private var _viewPort:Rectangle;
		
		private var _starling:Starling;
		//Current starling instance juggler, for animate view's.
		private var _currJugler:Juggler;
		
		private var _initComplete:Function;
		
		/**
		 * Constructor.
		 */
		public function StarlingViewManager(){}
		/**
		 * Initialize view manager.
		 * @param	stage - flash.display.Stage instance.
		 * 
		 */
		public function init( stage:Stage, onComplete:Function ):void
		{
			_initComplete = onComplete;
		}
		
		/**
		 * Register view.
		 * @param	id - Current unique view id.
		 * @param	viewImpl - Class implementation of view.
		 * @param	mediator - Class implementation of mediation view.
		 */
		public function registerView( id:uint, viewImpl:Class, mediator:Class):void
		{
			
		}
		
		/**
		 * Hide all view, by registered view id.
		 * @param	viewId - Current registered view id.
		 */
		public function hideAllViewById( viewId:uint ):void
		{
			
		}
		
		/**
		 * Show view.
		 * @param	viewId - registered view id.
		 */
		public function showView(viewId:uint):void
		{
			
		}
		
		/**
		 * Check registered view.
		 * @param	id - Current unique view id.
		 * @return result.
		 */
		public function isViewRegistered( id:uint ):Boolean
		{
			return false;
		}
		
		public function tween(target:Object, time:Number, properties:Object) : uint
		{
			return _currJugler.tween(target, time, properties);
		}
		
		public function removeTween(id:uint):void
		{
			_currJugler.removeByID(id);
		}
		
		public function get viewPort():Rectangle{ return _viewPort; }
	}

}