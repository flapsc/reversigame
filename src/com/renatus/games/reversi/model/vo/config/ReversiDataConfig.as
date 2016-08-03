package com.renatus.games.reversi.model.vo.config 
{
	/**
	 * Reversi data config
	 * @author Mihaylenko A.L.
	 */
	public final class ReversiDataConfig implements IReversiDataConfig
	{
		
		private var _fieldSize:uint;
		private var _filedViewSize:uint;
		private var _fieldEntityViewSize:uint;
		private var _fieldViewCellBgFillColor:uint;
		private var _fieldViewCellBgLineColor:uint;
		private var _fieldCellEntityAssetNamePrefix:String;
		
		private var _defaultInitialState:Vector.<Vector.<uint>>;
		
		/**
		 * Constructor.
		 */
		public function ReversiDataConfig(){}
		
		
		/**
		 * Serialize current data config.
		 * @param	data - JSON data format.
		 */
		public function serialize( data:Object ):void
		{
			_fieldSize = uint(data.fieldSize);
			_filedViewSize = uint( data.filedViewSize );
			_fieldEntityViewSize = uint( data.fieldEntityViewSize );
			_fieldViewCellBgFillColor = uint( data.fieldViewCellBgFillColor );
			_fieldViewCellBgLineColor = uint( data.fieldViewCellBgLineColor );
			_fieldCellEntityAssetNamePrefix = String( data.fieldCellEntityAssetNamePrefix );
			
			_defaultInitialState = Vector.<Vector.<uint>>([]);
			_defaultInitialState.length = _fieldSize;
			_defaultInitialState.fixed = true;
			
			for ( var i:uint = 0; i < _fieldSize; i++ )
			{
				_defaultInitialState[i] = Vector.<uint>(data.defaultInitialState[i]);
				_defaultInitialState[i].fixed = true;
			}
		}
		
		/**
		 * Current field cell size( fieldSize X fieldSize )
		 */

		public function get fieldSize():uint{ return _fieldSize; }
		
		/**
		 * Default filed cells initial state.
		 */
		public function get defaultInitialState():Vector.<Vector.<uint>>{ return _defaultInitialState; }
		
		/**
		 * Current field view size.( width=height )
		 */
		public function get filedViewSize():uint{ return _filedViewSize; }
		
		/**
		 * Current field cell entity view size( width=height )
		 */
		public function get fieldEntityViewSize():uint{ return _fieldEntityViewSize; }
		
		/**
		 * 
		 */
		public function get fieldViewCellBgFillColor():uint{return _fieldViewCellBgFillColor; }
		
		/**
		 * 
		 */
		public function get fieldViewCellBgLineColor():uint{ return _fieldViewCellBgLineColor; }
		
		/**
		 * Current asset field cell prefix,
		 * for get asset by state and prefix( example "fieldCellPrefix_1" - asset for empty cell ).
		 */
		public function get fieldCellEntityAssetNamePrefix():String{ return _fieldCellEntityAssetNamePrefix; }
	}
}