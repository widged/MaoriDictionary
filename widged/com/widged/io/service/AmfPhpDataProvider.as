package com.widged.io.service
{
	import com.widged.io.IDataProvider;
	
	import flash.events.IEventDispatcher;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	
	public class AmfPhpDataProvider extends RemoteDataProvider implements IDataProvider
	{
		public var gateway : NetConnection;

		public function AmfPhpDataProvider(target:IEventDispatcher=null)
		{
			super("", target);
		}

		public function open(url:String):void
		{
			serverIP = url;
			gateway = new NetConnection();
			gateway.objectEncoding = ObjectEncoding.AMF3;
			if (serverIP) gateway.connect( serverIP );
		}
		
	}
}