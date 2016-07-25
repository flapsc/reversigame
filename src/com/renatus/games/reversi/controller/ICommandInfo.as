package com.renatus.games.reversi.controller 
{
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface ICommandInfo 
	{
		function get eventType():String;
		function get commandImpl():Class;
		function get mapIndex():uint;
		function destroy():void;
	}
	
}