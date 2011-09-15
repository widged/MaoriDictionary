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
			ss.setStyle(".maori", {color : "#c07474"}); // greens: #6F9844, #498900
			ss.setStyle(".function", {color : "#ACADAC", 'fontSize': 9}); // greens: #6F9844, #498900
			ss.setStyle("h2", {color : "#333333", 'fontSize': 12}); // greens: #6F9844, #498900
			return ss;
		}
	}
}