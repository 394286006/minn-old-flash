/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.user
{
	import com.adobe.crypto.MD5;
	import com.adobe.crypto.MD5Stream;
	import com.adobe.serialization.json.JSON;
	
	import flash.utils.ByteArray;
	
	import flashx.textLayout.utils.CharacterUtil;
	
	import minn.util.MinnUtil;
	
	import mvc.model.base.BaseProxy;
	import mvc.model.user.vo.User;
	import mvc.view.front.user.event.UserEvent;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.utils.Base64Decoder;
	

	public class UserProxy extends BaseProxy
	{
		public static const  NAME:String="USER_PROXY";
		private static const SERVICE_NAME:String="user.UserService";
		public function UserProxy(){
		}
		
		public function login(info:Object,resultHandler:Function):void{
//			Alert.show('login:'+info.item.userName_en);
			send(SERVICE_NAME,"login",resultHandler,info);
//			this.sendNotification(UserEvent.USER_LOGIN_RESULT,"登陆成功");
		}
		
		public function add(info:Object,resultHandler:Function):void{
//					Alert.show('user add');	
			//			Alert.show(operator.opr_name_en);
			send(SERVICE_NAME,"add",resultHandler,info);
//				        this.sendNotification(UserEvent.USER_REGISTERR_ESULT,"添加成功");
		}
		public function userCheck(info:Object,resultHandler:Function):void{
			//					Alert.show('user add');	
			//			Alert.show(operator.opr_name_en);
			send(SERVICE_NAME,"userCheck",resultHandler,info);
			//				        this.sendNotification(UserEvent.USER_REGISTERR_ESULT,"添加成功");
		}
		
		public function modify(info:Object,resultHandler:Function):void{
			
			//			this.sendNotification(OperatorEvent.OPERATOR_MODIFY_RESULT,operator);
			send(SERVICE_NAME,"update",resultHandler,info);
		}
		
		public function del(info:Object,resultHandler:Function):void{
			//					Alert.show('OperatorProxy del');	
			//			Alert.show(operator.opr_name_en);
			send(SERVICE_NAME,"delete",resultHandler,info);
			//			this.sendNotification(OperatorEvent.OPERATOR_DEL_RESULT,"删除成功");
		}
		
		public function query(info:Object,resultHandler:Function):void{
			send(SERVICE_NAME,"query",resultHandler,info);
		}
	}
}