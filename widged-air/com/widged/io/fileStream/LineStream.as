package com.widged.io.fileStream
{
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import com.widged.io.fileStream.events.LineStreamProgress;
	
	public class LineStream extends FileStream
	{
		private const bufferSize:uint  = 256;
		private const linesAhead:int   = 800;

		// helpers
		private var buffer:ByteArray = new ByteArray();
		// class data
		private var _lastLine:String = "";
		private var _lineList:Array = [];
		private var _lineCount:int = 0;

		private var _status:int;
		public static const STATUS_STARTING:int  = 0;
		public static const STATUS_RUNNING:int   = 1;
		public static const STATUS_COMPLETE:int  = 2;
		public static const STATUS_STOPPED:int   = 3;

		private var timer:Timer; 
		
		public function LineStream()
		{
			this.readAhead = bufferSize;
			super();
		}
		
		override public function openAsync(file:File, fileMode:String):void
		{
			_status = STATUS_STARTING
			super.addEventListener(Event.COMPLETE, onComplete);
			timer= new Timer(10);
			timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			timer.start();
			super.openAsync(file, fileMode);
			super.position = 0;
		}
		
		public function get lineCount():int { return _lineCount; }
		
		private function start():void
		{
			_lineCount = 0;
			_status = STATUS_RUNNING; 
		}

		public function stop():void
		{
			_status = STATUS_STOPPED;
			close();
		}
		
		private function onTimerTick(event:TimerEvent):void
		{
			if(_status == STATUS_STARTING) { 
				start(); 
				return;
			}
			if(_status == STATUS_COMPLETE || _status == STATUS_STOPPED) { 
				timer.removeEventListener(TimerEvent.TIMER, onTimerTick);
				timer.stop();
				flushLines();
				_status = STATUS_COMPLETE;
				dispatchEvent(new LineStreamProgress(LineStreamProgress.FILE_COMPLETE, _lineCount, _status));
				return; 
			}
			var c:int = 0;
			// a bit slow if not doing this.
			// hanging and blocking the interface if not using c < 800;
			while(_status == STATUS_RUNNING && bytesAvailable && c < linesAhead)
			{
				c++;
				fillBuffer();
				flushLines();
			}
		}
		
		private function flushLines():void
		{
			var line:String
			while(_lineList.length)
			{
				_lineCount++;
				line = _lineList.shift();
				dispatchEvent(new LineStreamProgress(LineStreamProgress.LINE_PROGRESS, _lineCount, _status, line));
			}
		}
		
		private function fillBuffer():void
		{
			while(bytesAvailable && _lineList.length < 1 && _status == STATUS_RUNNING)
			{
				var bytesToRead:Number = Math.min(this.bytesAvailable, bufferSize);
				// splits on windows line endings, replacing them with unix line endings
				_lineList = String(_lastLine + readMultiByte(bytesToRead, "utf-8")).split('\r\n').join('\n').split("\n");
				_lastLine = _lineList.pop();
			}
		}
		
		private function onComplete(event:Event):void
		{
			if(_status == STATUS_STARTING)
			{
				start();
			}
			_status = STATUS_COMPLETE;
		}
	}
}