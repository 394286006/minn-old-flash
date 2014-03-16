package mvc.view.front.product.component
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import minn.common.MenuLabel;
	
	import mvc.model.merchandise.vo.Product;
	import mvc.view.front.product.event.ProductDetailEvent;
	import mvc.view.front.product.event.ProductListEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.formatters.CurrencyFormatter;
	import mx.states.AddChild;
	import mx.states.State;
	
	
	[Event(name="productQtyChange", type="mvc.view.front.product.event.ProductListEvent")]
	[Event(name="removeProduct", type="mvc.view.front.product.event.ProductListEvent")]
	public class ProductItem extends HBox
	{
		
		[Bindable]
		[Embed('/assets/trashcan.png')]
		private var delicon:Class;
		
		[Bindable]
		public var product:Product;
		
		private var qty:TextInput=null;
		private var cf:CurrencyFormatter=null;
		
		public function ProductItem()
		{
			super();
			this.height=30;
			this.percentWidth=100;
			this.styleName="listItem";
			this.addEventListener(MouseEvent.CLICK,item_clickHandler);
		}
		
		override protected function createChildren():void{
		
		    super.createChildren();
			var stats:State=new State();
			stats.name="showQuantity";
			qty=new TextInput();
			qty.width=25;
			qty.text=product._qty+'';
			qty.setStyle("textAlign","right");
			qty.setStyle("maxChars",3);
			qty.setStyle("color","#575252");
			qty.addEventListener(Event.CHANGE,qtyChangeHandler);
			BindingUtils.bindProperty(qty,"text",product,"_qty");
			var ac:AddChild=new AddChild();
			ac.target=qty;
			stats.overrides=[ac];
			this.states=[stats];
			
			cf=new CurrencyFormatter();
			cf.currencySymbol="￥";
			cf.precision=2;
//			var btn:MenuLabel=new MenuLabel();
			var btn:Button=new Button();
//			btn.width=14;
//			btn.height=14;
			btn.label="删除";
//			btn.setStyle("icon",delicon);
			btn.buttonMode=true;
			btn.useHandCursor=true;
			btn.addEventListener(MouseEvent.CLICK,removeItem);
			this.addChild(btn);
			var label:Label=new Label();
			label.maxWidth=100;
			label.text=product.name;
			this.addChild(label);
			BindingUtils.bindProperty(label,"text",product,"name");
			var sp:Spacer=new Spacer();
			sp.percentWidth=100;
			this.addChild(sp);
			label=new Label();
			label.maxWidth=100;
			label.text=cf.format(product.price);
			this.addChild(label);
			
		}
		
		private function qtyChangeHandler(evt:Event):void{
			product._qty = int(qty.text);
			var event:ProductListEvent = new ProductListEvent(ProductListEvent.PRODUCT_QTY_CHANGE,true);
			event.product = product;
			dispatchEvent(event);
		}
		
		private function qtyChange():void
		{
			
			product._qty = int(qty.text);
			
			var event:ProductListEvent = new ProductListEvent(ProductListEvent.PRODUCT_QTY_CHANGE,true);
			event.product = product;
			dispatchEvent(event);
		}
		
		private function removeItem(evt:MouseEvent):void
		{
			var event:ProductListEvent = new ProductListEvent(ProductListEvent.REMOVE_PRODUCT,true);
			event.product = product;
			dispatchEvent(event);
		}
		
		
		protected function item_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var evt:ProductDetailEvent=new ProductDetailEvent(ProductDetailEvent.DETAILS,product,true);
			dispatchEvent(evt);
			//				Alert.show('showdetails');
		}
	}
}