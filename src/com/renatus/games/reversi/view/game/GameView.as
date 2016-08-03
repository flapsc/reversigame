package com.renatus.games.reversi.view.game 
{
	import com.renatus.games.reversi.model.IReversiGameModel;
	import com.renatus.games.reversi.model.field.ICell;
	import com.renatus.games.reversi.model.player.IPlayer;
	import com.renatus.games.reversi.services.view.impl.starling.BaseStarlingView;
	import com.renatus.games.reversi.view.game.player.PlayerInfoView;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class GameView extends BaseStarlingView 
	{
		private var _fieldCellsViewBackground:Image;
		private var _fieldCellsEntity:Vector.<Vector.<CellEntityContainer>>;
		private var _fieldViewCellSize:uint;
		
		private var _playersInfoView:Vector.<PlayerInfoView>;
		//ui
		private var _restartBtn:Button;
		
		public function GameView() 
		{
			super();
		}
		
		
		public function drawFieldCellsBackground
		(
			viewCellsBackgroundSize:uint,
			cellsSize:uint,
			bgColor:uint,
			lineColor:uint
		):void
		{
			_fieldViewCellSize = Math.floor(viewCellsBackgroundSize / cellsSize);
			const shape:Shape = new Shape();
			shape.graphics.lineStyle(2, lineColor);
			shape.graphics.beginFill( bgColor );
			shape.graphics.drawRoundRect(0, 0, _fieldViewCellSize, _fieldViewCellSize, _fieldViewCellSize * .2);
			
			var bmd:BitmapData = new BitmapData( shape.width, shape.height, true, 0x000000 );
			bmd.draw( shape, null, null, null, null, true);
			
			shape.graphics.clear();
			
			shape.graphics.beginBitmapFill(bmd, null, true, true);
			shape.graphics.drawRect(0, 0, bmd.width * cellsSize, bmd.height * cellsSize );
			
			bmd = new  BitmapData( shape.width, shape.height, true, 0x000000 );
			bmd.draw( shape, null, null, null, null, true);
			
			_fieldCellsViewBackground = new Image( Texture.fromBitmapData(bmd) );
			
			_fieldCellsViewBackground.x = _viewPort.width - _fieldCellsViewBackground.width - _fieldViewCellSize * .5;
			_fieldCellsViewBackground.y = (_viewPort.height - _fieldCellsViewBackground.height) * .5;
			addChild( _fieldCellsViewBackground );
		}
		
		public function createFieldCellsEntityContainers( entityViewSize:uint, gridSize:uint, viewStates:Vector.<Texture> ):void
		{
			//const entityLn:uint = initialCellsModel.length;
			_fieldCellsEntity = Vector.<Vector.<CellEntityContainer>>([]);
			_fieldCellsEntity.length = gridSize;
			_fieldCellsEntity.fixed = true;
			_fieldViewCellSize+= 2;
			var initialX:uint = _fieldCellsViewBackground.x +4;
			var initialY:uint = _fieldCellsViewBackground.y +4;
			
			var column:Vector.<CellEntityContainer>;
			var cellEntity:CellEntityContainer;
			var y:uint;
			for ( var x:uint = 0; x < gridSize; x++ )
			{
				column = Vector.<CellEntityContainer>([]);
				column.length = gridSize;
				column.fixed = true;
				for (  y= 0; y < gridSize; y++ )
				{
					cellEntity = new CellEntityContainer( viewStates );

					cellEntity.width = entityViewSize;
					cellEntity.height = entityViewSize;	
					cellEntity.x = initialX + x * _fieldViewCellSize;
					cellEntity.y = initialY + y * _fieldViewCellSize;
					addChild( cellEntity );
					column[y] = cellEntity;
				}
				_fieldCellsEntity[x] = column;
			}
			
		}
		
		/**
		 * Update current cells view.
		 * @param	cellsModel - cells model to update.
		 */
		public function updateEntityStatesFromModel( cellsModel:Vector.<ICell> ):void
		{
			const ln:uint = cellsModel.length;
			var cellModel:ICell;
			for ( var idx:uint = 0; idx < ln; idx++ )
			{
				cellModel = cellsModel[idx];
				_fieldCellsEntity[cellModel.x][cellModel.y].updateState( cellModel.state );
			}
		}
		
		/**
		 * 
		 * @param	model
		 * @return
		 */
		public function getEntityViewByModel( model:ICell ):CellEntityContainer{ return _fieldCellsEntity[model.x][model.y]; }
		public function get fieldCellsView():Image{ return _fieldCellsViewBackground; }
		public function get cellViewSize():uint{ return _fieldViewCellSize }
		public function get restartButton():Button{ return _restartBtn; }
		
		public function drawUI( players:Vector.<IPlayer>, chipAssetNamePrefix:String):void
		{
			const uiViewPort:Rectangle = new Rectangle(0, 0, _fieldCellsViewBackground.x, _viewPort.height);
			_restartBtn = new Button(_assetManager.getTexture("restart_btn"));
			_restartBtn.x = (uiViewPort.width - _restartBtn.width) * .5;
			_restartBtn.y = _viewPort.height - _restartBtn.height * 1.25;
			
			addChild( _restartBtn );
			
			uiViewPort.height = _restartBtn.y;
			
			_playersInfoView = Vector.<PlayerInfoView>([]);
			var infoHeight:uint;
			var info:PlayerInfoView;
			var startY:uint = _restartBtn.height * .25;
			const playerLn:uint = players.length;
			for ( var i:uint = 0; i < playerLn; i++ )
			{
				info = new PlayerInfoView();
				info.draw(uiViewPort, _assetManager);
				info.drawPlayerView(players[i], chipAssetNamePrefix);
				info.y = startY + info.height * i * 1.25;
				
				
				_playersInfoView[i] = info;
				
				addChild(info);
			}
			
		}
		
		
		public function activateCurrentPlayerInfoView( player:IPlayer ):void
		{
			const playerLn:uint = _playersInfoView.length
			for ( var i:uint = 0; i < playerLn; i++ )
			{
				_playersInfoView[i].setActive( player );
			}
		}
		
		public function updateScores( gameModel:IReversiGameModel ):void
		{
			const playerLn:uint = _playersInfoView.length
			for ( var i:uint = 0; i < playerLn; i++ )
			{
				_playersInfoView[i].updateScores( gameModel );
			}			
		}
		
		override public function dispose():void 
		{
						
			_fieldCellsViewBackground.removeFromParent(true);
			
			_playersInfoView.fixed = false;
			
			while ( _playersInfoView.length)
			{
				_playersInfoView.pop().removeFromParent(true);
			}
			
			
			_fieldCellsEntity.fixed = false;
			var column:Vector.<CellEntityContainer>;
			while (_fieldCellsEntity.length)
			{
				column = _fieldCellsEntity.pop();
				column.fixed = false;
				while ( column.length )
				{
					column.pop().removeFromParent(true);
				}
			} 
			_fieldCellsEntity = null;
			_playersInfoView = null;
			_fieldCellsViewBackground = null;
			super.dispose();
		}
		
		
		
	}
}