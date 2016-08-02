package com.renatus.games.reversi.view.loader 
{
	import com.renatus.games.reversi.services.fonts.StaticFontService;
	import com.renatus.games.reversi.services.view.impl.starling.BaseStarlingView;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	/**
	 * BaseStarlingView extension, 
	 * the loader view ext.
	 * @author Mihaylenko A.L.
	 */
	public final class LoaderView extends BaseStarlingView
	{
		//Current progress bar height.
		static private const BAR_HEIGHT_VIEWPORT_PERCENT:Number = .03;
		
		static private const BAR_WIDTH_VIEWPORT_PERCENT:Number = .5;
		
		//Current progress bar background canvas.
		private var _progressBarBg:Image;
		
		//Current progress bar fill qad.
		private var _progressBarFill:Image;
		
		//Current progress text field label.
		private var _tfLoaderLabel:TextField;
		
		/**
		 * Constructor
		 */
		public function LoaderView(){}
		
		public override function draw(viewPort:Rectangle, assetManager:AssetManager):void
		{
			touchable = false;
			var width:Number = viewPort.width * BAR_WIDTH_VIEWPORT_PERCENT;
			var height:Number = viewPort.height * BAR_HEIGHT_VIEWPORT_PERCENT;
			var textHeight:Number = 25;
			var bmd:BitmapData;
			
			const shape:Shape = new Shape();
			shape.graphics.beginFill(0x1F1F1F);
			shape.graphics.drawRect(0, 0, width, height);
			
			bmd = new BitmapData(width, height, true, 0x000000);
			bmd.draw(shape);
			
			_progressBarFill = new Image( Texture.fromBitmapData(bmd) );
			_progressBarFill.scaleX = 0;
            addChild(_progressBarFill);
			
			shape.graphics.clear();
			shape.graphics.lineStyle(2, 0xFFFFFF);
			shape.graphics.drawRect(0, 0, width, height);
			
			bmd = new BitmapData(width, height, true, 0x000000);
			bmd.draw(shape);
			
			_progressBarBg = new Image( Texture.fromBitmapData( bmd ) );
			addChild(_progressBarBg);
			
			
			var textFieldFormat:TextFormat = new TextFormat(StaticFontService.globalAppFontName, 16, 0xFFFFFF);
			
			_tfLoaderLabel = new TextField(width, textHeight, "", textFieldFormat);
			_tfLoaderLabel.y = height * 1.1;
			addChild( _tfLoaderLabel );
			
		}
		
		/**
		 * Update current view progress fill.
		 * @param	progress - Current progress to fill( valid value 0...1 )
		 */
		public function updateProgress( progress:Number ):void
		{
			_progressBarFill.scaleX = progress;
		}
		
		public function set label( value:String ):void
		{
			_tfLoaderLabel.text  = value;
		}
		/**
		 * @inheritDoc
		 */
		public final override  function dispose():void 
		{
			if ( _progressBarBg )
			{
				removeChild( _progressBarBg, true );
				_progressBarBg.texture.dispose();
				_progressBarBg = null;
			}
			
			if ( _progressBarFill )
			{
				removeChild( _progressBarFill, true );
				_progressBarFill.texture.dispose();
			}
			
			if (_tfLoaderLabel)
			{
				removeChild(_tfLoaderLabel, true);
				_tfLoaderLabel = null;
			}
			
			super.dispose();
		}
		
	}
}