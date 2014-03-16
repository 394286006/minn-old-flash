/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.merchandise.vo
{
	import mvc.model.ctype.vo.Ctype;

	[RemoteClass(alias="front.product.Product")]   
	[Bindable]   
	public class Product
	{
		
		public var id:String='';
		public var name:String='';
		public var descript:String='';
		public var price:String='';
		public var category_id:String='';
		public var categoryName:String='';
		public var parent_category_id:String='';
		public var parentCategoryName:String='';
		public var pcount:String='';
		public var upTime:String='';
		public var downTime:String='';
		public var weight:String='';
		public var _discount:String='';
		public var _photos:Object;
		public var _qty:int; 
	
		public function Product()
		{
		}
		public function fill(obj:Object):void
		{
			for (var i:String in obj)
			{
				this[i] = obj[i];
			}
		}
	}
}