package com.widged.maoriDictionary.dictionary.parser
{
	import com.widged.data.textEncoder.ITextEncoder;
	import com.widged.data.textEncoder.type.JsonEncoder;
	import com.widged.data.textEncoder.type.SqliteEncoder;
	import com.widged.data.textEncoder.type.TabsEncoder;
	import com.widged.data.textParser.ILineParser;
	import com.widged.data.textParser.ParserColumn;
	import com.widged.data.textParser.events.LineParserEvent;
	import com.widged.io.events.ProviderStatusEvent;
	import com.widged.io.fileStream.LineStream;
	import com.widged.io.fileStream.events.LineStreamProgress;
	import com.widged.maoriDictionary.dictionary.provider.DictionaryEncoder_sqlite;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import spark.components.List;

	public class ParserController
	{

		public function ParserController()
		{
		}
		
		public static const PROGRESS_STEP:int = 5000;
		public static const STOP_STEP:int = Number.POSITIVE_INFINITY;
		
		private var _exportAsText:Boolean    = false;
		private var _exportAsFile:Boolean    = false;
		private var _exportAsDatabase:Boolean = true;
		
		private var _dbReady:Boolean;
		private var _fileReady:Boolean;
		
		private var _exportFormat:int = SQLITE;
		private static const SQLITE:int  = 1;
		private static const JSON:int    = 2;
		private static const TABS:int    = 3;
		
		// helpers		
		private var parser:ILineParser;
		private var textEncoder:ITextEncoder;
		private var dbEncoder:ITextEncoder;
		
		// files
		private var _inputFile:File;
		private var _outputFile:File;
		private var _inputStream:LineStream;
		private var _writeStream:FileStream;
		private var _dbStream:DictionaryEncoder_sqlite;
		

		
		
		private var _isRunning:Boolean = false;
		
		public function processFile(file:File):void
		{
			_inputFile = file;
			_isRunning = false;
			_dbReady   = false;
			_fileReady = false;
			initializeParser();
			initializePackager();
			if(_exportAsFile     && !_exportAsFile)  { initializeOutputFile(file); }
			if(_exportAsDatabase && !_dbReady)    { initializeDatabase();  }
			commitReady();
			
		}
		
		private function commitReady():void
		{
			if(_exportAsDatabase && !_dbReady)      { return; }
			if(_exportAsFile     && !_exportAsFile) { return; }
			if(_isRunning) { return; }
			_isRunning = true;
			
			readInputFile(_inputFile);
		}
		
		

		private function writeFields(list:Array):void
		{
			if(!textEncoder) { return; }
			var text:String = textEncoder.encode(list);
			if(_exportAsText)     { trace(text); } 
			if(_exportAsFile)     { writeToFile(text) } 
			if(_exportAsDatabase) { writeToDatabase(list); } 
		}
		
		private function cleanUp():void
		{
			if(_exportAsDatabase) {
				// _dbStream.close()
				// copyDatabase(); 
			}
			if(_exportAsFile) {
				_writeStream.close()
			}
		}
		
		// ###################
		// ###  InputStream
		// ####################
		public function stop():void
		{
			_inputStream.stop();
			_inputStream.close();
			trace(final)
			cleanUp();
		}		
		private function readInputFile(file:File):void
		{
			_inputStream ||= new LineStream();
			// _inputStream.addEventListener("started", onStarted);
			_inputStream.addEventListener(LineStreamProgress.LINE_PROGRESS, onLineProgress);
			_inputStream.addEventListener(LineStreamProgress.FILE_COMPLETE, onComplete);
			_inputStream.openAsync(file, FileMode.READ);
			
			parser.addEventListener(LineParserEvent.ROW_ADDED, onAddRow);
			
			function onAddRow(event:LineParserEvent):void
			{
				var fields:Array = event.data.fields as Array;
				writeFields(fields);
			}

				
			
			function onLineProgress(event:LineStreamProgress):void
			{
				parser.parseLine(event.line);
				if(_inputStream.lineCount % PROGRESS_STEP == 0) {
					trace(progress)
				}
				if(_inputStream.lineCount == STOP_STEP ) {
					stop();
				}
			}
			
			function onComplete(event:LineStreamProgress):void 
			{
				_inputStream.removeEventListener(LineStreamProgress.LINE_PROGRESS, onLineProgress);
				_inputStream.removeEventListener(LineStreamProgress.FILE_COMPLETE, onComplete);
				parser.removeEventListener(LineParserEvent.ROW_ADDED, onAddRow);
				stop();
			}
			
					
		}					
		// ###################
		// ###  Parser
		// ####################
		
		private function initializeParser():void
		{
			// parser ||= new WilliamDictParser();
			parser ||= new WilliamXmlParser();
			parser.initialize();

		}
		
		// ###################
		// ###  Packager
		// ####################
		private function initializePackager():void
		{
			
			var colV:Vector.<ParserColumn> = new Vector.<ParserColumn>();
			colV.push(new ParserColumn("wid", ParserColumn.TYPE_NUMBER));
			colV.push(new ParserColumn("indice", ParserColumn.TYPE_STRING));
			colV.push(new ParserColumn("word", ParserColumn.TYPE_STRING));
			colV.push(new ParserColumn("definition", ParserColumn.TYPE_STRING));
			colV.push(new ParserColumn("letter", ParserColumn.TYPE_STRING));

			dbEncoder ||= new SqliteEncoder("dictionary");
			dbEncoder.initialize(colV);
			
			switch(_exportFormat)
			{
				case TABS:
					textEncoder ||= new TabsEncoder();
					break;
				case JSON:
					textEncoder ||= new JsonEncoder();
					break;
				case SQLITE:
					textEncoder = dbEncoder;
					break;
			}
			if(textEncoder) { textEncoder.initialize(colV); }
		}
		
		// ###################
		// ### File Output
		// ####################
		
		private function initializeOutputFile(input:File):void
		{
			var folder:File = new File(input.parent.nativePath);
			var arr:Array = input.name.split('.');
			arr.length = arr.length - 1;
			var baseName:String = arr.join(".");
			switch(_exportFormat)
			{
				case JSON:
					_outputFile = folder.resolvePath(baseName + "-inserts" + ".json");
					break;
				case SQLITE:
					_outputFile =  folder.resolvePath(baseName + "-inserts" + ".sql")
					break;
			}
			if (_outputFile.exists) _outputFile.deleteFile();
			_writeStream ||= new FileStream();
			_writeStream.openAsync(_outputFile, FileMode.WRITE);
			_fileReady = true;
			commitReady();
		}
		
		private function writeToFile(text:String):void
		{
			_writeStream.writeUTFBytes(text + "\n");
		}
		
		// ###################
		// ###  Database Output
		// ####################
		
		private function initializeDatabase():void
		{
			var dbFile:File = File.applicationStorageDirectory.resolvePath("maori_dictionary.db");
			if ( !dbFile.exists )
			{
				var isSuccess:Boolean = createSampleDatabase(dbFile);
				if ( !isSuccess )
				{
					trace("[ParserController] The database couldn't be initiliazed");
					return;
				}
			}		
			trace(dbFile.nativePath, dbFile.url)
			
			_dbStream ||= new DictionaryEncoder_sqlite();
			_dbStream.addEventListener(ProviderStatusEvent.READY, onReady);
			_dbStream.init(dbFile);

			function onReady(event:ProviderStatusEvent):void
			{
				_dbReady = true;
				_dbStream.emptyTable();
				commitReady();
			}
			
		}
		private function writeToDatabase(fields:Array):void
		{
			var query:String = dbEncoder.encode(fields);
			_dbStream.runQuery(query);
		}
		
		private function createSampleDatabase(targetFile:File):Boolean 
		{
			var isSuccess:Boolean = true;

			var sampleFile:File = File.applicationDirectory.resolvePath("etc/db/maori_dictionary_empty.db");
			if ( !sampleFile.exists )
			{
				isSuccess = false;
			}
			else
			{
				sampleFile.copyTo(targetFile);			
			}
			return isSuccess;
		}

		

		// ###################
		// ### Utils
		// ####################
		
		private function get progress():String
		{
			var msg:String = "progress - " + _inputStream.lineCount + " lines turned into " + parser.rowCount + " rows ";
			if(_exportAsFile) { msg += "File saved at '" + _outputFile.nativePath + "'"; }
			return  msg;
		}		

		private function get final():String
		{
			
			var msg:String = "completed - " + _inputStream.lineCount + " lines turned into " + parser.rowCount + " rows ";
			if(_exportAsFile) { msg += "File saved at '" + _outputFile.nativePath + "'"; }
			return  msg;
		}		
		
	}
}