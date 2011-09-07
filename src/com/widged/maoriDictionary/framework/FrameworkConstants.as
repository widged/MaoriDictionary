package com.widged.maoriDictionary.framework
{
	import flash.text.StyleSheet;

	public class FrameworkConstants
	{
		public function FrameworkConstants()
		{
		}
		
		public static function get css():StyleSheet
		{
			var ss : StyleSheet;
			ss = new StyleSheet();
			ss.setStyle(".maori", {color : "#6F9844"});
			return ss;
		}
	}
}