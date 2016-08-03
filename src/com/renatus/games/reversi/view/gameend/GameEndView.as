package com.renatus.games.reversi.view.gameend 
{
	import com.renatus.games.reversi.model.player.IPlayer;
	import com.renatus.games.reversi.services.fonts.StaticFontService;
	import starling.display.Button;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.AssetManager;
	import com.renatus.games.reversi.services.view.impl.starling.BaseStarlingView;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class GameEndView extends BaseStarlingView 
	{
		static private const BG_TEXTNAME:String = "intro_background";
		static private const RESTARTNTM_NAME:String = "restart_btn";
		
		private var _tfInfo:TextField;
		private var _background:Image;
		private var _restart:Button;
		private var _winnerChip:Image;
		/**
		 * Constructor.
		 */
		public function GameEndView() 
		{
		}
		
		public override  function draw(viewPort:Rectangle, assetManager:AssetManager):void 
		{
			super.draw(viewPort, assetManager);
			_background = new Image( assetManager.getTexture(BG_TEXTNAME) );
			_background.touchable = false;
			addChild(_background);
			
			var textFieldFormat:TextFormat = new TextFormat(StaticFontService.globalAppFontName, 25, 0x000000);
			var textHeight:uint = 80;
			_tfInfo = new TextField(_background.width,  textHeight, "", textFieldFormat);
			_tfInfo.y = uint(textHeight * .5);
			
			addChild( _tfInfo );
			
			
			_restart = new Button( assetManager.getTexture(RESTARTNTM_NAME) );
			_restart.scale = 1.5;
			
			_restart.y = _background.height - _restart.height * .5;
			_restart.x = ( _background.width - _restart.width) * .5;
			_restart.scaleWhenOver = 1.1;
			_restart.scaleWhenDown = .95;
			
			addChild( _restart );
			
		}
		
		public function drawWinner( chipAssetPrefix:String, player:IPlayer ):void
		{
			_winnerChip = new Image( _assetManager.getTexture( chipAssetPrefix + player.targetCellState ) );
			_winnerChip.scale = 1.5;
			
			_winnerChip.x = (_background.width - _winnerChip.width) * .5;
			_winnerChip.y = _tfInfo.y + 100;
			
			_tfInfo.text = player.isBot?"Bot win!":"Player win!";
			
			addChild( _winnerChip );
		}
		
		public function get restartBtn():Button{ return _restart; }
		
	}

}