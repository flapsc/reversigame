package com.renatus.games.reversi.view.intro 
{
	import com.renatus.games.reversi.model.field.enums.CellState;
	import com.renatus.games.reversi.services.view.impl.starling.BaseStarlingMediator;
	import starling.events.Event;
	import starling.filters.ColorMatrixFilter;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class IntroMediator extends BaseStarlingMediator
	{
		/**
		 * TODO need create and move texts to localization service
		 */
		static private const SELECT_CHIP_TEXT:String = "Select a chip to start game!"
		static private const FIRST_CHIP_SELECTED_TEXT:String = "Okay, you moves is first."
		static private const SECOND_CHIP_SELECTED_TEXT:String = "Okay, you moves is second."
		
		
		private var _introView:IntroView;
		private var _selectedPlayerCellState:uint;
		private var _selectedFilter:ColorMatrixFilter;
		protected override  function drawView():void 
		{
			_introView = _baseView as IntroView;
			_introView.chipAssetPrefixName = _gameContext.gameModel.dataConfig.fieldCellEntityAssetNamePrefix;
			
			super.drawView();
			
			_introView.tfInfo.text = SELECT_CHIP_TEXT;
		}
		/**
		 * @inheritDoc
		 */
		protected override  function showComplete():void 
		{
			_selectedFilter = new ColorMatrixFilter();
			_selectedFilter.adjustContrast(.5);
			
			addEventListeners();
		}
		
		/**
		 * 
		 */
		private function addEventListeners():void
		{
			_introView.btnChipFirst.addEventListener(Event.TRIGGERED, btnChipFirst_TRIGGERED_Handler);
			_introView.btnChipSecond.addEventListener(Event.TRIGGERED, btnChipSecond_TRIGGERED_Handler);
		}
		
		private function btnChipSecond_TRIGGERED_Handler(e:Event):void 
		{
			_selectedFilter = new ColorMatrixFilter();
			_selectedFilter.adjustContrast(1);
			
			_introView.btnChipSecond.touchable = false;
			_introView.btnChipSecond.filter = _selectedFilter;
			
			if (_selectedPlayerCellState)
			{
				_introView.btnChipFirst.filter = null;
				_introView.btnChipFirst.touchable = true;
			}
			_selectedPlayerCellState = CellState.PLAYER_SECOND;
			_introView.tfInfo.text = SECOND_CHIP_SELECTED_TEXT;
			_introView.btnPlay.enabled = true;
		}
		
		private function btnChipFirst_TRIGGERED_Handler(e:Event):void 
		{
			_selectedFilter = new ColorMatrixFilter();
			_selectedFilter.adjustContrast(1);
			
			_introView.btnChipFirst.touchable = false;
			_introView.btnChipFirst.filter = _selectedFilter;
			if (_selectedPlayerCellState)
			{
				_introView.btnChipSecond.filter = null;
				_introView.btnChipSecond.touchable = true;
			}			
			_selectedPlayerCellState = CellState.PLAYER_FIRST;			
			_introView.tfInfo.text = FIRST_CHIP_SELECTED_TEXT;
			_introView.btnPlay.enabled = true;
		}
		/**
		 * 
		 */
		private function removeEventListeners():void
		{
			
		}
		
	}
}