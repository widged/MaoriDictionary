package com.widged.maoriDictionary.word.vo
{
	import flash.text.StyleSheet;
	
	import mx.utils.ObjectUtil;

	public class WordStyle
	{
		public function WordStyle()
		{
		}
		
		public static function get css():StyleSheet
		{
			var ss : StyleSheet;
			ss = new StyleSheet();
			ss.setStyle(".maori", {color : "#c07474"}); 
			ss.setStyle(".function", {color : "#ACADAC", 'fontSize': 9}); 
			ss.setStyle("h2", {color : "#333333", 'fontSize': 12});
			return ss;
		}

		public static function get infoCss():StyleSheet
		{
			var ss : StyleSheet;
			ss = new StyleSheet();
			ss.setStyle("a:link", {color : "#435F92", display: "inline"}); 
			ss.setStyle("h2", {color : "#333333", 'fontSize': 12});
			return ss;
		}
	
	}
}