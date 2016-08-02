package com.renatus.games.reversi.controller 
{
	import com.renatus.games.reversi.IGameContext;
	import com.renatus.games.reversi.controller.assets.AssetsEvent;
	import com.renatus.games.reversi.controller.assets.ExternalAssetsLoadedCommand;
	import com.renatus.games.reversi.controller.assets.LoadExternalAssetsCommand;
	import com.renatus.games.reversi.controller.view.HideViewCommand;
	import com.renatus.games.reversi.controller.view.ShowViewCommand;
	import com.renatus.games.reversi.controller.view.events.ViewEvent;
	import com.renatus.games.reversi.services.fonts.StaticFontService;
	import com.renatus.games.reversi.services.view.api.IViewManager;
	import com.renatus.games.reversi.view.GameViewEnums;
	import com.renatus.games.reversi.view.intro.IntroMediator;
	import com.renatus.games.reversi.view.intro.IntroView;
	import com.renatus.games.reversi.view.loader.LoaderMediator;
	import com.renatus.games.reversi.view.loader.LoaderView;
	import flash.events.Event;
	/**
	 * Startup game command, executes when game context are ready.
	 * @author Mihaylenko A.L.
	 */
	public final class StartupCommand implements ICommand 
	{
		/**
		 * Constructor.
		 */
		public function StartupCommand(){}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		public function execute( context:IGameContext, eventModel:Event ):Boolean
		{
			/**
			 * Entry point,
			 * start application here.
			 */
			//context.registrerCommand(
			
			/**
			 * TODO need create bitmap font manager for starling TextFields
			 * 
			 */
			StaticFontService.registerAppFonts();
			
			registerCommands( context );
			
			registerViews( context.viewManager );
			
			startGameApp( context );
			
			return true;
			
		}
		
		/**
		 * Register game commands.
		 * @param	context - Current game app context.
		 */
		private function registerCommands( context:IGameContext ):void
		{
			//register view manager commands
			context.registrerCommand(ViewEvent.SHOW_VIEW, ShowViewCommand);
			context.registrerCommand(ViewEvent.HIDE_VIEW, HideViewCommand);
			
			//register assets commands
			context.registrerCommand(AssetsEvent.LOAD_EXTERNAL_ASSETS, LoadExternalAssetsCommand, true );
			context.registrerCommand(AssetsEvent.EXTERNAL_ASSETS_LOADED, ExternalAssetsLoadedCommand, true );
		}
		
		private function registerViews( viewManager:IViewManager ):void
		{
			viewManager.registerView(GameViewEnums.LOADER, LoaderView, LoaderMediator);
			viewManager.registerView(GameViewEnums.INTRO, IntroView, IntroMediator);
		}
		
		
		private function startGameApp( context:IGameContext ):void
		{
			context.dispatchEvent( new AssetsEvent(AssetsEvent.LOAD_EXTERNAL_ASSETS) );
		}
		
	}

}