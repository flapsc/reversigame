package com.renatus.games.reversi.model 
{
	import com.renatus.games.reversi.model.field.IFieldCells;
	import com.renatus.games.reversi.model.player.IPlayer;
	import com.renatus.games.reversi.model.vo.config.IReversiDataConfig;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface IReversiGameModel 
	{
		/**
		 * Public property( read only ).
		 */
		function get dataConfig():IReversiDataConfig;
		
		/**
		 * Start current game.
		 * @param	players - Current game players.
		 * @param	gameFieldState - Initial game( if null set from default congig )
		 */
		function startGame( players:Vector.<IPlayer>, gameFieldState:Vector.<Vector.<uint>> = null ):void;
		
		/**
		 * Public property( read only ).
		 * Current game field cells.
		 */
		function get fieldCells():IFieldCells;
		
		/**
		 * Current player for move.
		 */
		function get playerForMove():IPlayer;
		
		function get playerForMoveIndex():uint;
		
		/**
		 * Switch player for move.
		 */
		function switchPlayer():void;
		
		/**
		 * Current human state choose.
		 */
		function set humanStateChoose( value:uint ):void;
		function get humanStateChoose():uint;
		
		function set playerNoMovesCount(val:uint):void;
		function get playerNoMovesCount():uint;
		
		function isGameEnd():Boolean;
		
		function get winner():IPlayer;
		
		function get players():Vector.<IPlayer>;
	}
	
}