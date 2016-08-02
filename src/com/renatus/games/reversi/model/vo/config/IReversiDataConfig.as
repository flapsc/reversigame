package com.renatus.games.reversi.model.vo.config 
{
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface IReversiDataConfig
	{
		/**
		 * Serialize current data config.
		 * @param	data - Object
		 */
		function serialize( data:Object ):void;
		
		/**
		 * Current field cell size( fieldSize X fieldSize )
		 */
		function get fieldSize():uint;
		
		/**
		 * Default filed cells initial state.
		 */
		function get defaultInitialState():Vector.<Vector.<uint>>;
		
		/**
		 * Current field view size.( width=height )
		 */
		function get filedViewSize():uint;
		
		/**
		 * Current field cell entity view size( width=height )
		 */
		function get fieldEntityViewSize():uint;
		
		/**
		 * 
		 */
		function get fieldViewCellBgFillColor():uint;
		
		/**
		 * 
		 */
		function get fieldViewCellBgLineColor():uint;
		
		/**
		 * Current asset field cell prefix,
		 * for get asset by state and prefix( example "fieldCellPrefix_1" - asset for empty cell ).
		 */
		function get fieldCellEntityAssetNamePrefix():String;
		
		
		
	}
	
}