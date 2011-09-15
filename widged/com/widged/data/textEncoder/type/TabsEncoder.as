package com.widged.data.textEncoder.type
{
	import com.adobe.serialization.json.JSON;
	import com.widged.data.textEncoder.ITextEncoder;
	import com.widged.data.textEncoder.TextEncoder;
	
	public class TabsEncoder extends TextEncoder implements ITextEncoder
	{
		
		public function TabsEncoder()
		{
		}
		
		public function encode(list:Array):String
		{
			if(!list) { return null; }
			return list.join("\t");
		}
		
		
	}
}