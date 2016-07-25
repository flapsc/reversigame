package com.renatus.games.reversi.services.view 
{
	import flash.display.Stage;
	import flash.geom.Rectangle;
	/**
	 * Base interface of view manager.
	 * @author Mihaylenko A.L.
	 */
	public interface IViewManager
	{
		
		/**
		 * Initialize view manager.
		 * @param	stage - flash.display.Stage instance.
		 * 
		 */
		function init( stage:Stage, onComplete:Function ):void;
		
		/**
		 * Register view.
		 * @param	id - Current unique view id.
		 * @param	viewImpl - Class implementation of view.
		 * @param	mediator - Class implementation of mediation view.
		 */
		function registerView( id:uint, viewImpl:Class, mediator:Class):void;
		
		/**
		 * Hide all view, by registered view id.
		 * @param	viewId - Current registered view id.
		 */
		function hideAllViewById( viewId:uint ):void;
		
		/**
		 * Show view.
		 * @param	viewId - registered view id.
		 */
		function showView(viewId:uint):void;
		
		/**
		 * Check registered view.
		 * @param	id - Current unique view id.
		 * @return result.
		 */
		function isViewRegistered( id:uint ):Boolean;
		
		function tween(target:Object, time:Number, properties:Object) : uint;
		
		function removeTween(id:uint);
		
		function get viewPort():Rectangle;
		
	}
	
}