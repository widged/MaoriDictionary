package com.widged.maoriDictionary.dictionary.parser
{
	import com.widged.data.textParser.ILineParser;
	import com.widged.data.textParser.events.LineParserEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class WilliamXmlParser extends EventDispatcher implements ILineParser
	{
		
		// class data
		private const COLUMN_SEP:String = "\t";
		private var _multiLine:String;
		private var _rowCount:int;
		
		public function WilliamXmlParser(target:IEventDispatcher=null)
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
			var unlikelyString:String = "#@µ#@µ#@µ#@µ";
			var sectionStart:RegExp = /<item xml:id="(.+)">/;
			var sectionEnd:RegExp = /<\/item>/;
			
			line = line.replace(/^\s*(.+?)\s*$/, "$1")
			// if we haven't reached the mark of a section end, we probably need to continue reading the line
			if(line.search(sectionEnd) == -1) 
			{
				if(line.search(sectionStart) != -1)
				{
					_multiLine = line.replace(sectionStart, "$1" + unlikelyString + unlikelyString);  
					return;
				}
				else
				{
					_multiLine += line + " ";
					return;
				}
			}
			_rowCount++;			
			
			_multiLine = _multiLine.replace(/^[\n\r]+/, " ");
			_multiLine = _multiLine.replace(/^\s/, "");
			_multiLine = _multiLine.replace(/\s$/, "");

			_multiLine = _multiLine.replace(/<word>(.+?)<\/word>/, "$1" + unlikelyString);
			_multiLine = _multiLine.replace(/<indice>(.+?)<\/indice>/, "");

			_multiLine = _multiLine.replace(/\s*<\/?(lemmas|for)>\s*/g, "")
							
			_multiLine = _multiLine.replace(/<lemma>\s*/g, "");
			_multiLine = _multiLine.replace(/\s*<\/lemma>/g, "<br/>");
			
			_multiLine = _multiLine.replace(/<use>\s*/g, "");
			_multiLine = _multiLine.replace(/\s*<use id="(1)">\s*/g, "<b>$1.</b>&nbsp;");
			_multiLine = _multiLine.replace(/\s*<use id="(\d+)">\s*/g, "&nbsp;&nbsp;&nbsp;<b>$1.</b>&nbsp;");
			_multiLine = _multiLine.replace(/<\/use>/g, "");
			_multiLine = _multiLine.replace(/<in>(.+?)<\/in>/g, "<br/><h2>$1</h2>");
						
			_multiLine = _multiLine.replace(/\s*<(as|where|usage)>\s*/g, "<f>");
			_multiLine = _multiLine.replace(/\s*<\/(as|where|usage)>\s*/g, "</f> ");
			
			_multiLine = _multiLine.replace(/\s*<note>(.+?)<\/note>\s*/g, " Note: $1");
			_multiLine = _multiLine.replace(/\s*<ref>(.+?)<\/ref>\s*/g, " ($1)");
			_multiLine = _multiLine.replace(/\s*<variation>(.+?)<\/variation>\s*/g, " ($1)");
			_multiLine = _multiLine.replace(/\s*<sameas>(.+?)<\/sameas>\s*/g, " = $1");
			_multiLine = _multiLine.replace(/\s*<see>(.+?)<\/see>\s*/g, " see $1");
			_multiLine = _multiLine.replace(/\s*<linnaeus>(.+?)<\/linnaeus>\s*/g, " <i>$1</i>");

			_multiLine = _multiLine.replace(/<eg>(.+?)<\/eg>/g, "<e>$1</e>");
			_multiLine = _multiLine.replace(/<ex>(.+?)<\/ex>/g, "<e>$1</e>");
			_multiLine = _multiLine.replace(/\"/g, "'");
			
			var fields:Array  = _multiLine.split(unlikelyString);
			
			if(fields.length != 4) { trace("[ParsingError]", fields.join("+++"))}
			var arr:Array = (fields[0] as String).split("-");
			var indice:String = (arr.length > 1) ? arr.pop() : "";
			var word:String = arr.join("-");
			/* 
			we need to differentiate between a dash before an indice and a dash in a compound word
			<item xml:id="">
			needs to become {wid: "Kaiwhiri", incide: "i"} but
			<item xml:id="Kai-whiore">
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
			// if(!fields[3]) { trace("[WilliamDict][ERROR]", fields); return };
			// fields[3] = (fields[3] as String).replace(/^<p>\s*(\([xiv]+\))?[,\. ]\s*/, "<p>");  // definition
			fields[4] = (fields[0] as String).indexOf('Ng') == 0 ? 'Ng' : (fields[0] as String).substr(0, 1).toUpperCase(); 
			dispatchEvent(new LineParserEvent(LineParserEvent.ROW_ADDED, {fields : fields})); 
			
		}
		
		
	}
}