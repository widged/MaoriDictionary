/*
(c) 2010 Marielle Lange - All rights reserved.
*/
package com.widged.io.fileStream.events
{
	import flash.events.Event;
	
	public class LineStreamProgress extends Event
	{
		private var _line:String;
		private var _count:int;
		private var _statusCode:int;
		
		public static const LINE_PROGRESS:String = 'lineProgress';
		public static const FILE_COMPLETE:String = 'fileComplete';
		
		public function LineStreamProgress(type:String, count:int, statusCode:int, line:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_line       = line;
			_count      = count;
			_statusCode = statusCode;
		}
		
		public function get line():String     { return _line;       }
		public function get count():int       { return _count;      }
		public function get statusCode():int  { return _statusCode; }
		
		override public function clone():Event
		{
			return new LineStreamProgress(type, _count, _statusCode, _line, bubbles, cancelable);
		}
	}
}