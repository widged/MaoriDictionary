package com.widged.data.textEncoder
{
	import com.widged.data.textParser.ParserColumn;

	public interface ITextEncoder
	{
		function initialize(columns:Vector.<ParserColumn>):void;
		function encode(cols:Array):String;
	}
}