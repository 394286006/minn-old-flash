/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.controller
{
	import mvc.model.merchandise.MerchandiseProxy;
	import mvc.model.order.OrderProxy;
	import mvc.model.user.UserProxy;

	public class ControllerService
	{
		private static var merchandiseProxy:MerchandiseProxy;
		private static var orderProxy:OrderProxy;
		private static var userProxy:UserProxy;
		private static var serviceProxy:*;
		
		public function ControllerService()
		{
		}
		
		public static function getInstance(type:String):*{
			switch(type){
				case ControllerCommand.MERCHANDISE_PROXY:
					if(merchandiseProxy==null)
					   merchandiseProxy=new MerchandiseProxy();
					serviceProxy= merchandiseProxy;
					break;
				case ControllerCommand.ORDER_PROXY:
					if(orderProxy==null)
						orderProxy=new OrderProxy();
					serviceProxy= orderProxy;
					break;
				case ControllerCommand.USER_PROXY:
					if(userProxy==null)
						userProxy=new UserProxy();
					serviceProxy= userProxy;
					break;
			}
			return serviceProxy;
		}
		
	}
}