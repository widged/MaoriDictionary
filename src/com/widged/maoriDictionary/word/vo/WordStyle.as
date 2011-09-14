package com.widged.maoriDictionary.word.vo
{
	import flash.text.StyleSheet;

	public class WordStyle
	{
		public function WordStyle()
		{
		}
		
		public static function get css():StyleSheet
		{
			var ss : StyleSheet;
			ss = new StyleSheet();
			ss.setStyle(".maori", {color : "#498900"}); // #6F9844
			return ss;
		}
	}
}