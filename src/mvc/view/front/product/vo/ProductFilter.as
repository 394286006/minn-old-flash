package mvc.view.front.product.vo
{
	import mvc.model.merchandise.vo.Product;

	[Bindable]
	public class ProductFilter
	{
		public var count:int;
		public var series:String;
		public var minPrice:Number;
		public var maxPrice:Number;
		public var triband:Boolean;
		public var camera:Boolean;
		public var video:Boolean;
		public var name:String;
		
		public function ProductFilter()
		{
			super();
		}
		
		public function accept(product:Product):Boolean
		{
			//price is often the first test so let's fail fast if possible
			if (minPrice > Number(product.price) || maxPrice < Number(product.price))
				return false;
			if(String(product.name).indexOf(name)==-1)
				return false;
//			if (series != "All Series" && series != product.series)
//				return false;
//			if (triband && !product.triband)
//				return false;
//			if (camera && !product.camera)
//				return false;
//			if (video && !product.video)
//				return false;
			
			return true;
		}
	}
}