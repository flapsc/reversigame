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
		 */
		function show( displayList:Object ):void;
		
		/**
		 * Hide current view, 
		 * @param hideComplete - callback, executes when hide complete.
		 */
		function hide( hideComplete:Function ):void;
		
		/**
		 * Destroy allocated data.
		 */
		function destroy():void;
	}
	
}