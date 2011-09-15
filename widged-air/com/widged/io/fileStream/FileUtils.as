package com.widged.io.file_air
{
	import flash.filesystem.File;

	public class FileUtils_air
	{
		private static const FOLDER_MARKER:String = "::";
		private static const FOLDER_DOCUMENTS:String = "documents";
		
		public function FileUtils_air()
		{
		}
		
		public static function getFile(url:String):void
		{
			var folder:String = FOLDER_DOCUMENTS;
			if(url.indexOf(FOLDER_MARKER) != -1)
			{
				var arr:Array = url.split(FOLDER_MARKER);
				folder = arr[0];
				url    = arr[1];
			}
			
			var file:File;
			switch(folder)
			{
				case FOLDER_DOCUMENTS:
					file  = File.documentsDirectory.resolvePath(url);
					break;
			}
			
		}
	}
}