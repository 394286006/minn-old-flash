/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.order.event
{
	import flash.events.Event;
	
	public class OrderEvent extends Event
	{
		public static const ORDER_RESIZE:String = "ORDER_RESIZE";
		public static const ORDER_QUERY:String="ORDER_QUERY";
		public static const ORDER_LOAD_CANCEL:String="ORDER_LOAD_CANCEL";
		public var data:Object;
		public function OrderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}