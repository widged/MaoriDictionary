package com.widged.maoriDictionary.dictionary.vo
{
	public class RowsCursor
	{
		public static const NEXT_PAGE:int       = 1;
		public static const PREVIOUS_PAGE:int   = 2;
		
		private var _start:int;
		private var _offset:int;
		private var _max:int;
		
		public function RowsCursor( max:int, offset:int = -1)
		{
			_start  = 0;       // row index to start at
			_offset = offset;  // number of rows to return
			_max = max;        // maximum number of rows
			if(_offset == -1) { _offset = _max; }
		}
		
		public function get start():int        { return _start;   }
		public function get offset():int       { return _offset;  }
		public function get max():int          { return _max;     }
		
		public function move(start:int):void
		{
			_start = start;
		}
		
	}
}