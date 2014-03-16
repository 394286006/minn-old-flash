package mvc.view.front.product.event
{
	import flash.events.Event;
	
	import mvc.model.merchandise.vo.Product;
	
	
	public class ProductDetailEvent extends Event
	{
		public static const PURCHASE:String = "purchase";
		public static const COMPARE:String = "compare";
		public static const DETAILS:String = "details";
		public static const BROWSE:String = "browse";
		
		public var product:Product;
		
		public function ProductDetailEvent(type:String, product:Product,call:Boolean=false)
		{
			super(type,call);
			this.product=product;
		}
		override public function clone():Event
		{
			return new ProductDetailEvent(type, product);
		}
	}
}