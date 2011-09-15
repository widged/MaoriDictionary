package com.widged.data.textEncoder.type
{
	import com.widged.data.textEncoder.ITextEncoder;
	import com.widged.data.textEncoder.TextEncoder;
	import com.widged.data.textParser.ParserColumn;
	

	public class SqliteEncoder extends TextEncoder implements ITextEncoder
	{

		private var _name:String;
		private var _insertPrefix:String;
		
		public function SqliteEncoder(name:String)
		{
			_name = name;
		}

		override public function initialize(columns:Vector.<ParserColumn>):void
		{
			super.initialize(columns);
			buildPrefix();
		}
		
		
		private function buildPrefix():void
		{
			// build the prefix only when we have both table name and columns
			if(!_name || !_fields) { return; }
			// loop through columns
			var arr:Array = [];
			for(var i:int = 0; i < _fields.length; i++)
			{
				arr.push("`" + _fields[i].name + "`"); 
			}
			var cols:String = arr && arr.length ? arr.join(", ") : "";
			_insertPrefix = "INSERT INTO `" + _name + "` (" + cols + ")" ;
		}

		
		public function encode(list:Array):String
		{
			if(!list) { return null; }
			var newList:Array = [];
			for (var i:int = 0; i < list.length; i++)
			{
				var value:* = list[i];
				if(!value) 
				{ 
					value = "NULL";
				}
				else if(isNaN(value))
				{
					value = '"' + value + '"';			
				}
				newList[i] = value
			}
			
			var str:String = _insertPrefix + " VALUES (" + newList.join(", ") + ");";
			return str;
		}
		
		
	}
}