package com.widged.data.textEncoder.type
{
	import com.adobe.serialization.json.JSON;
	import com.widged.data.textEncoder.ITextEncoder;
	import com.widged.data.textEncoder.TextEncoder;
	
	public class JsonEncoder extends TextEncoder implements ITextEncoder
	{
		
		public function JsonEncoder()
		{
		}
		
		public function encode(list:Array):String
		{
			if(!list) { return null; }
			var value:*;
			var colName:String;
			var o:Object = {};
			
			for (var i:int = 0; i < list.length; i++)
			{
				value = list[i];
				colName = _fields.hasOwnProperty(i) ? _fields[i].name : "column " + i;
				if(!value) 
				{ 
					value = null;
				}
				o[colName] = value;
			}
			return JSON.encode(o);
		}
		
		
	}
}