package com.widged.data.textParser
{
	public class ParserColumn
	{
		public static const TYPE_UNKNOWN:int  = 0;
		public static const TYPE_STRING:int   = 1;
		public static const TYPE_NUMBER:int   = 2;
		
		
		public var name:String;
		public var dataType:int;
		public var stats:Object;
		
		public function ParserColumn( name:String, dataType:int, stats:Object = null )
		{
			this.name     = name;
			this.dataType = dataType; 
			this.stats    = stats; // for numbers: min, max, qtyMax, decMax, for strings: length
		}
		
		
	}
}