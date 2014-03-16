/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.common
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.controls.ProgressBar;
	import mx.managers.PopUpManager;

	public class Entrypt
	{
		private static var newByte:ByteArray = new ByteArray();
		public function Entrypt()
		{
		}
		
		public static function uncompress(byte:ByteArray,key:String):ByteArray{
			var flag:int = 0;
			newByte.clear();
			for(var i:int = 0; i<byte.length ; i++ ,flag++){	
				if(flag >= key.length){
					flag = 0;
				}
				newByte.writeByte(byte[i] - key.charCodeAt(flag));
			} 				
			return newByte;
		}
	    
		public static function loadswfObject(url:String,dualfunction:Function,_parent:DisplayObject):void{
			//			if(loader==null)
			var pb:ProgressBar=new ProgressBar();
			pb.direction="right";
			pb.mode="manual";
			var urlLoader:URLLoader=new URLLoader();
			urlLoader.dataFormat=URLLoaderDataFormat.BINARY;
			if(!urlLoader.hasEventListener(Event.COMPLETE))
				urlLoader.addEventListener(Event.COMPLETE,function(evt:Event):void{
					PopUpManager.removePopUp(pb);
					dualfunction(evt);
				});
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusEvent);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,function(evt:IOErrorEvent):void{
				PopUpManager.removePopUp(pb);
				ioerrorEvent(evt);
			});
			urlLoader.addEventListener(ProgressEvent.PROGRESS,function(evt:ProgressEvent):void{
			
				progressHandler(evt,pb);
			});
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityError);
			urlLoader.load(new URLRequest(url+"?data="+new Date()));
		
//			Alert.show("load:"+urlLoader.toString());
			PopUpManager.addPopUp(pb,_parent);
			PopUpManager.centerPopUp(pb);
		}
		private static function securityError(evt:SecurityErrorEvent):void{
			Alert.show(evt.type,"SecurityErrorEvent");
		}
		private static function progressHandler(evt:ProgressEvent,pb:ProgressBar):void{
//			URLLoader(evt.target).
		
//			Alert.show("proce");
			pb.minimum=0;
			pb.maximum=Number(evt.bytesTotal);
//			trace("evt.bytesLoaded:"+evt.bytesLoaded+"  Number(evt.bytesTotal):"+evt.bytesTotal);
			pb.setProgress(Number(evt.bytesLoaded),Number(evt.bytesTotal));
		}
		
		private static function httpStatusEvent(evt:HTTPStatusEvent):void{
//			Alert.show(evt.type,"HTTPStatusEvent");
		}
		
		private static function ioerrorEvent(evt:IOErrorEvent):void{
			Alert.show(evt.type,"IOErrorEvent");
		}
		
		
//		private static function pop
	}
}