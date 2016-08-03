package com.renatus.games.reversi.view.intro 
{
	import com.renatus.games.reversi.model.field.enums.CellState;
	import com.renatus.games.reversi.services.fonts.StaticFontService;
	import starling.display.Button;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.AssetManager;
	import com.renatus.games.reversi.services.view.impl.starling.BaseStarlingView;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	
	/**
	 * Base implementation of intro view.
	 * @author Mihaylenko A.L.
	 */
	public final class IntroView extends BaseStarlingView 
	{
		static private const PLAY_BTN_TEXTNAME:String = "intro_btn_play";
		static private const PLAY_BTN_DISABLE_TEXTNAME:String = "intro_btn_play_disable";
		static private const BG_TEXTNAME:String = "intro_background";
		
		// Current play button
		private var _btnPlay:Button;
		
		//Current background.
		private var _background:Image;
		
		//
		private var _tfInfo:TextField;
		
		private var _btnChipFirst:Button;
		private var _btnChipSecond:Button;
		private var _chipAssetPrefixName:String;
		/**
		 * Constructor.
		 */
		public function IntroView() {}
		
		
		/**
		 * @inheritDoc
		 */
		public override function draw(viewPort:Rectangle, assetManager:AssetManager):void 
		{
			super.draw(viewPort, assetManager);
			
			_background = new Image( assetManager.getTexture(BG_TEXTNAME) );
			_background.touchable = false;
			addChild(_background);
			
			_btnPlay = new Button( assetManager.getTexture(PLAY_BTN_TEXTNAME), "",null,null,assetManager.getTexture(PLAY_BTN_DISABLE_TEXTNAME));
			_btnPlay.scaleWhenDown = .9;
			_btnPlay.scaleWhenOver = 1.1;
			
			_btnPlay.x = (_background.width - _btnPlay.width) * .5;
			_btnPlay.y = _background.height - _btnPlay.height * .5;
			//_btnPlay.enabled = false;
			addChild( _btnPlay );
			
			var textFieldFormat:TextFormat = new TextFormat(StaticFontService.globalAppFontName, 25, 0x000000);
			var textHeight:uint = 80;
			_tfInfo = new TextField(_background.width,  textHeight, "", textFieldFormat);
			_tfInfo.y = uint(textHeight * .5);
			
			
			addChild( _tfInfo );
			
			
			_btnChipFirst = new Button(assetManager.getTexture(_chipAssetPrefixName+CellState.PLAYER_FIRST.toFixed()));
			_btnChipFirst.scaleWhenDown = .9;
			_btnChipFirst.scaleWhenOver = 1.1;
			_btnChipFirst.y = (_background.height - _btnChipFirst.height) * .5;
			_btnChipFirst.x = _background.width * .5 - _btnChipFirst.width;
			
			addChild( _btnChipFirst );
			
			_btnChipSecond = new Button(assetManager.getTexture(_chipAssetPrefixName+CellState.PLAYER_SECOND.toFixed()));
			_btnChipSecond.scaleWhenDown = .9;
			_btnChipSecond.scaleWhenOver = 1.1;
			_btnChipSecond.y = (_background.height - _btnChipSecond.height) * .5;
			_btnChipSecond.x = _background.width * .5 + _btnChipSecond.width * .5;
			
			addChild( _btnChipSecond );			
			
		}
		
		/**
		 * @inheritDoc
		 */
		public override  function dispose():void 
		{
			
			if (_btnPlay)
			{
				_btnPlay.removeFromParent(true);
				_btnPlay = null;
			}
			
			if (_background)
			{
				_background.removeFromParent( true );
				_background = null;
			}
			
			if ( _tfInfo )
			{
				_tfInfo.removeFromParent( true );
				_tfInfo = null;
			}
			
			if ( _btnChipFirst )
			{
				_btnChipFirst.removeFromParent(true);
				_btnChipFirst = null;
			}
			
			if ( _btnChipSecond )
			{
				_btnChipSecond.removeFromParent(true);
				_btnChipFirst = null;
			}
			
			super.dispose();
		}
		
		public function get btnPlay():Button{ return _btnPlay; }
		public function get tfInfo():TextField{ return _tfInfo; }
		public function get btnChipFirst():Button{ return _btnChipFirst;  }
		public function get btnChipSecond():Button{ return _btnChipSecond; }
		public function set chipAssetPrefixName( value:String ):void{ _chipAssetPrefixName = value; }
		
	}

}