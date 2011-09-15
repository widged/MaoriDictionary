package com.widged.io.file
{
	import flash.events.IEventDispatcher;
	
	public interface IFileLoader extends IEventDispatcher
	{
		function load(url:String, resultCallback:Function = null, errorCallback:Function = null):void;
		
	}
}