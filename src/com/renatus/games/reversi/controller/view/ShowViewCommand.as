package com.renatus.games.reversi.controller.view 
{
	import com.renatus.games.reversi.services.view.IViewManager;
	/**
	 * View manager command, show registered view.
	 * @author Mihaylenko A.L.
	 */
	public class ShowViewCommand extends BaseViewCommand
	{
		internal final override function internalExecute():Boolean
		{
			const viewManager:IViewManager = _context.viewManager;
			
			if ( viewManager.isViewRegistered(_eventView.viewId) )
			{
				viewManager.showView(_eventView.viewId);
				return true;
			}
			else
			{
				return false;
			}
		}
	}

}