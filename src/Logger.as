package
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;	
	/**
	 * ...
	 * @author Steve Harris
	 * purpose: Log statistics of the game
	 * methodName varchar(100) - the name of the method from which the log is called
	 * eventName varchar(100) - what started the event
	 * errorState varchar(100) - should be none in most cases
	 * freeText varchar(MAX) - unlimited amount of data, can use ~ delimiters and : for name value
	 * 							name1:value1~name2:value2 to build up information about the current
	 * 							state of the public and private variables etc.
	 * */
	public class Logger extends Class
	{	
		public function Log(methodName:String, eventName:String, errorState:String, freeText:String) : void
		{		
			var aspURL:String = new String;
			//aspURL = "http://ZombieGame.mscoder.com/ZombieLog/Create";
			//aspURL = "http://localhost/MSCoder.Zombie.WebUI/ZombieLog/Create";
			aspURL = "http://d12639668.u1129.c8.ixwebhosting.com/ZombieLog/Create";
			var myXMLURL:URLRequest = new URLRequest(aspURL);
			var variables:URLVariables = new URLVariables();
			variables.MethodName = methodName;
			variables.EventName = eventName;
			variables.ErrorState = errorState;
			variables.LogData = freeText;
			
			myXMLURL.data = variables;
			myXMLURL.method = URLRequestMethod.POST;
			var myLoader:URLLoader = new URLLoader();
			myLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			myLoader.load(myXMLURL);	
		}
		
		public function ErrorLog(methodName:String, eventName:String, errorState:String, freeText:String) : void
		{
			var aspURL:String = new String;
			//aspURL = "http://ZombieGame.mscoder.com/ZombieLog/Create";
			//aspURL = "http://localhost/MSCoder.Zombie.WebUI/ZombieLog/Create";
			aspURL = "http://d12639668.u1129.c8.ixwebhosting.com/ZombieErrorLog/Create";
			var myXMLURL:URLRequest = new URLRequest(aspURL);
			var variables:URLVariables = new URLVariables();
			variables.MethodName = methodName;
			variables.EventName = eventName;
			variables.ErrorState = errorState;
			variables.ErrorData = freeText;
			
			myXMLURL.data = variables;
			myXMLURL.method = URLRequestMethod.POST;
			var myLoader:URLLoader = new URLLoader();
			myLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			myLoader.load(myXMLURL);	
		}
	}
	

}