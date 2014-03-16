package mvc.view.front.product.event
{
	import flash.events.Event;
	
	import mvc.view.front.product.vo.ProductFilter;
	
	public class ProductFilterEvent extends Event
	{
		public static const FILTER:String = "filter";
		
		public var live:Boolean;
		public var filter:ProductFilter;
		
		public function ProductFilterEvent(filter:ProductFilter, live:Boolean)
		{
			super(FILTER);
			this.filter = filter;
			this.live = live;
		}
	}
}