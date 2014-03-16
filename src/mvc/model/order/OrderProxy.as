/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.order
{
	import minn.util.MinnUtil;
	
	import mvc.model.base.BaseProxy;
	
	public class OrderProxy extends BaseProxy
	{
		public static const  NAME:String="ORDER_PROXY";
		private static const SERVICE_NAME:String="front.order.OrderService";
		private static const PAY_SERVICE_NAME:String="alipay.alipayService";
		public function OrderProxy()
		{
			super();
		}
		
		public function add(info:Object,resultHandler:Function,faultFunction:Function=null):void{
			//		Alert.show('OperatorProxy add');	
			//			Alert.show(operator.opr_name_en);
			send(SERVICE_NAME,"add",resultHandler,info);
			//	        this.sendNotification(
		}
		public function modify(info:Object,resultHandler:Function,faultFunction:Function):void{
			
			//			this.sendNotification(OperatorEvent.OPERATOR_MODIFY_RESULT,operator);
			send(SERVICE_NAME,"update",resultHandler,info,faultFunction);
		}
		
		public function del(info:Object,resultHandler:Function):void{
			//					Alert.show('OperatorProxy del');	
			//			Alert.show(operator.opr_name_en);
			send(SERVICE_NAME,"delete",resultHandler,info);
			//			this.sendNotification(OperatorEvent.OPERATOR_DEL_RESULT,"删除成功");
		}
		
		public function query(condition:Object,resultHandler:Function):void{
			send(SERVICE_NAME,"query",resultHandler,condition);
		}
//		public function delOrder(condition:Object,resultHandler:Function):void{
//			send(SERVICE_NAME,"delOrder",resultHandler,condition);
//		}
		public function getAlipayParamter(condition:Object,resultHandler:Function):void{
			send(PAY_SERVICE_NAME,"getAlipayParamter",resultHandler,condition);
		}
	}
}