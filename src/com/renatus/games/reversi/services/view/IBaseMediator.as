package com.renatus.games.reversi.services.view 
{
	import com.renatus.games.reversi.IGameContext;
	
	/**
	 * Base mediator interface.
	 * @author Mihaylenko A.L.
	 */
	public interface IBaseMediator 
	{
		/**
		 * Initielize current mediator.
		 * @param	view - Current view.
		 */
		function init( view:Object, gameContext:IGameContext ):void;
		
		/**
		 * Show target view.
		 * @param	displayList - Current display list, for add view.
		 * @param 	onComplete - callback, executes when show view complete.
		 */
		function show( displayList:Object, onComplete:Function=null ):void;
		
		/**
		 * Hide current view, 
		 * @param	onComplete - callback, executes when hide target view complete.
		 */
		function hide( onComplete:Function = null ):void;
		
		/**
		 * Destroy allocated data.
		 */
		function destroy():void;
	}
	
}