package com.renatus.games.reversi.services.log 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class TraceLogger implements ILogger
	{
		
		public function TraceLogger() 
		{
			
		}
		
		public function log( ...args ):void
		{
			trace(args);
		}
		
	}

}