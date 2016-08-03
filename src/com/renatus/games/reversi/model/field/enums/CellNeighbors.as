package com.renatus.games.reversi.model.field.enums 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class CellNeighbors 
	{
		
		//All neighbors length.
		public static const NEIGHBORS_LENGTH:uint = 8;
		
		/**
		 * Current left neighbor at target cell- 
		 * 0 0 0
		 * 1 X 0
		 * 0 0 0
		 */
		public static const LEFT:uint = 0;
		
		/**
		 * Current left bottom neighbor at target cell- 
		 * 0 0 0
		 * 0 X 0
		 * 1 0 0
		 */
		public static const LEFT_BOTTOM:uint = 1;
		
		/**
		 * Current bottom neighbor at target cell- 
		 * 0 0 0
		 * 0 X 0
		 * 0 1 0
		 */
		public static const BOTTOM:uint = 2;
		
		/**
		 * Current bottom right neighbor at target cell- 
		 * 0 0 0
		 * 0 X 0
		 * 0 0 1
		 */
		public static const BOTTOM_RIGHT:uint = 3;

		/**
		 * Current right neighbor at target cell- 
		 * 0 0 0
		 * 0 X 1
		 * 0 0 0
		 */
		public static const RIGHT:uint = 4;

		/**
		 * Current right top neighbor at target cell- 
		 * 0 0 1
		 * 0 X 0
		 * 0 0 0
		 */
		public static const RIGHT_TOP:uint = 5;

		/**
		 * Current top neighbor at target cell- 
		 * 0 1 0
		 * 0 X 0
		 * 0 0 0
		 */
		public static const TOP:uint = 6;
		
		
		/**
		 * Current left top neighbor at target cell- 
		 * 1 0 0
		 * 0 X 0
		 * 0 0 0
		 */
		public static const LEFT_TOP:uint = 7;		
		
	}

}