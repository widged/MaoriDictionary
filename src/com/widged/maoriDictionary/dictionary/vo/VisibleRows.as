package com.widged.gentDB.vo.visibleRows
{
	import com.widged.maoriDictionary.dictionary.vo.RowsCursor;
	
	public class VisibleRows
	{
		
		private var _visibleList:Array;
		private var _cursor:RowsCursor;
		
		public function VisibleRows()
		{
			_cursor = null;
			_visibleList = null;
		}
		
		
		public function get visibleList():Array        { return _visibleList; }
		public function get cursor():RowsCursor        { return _cursor;      }
		
		public function change(list:Array, scrollMax:int):void
		{
			_cursor = new RowsCursor(scrollMax);
			_visibleList = list; 
		}
		
		
	}
}