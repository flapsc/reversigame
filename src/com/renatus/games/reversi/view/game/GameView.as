package com.renatus.games.reversi.view.game 
{
	import com.renatus.games.reversi.model.field.ICell;
	import com.renatus.games.reversi.services.view.impl.starling.BaseStarlingView;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class GameView extends BaseStarlingView 
	{
		private var _fieldCellsViewBackground:Image;
		private var _fieldCellsEntity:Vector.<CellEntityContainer>;
		private var _fieldCellSize:uint;
		
		public function GameView() 
		{
			super();
		}
		
		public function drawFieldCellsBackground
		(
			
		):void
		{
			
		}
		
		public function createFieldCellsEntityContainers( initialCellsModel:Vector.<ICell>, entitySize:uint ):void
		{
			const entityLn:uint = initialCellsModel.length;
			_fieldCellsEntity = Vector.<CellEntityContainer>();
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
				_fieldCellsEntity[cellModel.fieldIndex].updateState(cellModel.state);
			}
		}
		/**
		 * 
		 * @param	model
		 * @return
		 */
		public function getEntityViewByModel( model:ICell ):CellEntityContainer{ return _fieldCellsEntity[model.fieldIndex]; }
		
	}

}