package com.renatus.games.reversi.controller.assets 
{
	import com.renatus.games.reversi.IGameContext;
	import com.renatus.games.reversi.controller.ICommand;
	import com.renatus.games.reversi.controller.view.events.ViewEvent;
	import com.renatus.games.reversi.view.GameViewEnums;
	import flash.events.Event;
	import starling.utils.AssetManager;
	
	/**
	 * Add external assets to starling asset manager queue.
	 * @author Mihaylenko A.L.
	 */
	public final class LoadExternalAssetsCommand implements ICommand
	{
		
		/**
		 * Constructor.
		 */
		public function LoadExternalAssetsCommand(){}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		public function execute( context:IGameContext, eventModel:Event ):Boolean
		{
			/**
			 * Add to queue assets, 
			 * game config,
			 * game atlass
			 */
			context.assetManager.enqueue("content/reversi-config.json", "content/game-atlass.png", "content/game-atlass.xml");
			context.dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, GameViewEnums.LOADER ) );
			return true;
		}
	}
}