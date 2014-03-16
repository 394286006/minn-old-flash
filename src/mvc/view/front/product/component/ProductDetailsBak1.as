package mvc.view.front.product.component
{
	import mvc.model.merchandise.vo.Product;
	
	import mx.containers.Canvas;
	
	[Event(name="purchase", type="mvc.view.front.product.event.ProductDetailEvent")]
	[Event(name="compare", type="mvc.view.front.product.event.ProductDetailEvent")]
	[Event(name="browse", type="mvc.view.front.product.event.ProductDetailEvent")]
	
	public class ProductDetailsBak1 extends Canvas
	{
		
		private var _product:Product;
		private var picexp:PicExpBak=null;
		[Bindable]
		public function get product():Product
		{
			return _product;
		}
		
		public function set product(p:Product):void
		{
			_product = p;
			//				tn.selectedIndex = 0;
			picexp.product=p;
			
		}
		public function ProductDetailsBak1()
		{
			super();
		}
	    override protected function createChildren():void{
			super.createChildren();
		}
	}
}