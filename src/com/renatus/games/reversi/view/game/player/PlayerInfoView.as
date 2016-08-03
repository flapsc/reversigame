package com.renatus.games.reversi.view.game.player 
{
	import com.renatus.games.reversi.model.IReversiGameModel;
	import com.renatus.games.reversi.model.player.IPlayer;
	import com.renatus.games.reversi.services.fonts.StaticFontService;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.AssetManager;
	import com.renatus.games.reversi.services.view.impl.starling.BaseStarlingView;
	import flash.geom.Rectangle;
	
	/**
	 * @author Mihaylenko A.L.
	 */
	public class PlayerInfoView extends BaseStarlingView 
	{
		private var _tfScore:TextField;
		
		private var _tfLabel:TextField;
		
		private var _chipView:Image;
		
		private var _background:Quad;
		
		private var _player:IPlayer;
		
		public function PlayerInfoView() 
		{
			super();
			touchable = false;
		}
		
		public function drawPlayerView( player:IPlayer, assetChipPrefix:String ):void
		{
			_player = player;
			const tfHeight:uint = 40;
			_tfLabel = new TextField(_viewPort.width, tfHeight, player.isBot?"Bot mehanics":"Human mehanics", new TextFormat(StaticFontService.globalAppFontName, 16, 0x000000));
			_chipView = new Image( _assetManager.getTexture( assetChipPrefix + player.targetCellState ) );
			
			_chipView.x = (_viewPort.width - _chipView.width) * .5;
			_chipView.y = tfHeight;
			
			_tfScore = new TextField(_viewPort.width, tfHeight, "Score:2", new TextFormat(StaticFontService.globalAppFontName, 16, 0x000000));
			_tfScore.y = _chipView.y + _chipView.height + tfHeight * .5;
			
			addChild( _tfLabel );
			addChild( _chipView );
			addChild( _tfScore );
			alpha = .4;
			
		}
		
		public function setActive( player:IPlayer ):void
		{
			alpha = player == _player?1:.4;
		}
		
		public function updateScores( gameField:IReversiGameModel ):void
		{
			var value:uint = gameField.fieldCells.getCountFieldCellsByState( _player.targetCellState );
			_tfScore.text = "Score:" + value.toString();
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
	}

}