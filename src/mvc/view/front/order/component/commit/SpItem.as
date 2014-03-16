/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.order.component.commit
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mvc.model.merchandise.vo.Product;
	
	import mx.containers.HBox;
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.core.UIComponent;
	
	[Event(name="removeSpItem", type="flash.events.Event")]
	public class SpItem extends HBox
	{
		
		private var _product:Product;
		
		private var normalcolor:uint=0x501b09;
		private var mouseovercolor:uint=0xad3f11;
		
		public function set product(p:Product):void{
			this._product=p;
			name_id.text=p.name;
		}
		public function get product():Product{
			return _product;
		}
		public function SpItem()
		{
			super();
			this.height=25;
			this.width=280;
			this.setStyle("fontSize",13);
			this.setStyle("horizontalGap","0");
			this.setStyle("color","#ffffff");
			this.setStyle("dropShadowEnabled",true);
			this.buttonMode=true;
			this.useHandCursor=true;
		    this.setStyle("backgroundColor",normalcolor);
			this.addEventListener(MouseEvent.ROLL_OVER,function(evt:MouseEvent):void{
				SpItem(evt.target).setStyle("backgroundColor",mouseovercolor);
			});
			this.addEventListener(MouseEvent.ROLL_OUT,function(evt:MouseEvent):void{
				SpItem(evt.target).setStyle("backgroundColor",normalcolor);
			});
			this.addEventListener(MouseEvent.CLICK,showDetail);
		}
		protected function showDetail(evt:MouseEvent):void{
			CommitOrderPanel(parent.parent.parent).showProductDetail(null,product);
		}
	
		protected function remmoveItemHandler(evt:MouseEvent):void{
			OrderProductConfig(parent.parent).removeSpItem(this);
		}
		
		private var name_id:Label;
		private var removeui:UIComponent;
		override protected function createChildren():void{
			
			super.createChildren();
			name_id=new Label();
			name_id.percentHeight=100;
			name_id.percentWidth=100;
			name_id.setStyle("textAlign","center");
			this.addChild(name_id);
			
			removeui=new UIComponent();
			removeui.width=12;
			removeui.height=12;
			removeui.buttonMode=true;
			removeui.useHandCursor=true;
			removeui.graphics.lineStyle(3, 0xAF0000);
			removeui.graphics.moveTo(0,8);
			removeui.graphics.lineTo(12,20);
			removeui.graphics.moveTo(0,20);
			removeui.graphics.lineTo(12,8);
			removeui.setStyle("paddingTop",20);
			removeui.addEventListener(MouseEvent.CLICK,remmoveItemHandler);
			this.addChild(removeui);
			var sp:Spacer=new Spacer();
			sp.width=15;
			this.addChild(sp);

		}
	}
}