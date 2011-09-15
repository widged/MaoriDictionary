package com.widged.maoriDictionary.dictionary.parser
{
	import com.widged.data.textParser.ILineParser;
	import com.widged.data.textParser.events.LineParserEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class WilliamDictParser extends EventDispatcher implements ILineParser
	{

		// class data
		private const COLUMN_SEP:String = "\t";
		private var _multiLine:String;
		private var _rowCount:int;

		public function WilliamDictParser(target:IEventDispatcher=null)
		{
			super(target);
			initialize();
		}
		
		public function initialize():void
		{
			_rowCount               = 0;
			_multiLine              = "";
		}
		
		public function get rowCount():int
		{
			return _rowCount;
		}
		
		public function parseLine(line:String):void
		{
			line = line.replace(/^\s*(.+?)\s*$/, "$1")
			var sectionStart:RegExp = /<div xml:id="(.+)" type="section">/;
			var sectionEnd:RegExp = /<\/div>/;

			// if we haven't reached the mark of a section end, we probably need to continue reading the line
			if(line.search(sectionEnd) == -1) 
			{
				if(line.search(sectionStart) != -1)
				{
					_multiLine = line.replace(sectionStart, "$1") + COLUMN_SEP;
					return;
				}
				else
				{
					_multiLine += line + " ";
					return;
				}
			}
			_rowCount++;			
			
			var unlikelyString:String = "#@µ#@µ#@µ#@µ";
			_multiLine = _multiLine.replace(/^\s/, "");
			_multiLine = _multiLine.replace(/\s$/, "");
			_multiLine = _multiLine.replace(/<p rend="hang">(.*?)<\/p>/g, "<p>$1</p>");
			_multiLine = _multiLine.replace(/<foreign rend="b" xml:lang="mi">(.+?)<\/foreign>/g, "<m>$1</m>");
			_multiLine = _multiLine.replace(/<foreign xml:lang="mi">(.+?)<\/foreign>/g, "<m>$1</m>");
			_multiLine = _multiLine.replace(/<name type="organism" subtype="matched">(.+?)<\/name>/g, "<n>$1</n>");			
			_multiLine = _multiLine.replace(/<hi rend="i">(.*?)<\/hi>/g, "<i>$1</i>");
			_multiLine = _multiLine.replace(/<hi rend="b">(.*?)<\/hi>/g, "<b>$1</b>");
			_multiLine = _multiLine.replace(/(.+?)\t<p><m>(.*?)<\/m>/, "$1" + unlikelyString + unlikelyString + "$2" + unlikelyString +  "<p>" ); // 
			_multiLine = _multiLine.replace(/\"/g, "'");
			
			var fields:Array  = _multiLine.split(unlikelyString);
			if(fields.length != 4) { trace("[ParsingError]", fields.join("+++"))}
			var arr:Array = (fields[0] as String).split("-");
			var indice:String = (arr.length > 1) ? arr.pop() : "";
			var word:String = arr.join("-");
			/* 
			we need to differentiate between a dash before an indice and a dash in a compound word
				<div xml:id="" type="section">
			needs to become {wid: "Kaiwhiri", incide: "i"} but
				<div xml:id="Kai-whiore" type="section">
			needs to become {wid: "Kai-whiore", incide: ""} 
			*/
			if(!indice)
			{
				fields[0] = word;    // wid
				fields[1] =  "";     // indice
			}
			else if (indice.search(/^[ivx]+$/) == -1)
			{
				fields[0] = word + "-" + indice ;    // wid
				fields[1] =  "";                    // indice
			}
			else
			{
				fields[0] = word;    // wid
				fields[1] =  indice;  // indice
			}
			if(!fields[3]) { trace("[WilliamDict][ERROR]", fields); return };
			fields[3] = (fields[3] as String).replace(/^<p>\s*(\([xiv]+\))?[,\. ]\s*/, "<p>");  // definition
			fields[4] = (fields[0] as String).indexOf('Ng') == 0 ? 'Ng' : (fields[0] as String).substr(0, 1).toUpperCase(); 
			dispatchEvent(new LineParserEvent(LineParserEvent.ROW_ADDED, {fields : fields})); 
				
		}
		
		
	}
}