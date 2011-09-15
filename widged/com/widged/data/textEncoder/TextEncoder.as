package com.widged.data.textEncoder
{
	import com.widged.data.textParser.ParserColumn;

	public class TextEncoder
	{
		protected var _fields:Vector.<ParserColumn>;
		
		public function TextEncoder()
		{
		}
		
		public function initialize(fields:Vector.<ParserColumn>):void
		{
			_fields = fields;
		}

		
	}
}