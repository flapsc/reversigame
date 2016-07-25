package com.renatus.games.reversi.controller.view 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class RegisterViewCommand extends BaseViewCommand
	{
		
		public function RegisterViewCommand() 
		{
		}
		
		internal final override function internalExecute():Boolean
		{
			
			/**
			 * Entry point, regoster all game view's.
			 */
			return true;
		}
		
	}

}