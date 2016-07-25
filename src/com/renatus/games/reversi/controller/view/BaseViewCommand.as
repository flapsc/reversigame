package com.renatus.games.reversi.controller.view 
{
	import com.renatus.games.reversi.controller.view.events.ViewEvent;
	import flash.events.Event;
	import com.renatus.games.reversi.IGameContext;
	import com.renatus.games.reversi.controller.ICommand;
	
	/**
	 * Base view event
	 * @author Mihaylenko A.L.
	 */
	public class BaseViewCommand implements ICommand
	{
		protected var _context:IGameContext;
		
		protected var _eventView:ViewEvent;
		
		public function BaseViewCommand() 
		{
			throw new RangeError("BaseViewCommand$ class cannot be instantiated", 2012);
		}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */		
		public final function execute(context:IGameContext, eventModel:Event):Boolean 
		{
			if ( eventModel is ViewEvent )
			{
				_context = context;
				_eventView = eventModel as ViewEvent;
				return internalExecute();
			}
			else
			{
				return false;
			}
			
		}
		
		/**
		 * Execute extension.
		 */
		internal function internalExecute():Boolean{ throw new RangeError("Ovveride internalExecute in extention"); }
		
	}

}