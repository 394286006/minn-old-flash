
/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.order.vo
{
	[RemoteClass(alias="order.Order")]   
	[Bindable]   
	public class Order
	{
		public var _sid:String='';
		public var id:String='';
		public var pw_id:String='';
		public var creator:String='';
		public var createDate:String='';
		public var getway:int=0;
		public var totalmoney:Number=0;
		public var price:Number=0;
		public var totalweight:Number=0;
		public var flag:int=0;
		public var ispay:int=0;
		public var totalqty:int=0;
		public var oa_id:String='';
		public var receive:int=0;
		public var out_trade_no:String='';
		public var subject:String='';
		public var body:String='';
		public var buyeremail:String='';
		public var _creatorName:String='';
		public var _orderAddress:Object;
		public var _products:Object;
	
		public function Order()
		{
		}
	}
}