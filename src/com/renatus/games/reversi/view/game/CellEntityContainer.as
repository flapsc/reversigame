package com.renatus.games.reversi.view.game 
{
	import com.renatus.games.reversi.model.field.enums.CellState;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class CellEntityContainer extends Image 
	{
		private var _currentState:uint = CellState.EMPTY;
		private var _states:Vector.<Texture>;
		private var _view:Image;
		
		public function CellEntityContainer() 
		{
			super();
		}
		/**
		 * Initialize current entity view container.
		 * @param	states
		 */
		public function init( states:Vector.<Texture> ):void
		{
			touchable = false;
		}
		
		/**
		 * Update current view cell state.
		 * @param	state - Current cell state.
		 */
		public function updateState( state:uint ):void
		{
			if (_currentState == state)
				return;
				
			texture = _states[state];
			filter = 
		}
	}

}