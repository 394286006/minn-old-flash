/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.util
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import minn.message.Message;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.controls.ProgressBar;
	import mx.controls.ProgressBarMode;
	import mx.core.FlexGlobals;
	import mx.formatters.DateFormatter;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.managers.SystemManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.skins.halo.BusyCursor;
	import mx.styles.StyleManager;
	import mx.utils.ArrayUtil;
	
	public final class MinnUtil
	{
		[Bindable] 
		[Embed("assets/img/page/wait.gif")] 
		private static var c:Class; 
		
		private static var ro:RemoteObject=null;
		private static var param:String=null;
		
		private static var img:Image=null;
		
		private static var loader:URLLoader=null ;
		public function MinnUtil()
		{
			img=new Image();
			img.source=c;
		}
		
		/**传入参数obj为数据库返回的对象，map为需要装配成的类 
		 * 返回装配数据完成的类
		 */
		public static function propertyMap(obj:Object,map:*,isj:Boolean=false):*{
			if(isj)
			 obj=JSON.decode(obj.toString());
			if((obj is XML)||obj is XMLList){
				for each(var kv:XML in obj.attributes()){
					var prp:String=kv.name();
					map[prp]=kv;
				}
			}else{
				for( prp in obj){
					if(map.hasOwnProperty(prp))
						map[prp]=obj[prp];
				}
			}
			return map;
		}
		
		public static function send(sname:String,method:String,resultFunction:Function,obj:*=null):void{
//			if(ro==null)
			 ro=new RemoteObject();
			ro.destination="amfphp";
			ro.source=sname;
			var l:int=CursorManager.getInstance().setCursor(c);
			CursorManager.getInstance().setBusyCursor()
			ro.addEventListener(FaultEvent.FAULT,function(evt:FaultEvent):void{
				CursorManager.getInstance().removeCursor(l);
				CursorManager.getInstance().removeBusyCursor();
				Alert.show("请求连接失败："+evt.message);
				ro.disconnect();
			});	
			ro.removeEventListener(ResultEvent.RESULT,function(evt:ResultEvent):void{});
			ro.addEventListener(ResultEvent.RESULT,function(evt:ResultEvent):void{
				CursorManager.getInstance().removeCursor(l);
				CursorManager.getInstance().removeBusyCursor();
//				Alert.show(evt.result.toString());
//				trace("json decoder:"+JSON.decode(evt.result.toString()));
				var m:Message=getMessage(evt.result);
//				Alert.show(m.messageBody);
//				if(m.messageSucess!=3)
//					m.otherInfo=obj;
				resultFunction(m);
//				pro.sendNotification(eventType,m);
				ro.disconnect();
				ro.logout();
			});
			if(obj!=null){
				trace("MinnUtil.send 传送的字符串参数："+JSON.encode(obj));
				param=JSON.encode(obj);
//				Alert.show(param);
				ro.getOperation(method).send(param);
			}else{
				ro.getOperation(method).send();
			}
//						Alert.show(JSON.encode(obj.item));
		
			
			
		}
		
		public static function deleteFile(upurl:String,param:URLVariables,filearr:Array,dualfunction:Function):void{
//			if(loader==null)
				loader=new URLLoader();
			var request:URLRequest =  new URLRequest(upurl+"?date="+new Date());
			request.method = "post";
			param.files=encodeURIComponent(JSON.encode(filearr));
//			Alert.show(JSON.encode(filearr));
			request.data=param;
			if(!loader.hasEventListener(Event.COMPLETE))
//				loader.removeEventListener(Event.COMPLETE,dualfunction);
			loader.addEventListener(Event.COMPLETE,dualfunction);
			loader.load(request);
		}
		
		public static function getMessage(message:Object):Message{
			var arr:Array=ArrayUtil.toArray(message) ;
			var m:Message=null;
			if(arr.length==3){
				m=new Message(arr[0],arr[1],arr[2]);
			}else{
				m=new Message(arr[0],arr[1],arr[2],arr[3]);
			}
			return m;
		}
		
		public static function reverse(os:ArrayCollection,arr:Array=null):void{
			arr=os.source;
			arr.reverse();
			os.source=arr;
		}
		
		public static function copyProperty(ac:ArrayCollection,arr:Array):void{
			for(var i:int=0;i<arr.length;i++){
			      var op:*=ac.getItemAt(i);
				var o:Object=arr[i];
				for(var prp:String in o)
				{
					if(op.hasOwnProperty(prp))
						op[prp]=o[prp];
				}
				
			}
		}
		
		public static function getCurentDateAndTime(dateformat:String='YYYY-MM-DD HH:NN:SS'):String{
			var f:DateFormatter=new DateFormatter();
			 f.formatString=dateformat;
			var d:Date=new Date();
			return f.format(d);
		}
		
		
		/*
		
		*@param labelName 定义的xml变量格式 eg:var userInfo:XML=<userInfo/>;
		
		*@param labelArr xml标记数组 eg: var arr:Array=["operator","userName","password"];
		
		*@param dataArr xml值数组  eg:var item:Array=["login",user_id.text,password_id.text];
		
		*/
		public static function arr2xml(labelName:XML,labelArr:Array,dataArr:Array):XML
		{
			
			for(var i:int=0;i<labelArr.length;i++)
			{
				if(i<dataArr.length)
				{
					labelName.appendChild("<"+labelArr[i]+">"+dataArr[i]+"</"+labelArr[i]+">");
				}else
				{
					labelName.appendChild("<"+labelArr[i]+">0</"+labelArr[i]+">");
				}
			}
			return labelName;
		}  
		

	}
}