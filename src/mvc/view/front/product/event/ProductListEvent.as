package mvc.view.front.product.event
{
	import flash.events.Event;
	
	import mvc.model.merchandise.vo.Product;
	
	
	public class ProductListEvent extends Event
	{
		public static const ADD_PRODUCT:String = "addProduct";
		public static const DUPLICATE_PRODUCT:String = "duplicateProduct";
		public static const REMOVE_PRODUCT:String = "removeProduct";
		public static const PRODUCT_QTY_CHANGE:String = "productQtyChange";
		public static const PRODUCT_QTY_CHANGE_BY_ORDER:String = "PRODUCT_QTY_CHANGE_BY_ORDER";
		public static const PRODUCT_DEL_BY_ORDER:String = "PRODUCT_DEL_BY_ORDER";
		
		public var product:Product;
		
		public function ProductListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}