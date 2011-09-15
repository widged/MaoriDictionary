package com.widged.io.nativeProcess
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.filesystem.File;

	public class TextmateUtil
	{
		private static var process:NativeProcess;

		public function TextmateUtil()
		{
		}
		
		public static function openFileInTextmate(file:File):void
		{
			if(!NativeProcess.isSupported) { return; }
			var mate:File = new File("/Applications/TextMate.app/Contents/Resources/mate")
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			nativeProcessStartupInfo.executable = mate;
			
			var processArgs:Vector.<String> = new Vector.<String>();
			processArgs[0] = file.nativePath;
			nativeProcessStartupInfo.arguments = processArgs;
			
			process = new NativeProcess();
			process.start(nativeProcessStartupInfo);
			
		}
		
	}
}