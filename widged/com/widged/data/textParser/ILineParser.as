package com.widged.data.textParser
{
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	public interface ILineParser extends IEventDispatcher
	{
		function initialize():void;
		function parseLine(line:String):void;
		function get rowCount():int;
	}
}