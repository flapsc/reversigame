package com.renatus.games.reversi.view.game 
{
	import com.renatus.games.reversi.model.field.enums.CellState;
	import starling.display.Image;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class CellEntityContainer extends Image 
	{
		private var _currentState:uint = CellState.EMPTY;
		private var _states:Vector.<Texture>;
		private var _hovered:Boolean;
		
		public function CellEntityContainer(states:Vector.<Texture>) 
		{
			_states = states;
			super(_states[_currentState]);
			visible =
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
			clearHover();
			_currentState = state;
			texture = _states[_currentState];
			visible = _currentState != CellState.EMPTY;
			
		}
		
		public function setHover( toState:uint, err:Boolean ):void
		{
			if (_currentState != CellState.EMPTY || _hovered)
				return;
				
			_hovered = true;
			texture = _states[toState];
			alpha = .85;
			
			if ( err )
			{
				const filter:ColorMatrixFilter = new ColorMatrixFilter();
				filter.tint( 0xFF0000, .8);
				this.filter = filter;
			}
			
			visible = true;
		}
		
		public function clearHover():void
		{
			if (!_hovered)
				return;
			_hovered = false;
			visible = false;
			filter = null;
			texture = null;
			alpha = 1;
		}
		
		override public function dispose():void 
		{
			if ( _states )
			{
				_states.fixed = false;
				_states.length = 0;
				_states = null;
			}
			super.dispose();
		}
	}

}