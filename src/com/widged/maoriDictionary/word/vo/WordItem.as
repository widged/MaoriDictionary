package com.widged.maoriDictionary.word.vo
{
	public class WordItem
	{

		public var uid:String;
		public var displayName:String;
		public var definition:String;
		public var definitionShort:String;
		public var indice:String;
		
		public function WordItem(displayName:String, uid:String, indice:String, definition:String)
		{
			this.uid         = uid;
			this.displayName = displayName;
			this.definition  = definition;
			this.definitionShort = toShort(definition);
			this.indice      = indice;
		}
		
		private function toShort(str:String):String
		{
			var l:int = str.length;
			str = str.substr(0, 90);
			if (str.length < l) 
			{
				// remove the last word that is likely to have been cut in the middle
				var arr:Array = str.split(" ");
				arr.length -= 1;
				str = arr.join(" ") + " ...";
			}
			return str;
		}
		
		private static var maoriTag:RegExp = new RegExp('<m>(.+?)<\/m>', "g");
		public function toHtml(str:String):String
		{
			str = str.replace(maoriTag, "<span class='maori'>$1</span>");
			// add any missing closing tag
			str = str.replace(/<m>(.+)$/, "<span class='maori'>$1</span>");
			return str;
		}
		
		public function toString():String
		{
			return "[WordItem] " + [uid, displayName, definition].join(",");
		}
		
	}
}