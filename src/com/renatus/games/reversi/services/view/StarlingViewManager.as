package com.renatus.games.reversi.services.view 
{
	import flash.display.Stage;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class StarlingViewManager implements IViewManager 
	{
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
			
		}
	}

}