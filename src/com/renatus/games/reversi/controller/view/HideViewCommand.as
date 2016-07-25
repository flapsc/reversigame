package com.renatus.games.reversi.controller.view 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class HideViewCommand extends BaseViewCommand 
	{
		internal final override function internalExecute():Boolean
		{
			_context.viewManager.hideAllViewById(_eventView.viewId);
			return true;
		}
	}

}