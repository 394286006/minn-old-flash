/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.base
{
	import com.adobe.serialization.json.JSON;
	
	import minn.message.Message;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.utils.ArrayUtil;

	public class BaseProxy
	{
		[Bindable] 
		[Embed("assets/img/page/wait.gif")] 
		private static var c:Class; 
		
		private  var ro:RemoteObject=null;
		private  var param:String=null;
		private var objarr:ArrayCollection=new ArrayCollection();
		private  var img:Image=null;
		private var methodflag:String=null;
		public function BaseProxy()
		{
			img=new Image();
			img.source=c;
			
		}
		
		public  function send(sname:String,method:String,resultFunction:Function,obj:*=null,faultResultandler:Function=null):void{
//			if((obj!=null)&&obj.hasOwnProperty('sameMethodType'))
//				methodflag=method+obj.sameMethodType;
//			else
//				methodflag=method;
//			for(var i:int=0;i<objarr.length;i++){
//				if(objarr.getItemAt(i).method==methodflag){
//					ro=objarr.getItemAt(i).ro as RemoteObject;
//					break;
//				}
//			}
			
//			if(ro==null){
				ro=new RemoteObject();
				ro.destination="amfphp";
				ro.source=sname;
				var l:int=CursorManager.getInstance().setCursor(c);
				CursorManager.getInstance().setBusyCursor()
//				if(faultResultandler==null){
				ro.addEventListener(FaultEvent.FAULT,function(evt:FaultEvent):void{
					CursorManager.getInstance().removeCursor(l);
					CursorManager.getInstance().removeBusyCursor();
					Alert.show("请求连接失败："+evt.type,"提示");
					if(faultResultandler!=null)
						faultResultandler(evt);
					ro.disconnect();
				
				});	
//				}else{
//					ro.addEventListener(FaultEvent.FAULT,faultResultandler);
//				}
//				ro.removeEventListener(ResultEvent.RESULT,function(evt:ResultEvent):void{});
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
//					ro.disconnect();
//					ro.logout();
//					ro=null;
				});
				if(obj!=null){
					trace("MinnUtil.send 传送的字符串参数："+JSON.encode(obj));
					param=JSON.encode(obj);
//									Alert.show(param);
					
					ro.getOperation(method).send(param);
				}else{
					ro.getOperation(method).send();
				}
			
		}
		
		private  function getMessage(message:Object):Message{
			var arr:Array=ArrayUtil.toArray(message) ;
			var m:Message=null;
			if(arr.length==3){
				m=new Message(arr[0],arr[1],arr[2]);
			}else{
				m=new Message(arr[0],arr[1],arr[2],arr[3]);
			}
			return m;
		}
	}
}