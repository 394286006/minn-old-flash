/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.merchandise
{
	import minn.util.MinnUtil;
	
	import mvc.model.base.BaseProxy;
	
		
	
	public class MerchandiseProxy extends BaseProxy
	{
		public static const  NAME:String="MERCHANDISE_PROXY";
		private static const SERVICE_NAME:String="front.product.ProductService";
		private static const CTYPEE_SERVICE_NAME:String="ctype.CtypeService";
		private static const PHOTO_SERVICE_NAME:String="photo.PhotoService";
		public function MerchandiseProxy()
		{
		}
		public function add(info:Object,resultHandler:Function):void{
			//		Alert.show('OperatorProxy add');	
			//			Alert.show(operator.opr_name_en);
			send(SERVICE_NAME,"add",resultHandler,info);
			//	        this.sendNotification(
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
		
		public function query(condition:Object,resultHandler:Function):void{
			send(SERVICE_NAME,"queryProduct",resultHandler,condition);
		}
		public function addCtype(info:Object,resultHandler:Function):void{
//			MinnUtil.send(this,CTYPEE_SERVICE_NAME,"add",MerchandiseEvent.CTYPE_MERCHANDISE_ADD_RESULT,info);
		}
		public function delCtype(info:Object,resultHandler:Function):void{
			send(CTYPEE_SERVICE_NAME,"delete",resultHandler,info);
		}
		public function queryCtypeTree(resultHandler:Function):void{
			send(SERVICE_NAME,"queryCtypeTree",resultHandler);
		}
		public function addPhoto(info:Object,resultHandler:Function):void{
			send(PHOTO_SERVICE_NAME,"add",resultHandler,info);
		}
		public function modifyPhoto(info:Object,resultHandler:Function):void{
			send(PHOTO_SERVICE_NAME,"update",resultHandler,info);
		}
		public function delPhoto(info:Object,resultHandler:Function):void{
			send(PHOTO_SERVICE_NAME,"delete",resultHandler,info);
		}
	}
}