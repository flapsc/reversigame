package com.renatus.games.reversi.view.game.player 
{
	import com.renatus.games.reversi.model.field.IFieldCells;
	import com.renatus.games.reversi.model.player.IPlayer;
	
	/**
	 * Base interface for bot strategy move.
	 * @author Mihaylenko A.L.
	 */
	public interface IBotMoveStrategy 
	{
		/**
		 * @param	field
		 */
		function makeMove( botPlayerModel:IPlayer, field:IFieldCells, moveCompleteCallback:Function ):void;
		
		function destroy():void;
	}
	
}