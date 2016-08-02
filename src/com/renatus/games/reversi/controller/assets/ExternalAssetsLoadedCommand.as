package com.renatus.games.reversi.controller.assets 
{
	import com.renatus.games.reversi.IGameContext;
	import com.renatus.games.reversi.controller.ICommand;
	import com.renatus.games.reversi.controller.view.events.ViewEvent;
	import com.renatus.games.reversi.view.GameViewEnums;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class ExternalAssetsLoadedCommand implements ICommand
	{
		/**
		 * Constructor.
		 */
		public function ExternalAssetsLoadedCommand(){}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		public function execute( context:IGameContext, eventModel:Event ):Boolean
		{
			context.dispatchEvent( new ViewEvent(ViewEvent.HIDE_VIEW, GameViewEnums.LOADER) );
			context.gameModel.dataConfig.serialize(context.assetManager.getObject("reversi-config"));
			context.viewManager.delayCall
			(
				function():void
				{
					context.dispatchEvent(new ViewEvent(ViewEvent.SHOW_VIEW, GameViewEnums.INTRO));
				},.5
			)
			return true;
		}
		
		
	}
}