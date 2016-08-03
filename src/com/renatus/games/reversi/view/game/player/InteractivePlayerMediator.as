package com.renatus.games.reversi.view.game.player 
{
	import com.renatus.games.reversi.model.field.ICell;
	import com.renatus.games.reversi.model.field.IFieldCells;
	import com.renatus.games.reversi.model.field.enums.CellState;
	import com.renatus.games.reversi.model.player.IPlayer;
	import com.renatus.games.reversi.view.game.GameView;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.ButtonState;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * The interactive extension of BasePlayerMediator
	 * @author Mihaylenko A.L.
	 */
	public final class InteractivePlayerMediator extends BasePlayerMediator
	{
		private static const MAX_DRAG_DIST:Number = 50;
		
		private var _modelCellX:int=-1;
		private	var _modelCellY:int=-1;
		
		private var _currentMovement:Point = new Point( -1, -1);
		
		private var _currentSelectedCell:ICell;
		
		private var _state:String;
		private var _triggerBounds:Rectangle = new Rectangle();
		
		/**
		 * Constructor.
		 */
		public function InteractivePlayerMediator( gameView:GameView, playerModel:IPlayer, cellsModel:IFieldCells ) 
		{
			super(gameView, playerModel, cellsModel);
		}
		
		
		
		/**
		 * @inheritDoc
		 */
		internal override function extendMove():void 
		{
			addInteractiveEvents();
		}
		
		internal override  function moveComplete():void 
		{
			removeInteractiveEvents();
			super.moveComplete();
		}
		
		private function addInteractiveEvents():void
		{
			_gameView.fieldCellsView.addEventListener(TouchEvent.TOUCH, fieldCells_TOUCH_Handler);
		}
		
		
		
		private function removeInteractiveEvents():void
		{
			_gameView.fieldCellsView.removeEventListener(TouchEvent.TOUCH, fieldCells_TOUCH_Handler);
		}
		
		private function fieldCells_TRIGGERED_Handler(e:Event):void 
		{
			checkMovementFinish();
		}
		
		private function fieldCells_TOUCH_Handler(e:TouchEvent):void
		{
			const allTouches:Vector.<Touch> = e.getTouches( _gameView.fieldCellsView );
			const currentMovementTouch:Touch = allTouches && allTouches.length?allTouches[0]:null;
			if ( currentMovementTouch )
			{
				currentMovementTouch.getLocation( _gameView.fieldCellsView, _currentMovement );
				tryToSetCellTarget();
			}
			checkViewTriggered( e );
		}
		
		private function checkViewTriggered( event:TouchEvent ):void
		{
            var touch:Touch = event.getTouch(_gameView.fieldCellsView);
            var isWithinBounds:Boolean;

            if (touch == null)
            {
                _state = ButtonState.UP;
            }
            else if (touch.phase == TouchPhase.HOVER)
            {
                _state = ButtonState.OVER;
            }
            else if (touch.phase == TouchPhase.BEGAN && _state != ButtonState.DOWN)
            {
                _triggerBounds = _gameView.fieldCellsView.getBounds(_gameView.stage, _triggerBounds);
                _triggerBounds.inflate(MAX_DRAG_DIST, MAX_DRAG_DIST);

                _state = ButtonState.DOWN;
            }
            else if (touch.phase == TouchPhase.MOVED)
            {
                isWithinBounds = _triggerBounds.contains(touch.globalX, touch.globalY);

                if (_state == ButtonState.DOWN && !isWithinBounds)
                {
                    // reset button when finger is moved too far away ...
                    _state = ButtonState.UP;
                }
                else if (_state == ButtonState.UP && isWithinBounds)
                {
                    // ... and reactivate when the finger moves back into the bounds.
                    _state = ButtonState.DOWN;
                }
            }
            else if (touch.phase == TouchPhase.ENDED && _state == ButtonState.DOWN)
            {
                _state = ButtonState.UP;
				checkMovementFinish();
            }
		}
		
		private function checkMovementFinish():void
		{
			if (_currentSelectedCell && _playerModel.possibleMoves.indexOf(_currentSelectedCell) >= 0)
			{
				removeInteractiveEvents();
				_playerModel.currentMove = _currentSelectedCell;
				_cellsModel.makeMove( _playerModel );
				
				_currentSelectedCell = null;
				_currentMovement.setTo( -1, -1);
				moveComplete();
			}
		}
		
		private function tryToSetCellTarget(  ):void
		{
			var toModelCellX:int = Math.floor(_currentMovement.x / _gameView.cellViewSize);
			var toModelCellY:int = Math.floor(_currentMovement.y / _gameView.cellViewSize);
			var coordinatesChanged:Boolean;
			//trace(_currentMovement);
			if ( toModelCellX != _modelCellX  )
			{
				_modelCellX = toModelCellX;
				coordinatesChanged = true;
			}
			
			if ( toModelCellY != _modelCellY  )
			{
				_modelCellY = toModelCellY;
				coordinatesChanged = true;
			}
			
			if ( coordinatesChanged )
			{
				const toNewModel:ICell = _cellsModel.getCellAt( _modelCellX, _modelCellY );
				if (_currentSelectedCell && toNewModel != _currentSelectedCell)
				{
					_gameView.getEntityViewByModel(_currentSelectedCell).clearHover();
					_currentSelectedCell = null;
				}
				_currentSelectedCell = toNewModel;
				
				if ( _currentSelectedCell )
				{
					if ( _currentSelectedCell.state != CellState.EMPTY )
					{
						_currentSelectedCell = null;
					}
					else
					{
						_gameView.getEntityViewByModel(_currentSelectedCell).setHover( _playerModel.targetCellState, _playerModel.possibleMoves.indexOf(_currentSelectedCell)==-1);
					}
				}
				
			}
		}
		
		override public function destroy():void 
		{
			removeInteractiveEvents();
			super.destroy();
		}
	}
}