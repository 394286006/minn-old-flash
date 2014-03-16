/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.order.vo
{
	[RemoteClass(alias="order.OrderAddress")]   
	[Bindable]   
	public class  OrderAddress
	{
		public var id:String='';
		public var address:String='';
		public var phone:String='';
		public var email:String='';
		public var code:String='';
		public var creator:String='';
		public var createDate:String='';
		public var receiveName:String='';
		
		public function OrderAddress()
		{
		}
	}
}