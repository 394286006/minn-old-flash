package mvc.view.front.product.component
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mvc.model.merchandise.vo.Product;
	import mvc.view.front.product.event.ProductDetailEvent;
	import mvc.view.front.product.event.ProductListEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	
	public class ProductView extends Canvas
	{
		public static const COL_WIDTH_4:int = 200;
		public static const COL_HEIGHT_4:int = 200;
		public static const COL_WIDTH_3:int = 217;
		public static const COL_HEIGHT_3:int = 165;
		public static const COL_WIDTH_2:int = 327;
		public static const COL_HEIGHT_2:int = 250;
		public static const COMPARE_WIDTH:int = 162;
		public static const HORIZONTAL_GAP:int = 2;
		public static const VERTICAL_GAP:int = 3;
		

		[Bindable]
		private var _product:Product;
		private var dragStartPoint:Point;
//		public var ism:Boolean=false;
		
		private var buttons:VBox=null;
		private var purchase:Button=null;
		public var compare:Button=null;
		private var details:Button=null;
	
		[Embed('/assets/icon_cart_empty.gif')]
		private var purchaseicon:Class;
		[Embed('/assets/icon_compare.gif')]
		private var compareicon:Class;
		[Embed('/assets/icon_details.png')]
		private var detailsicon:Class;
		
		private var imgshow:Image=null;
		private var lb0:Label=null;
		private var lb1:Label=null;
		private var lb2:Label=null;
		public var iscompare:Boolean=true;
		public function ProductView()
		{
			super();
			this.width=COL_WIDTH_4;
			this.height=COL_HEIGHT_4;
			this.setStyle("borderStyle","solid");
			this.setStyle("borderColor","#FFFFFF");
			setStyle("backgroundColor","#fffffe");
			this.setStyle("color","#575252");
			this.verticalScrollPolicy="off";
			this.horizontalScrollPolicy="off";
			this.useHandCursor=true;
			this.buttonMode=true;
			this.addEventListener(MouseEvent.MOUSE_OVER,rollOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,rollOutHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			this.addEventListener(MouseEvent.CLICK,clickHandler);
			this.addEventListener(FlexEvent.CREATION_COMPLETE,completeHandler);
			lb0=new Label();
//			lb0.setStyle("fontSize","11");
//			lb0.setStyle("fontWeight","bold");
			lb1=new Label();
//			lb1.setStyle("fontSize","11");
//			lb1.setStyle("fontWeight","bold");
			lb2=new Label();
			lb2.setStyle("textAlign","center");
			lb2.percentWidth=100;
			imgshow=new Image();
			imgshow.percentHeight=100;
			imgshow.percentWidth=100;
			
		}
	
		public function get product():Product{
			return this._product;
		}
		public function set product(p:Product):void{
			this._product=p;
			lb0.text=p.parentCategoryName;
			lb1.text=p.categoryName;
			lb2.text=p.name;
			if(p._photos!=''&&p._photos[0].hasOwnProperty("imgpath"))
			imgshow.source=Config.UPLOAD_DIR_IMALEVEL1+p._photos[0].imgpath;
		}
		private function completeHandler(evt:FlexEvent):void{
//			Alert.show(product._photos.toString());
//			imgshow.source=Config.UPLOAD_DIR_IMALEVEL1+product._photos[0].imgpath;
		}
		override protected function createChildren():void{
			super.createChildren();
			
			var vb:VBox=new VBox();
			vb.percentHeight=100;
			vb.percentHeight=100;
			vb.setStyle("verticalGap",3);
			vb.setStyle("paddingLeft",2);
			
			
			var hb:HBox=new HBox();
			hb.percentWidth=100;
			hb.setStyle("horizontalGap",2);
			var sp:Spacer=new Spacer();
			sp.width=1;
			hb.addChild(sp);
			var lb:Label=new Label();
			lb.text="分类:";
			lb.setStyle("fontWeight","bold");
		    hb.addChild(lb);
//			lb0=new Label();
//			lb0.setStyle("fontSize","11");
//			lb0.setStyle("fontWeight","bold");
//			BindingUtils.bindProperty(_product,"parentCategoryName",lb,"text");
//			BindingUtils.bindProperty(lb0,"text",product,"parentCategoryName");
			hb.addChild(lb0);
		
			var img:Image=new Image();
			img.height=25;
			img.source="assets/img/arrow_next.gif";
			hb.addChild(img);
//			lb1=new Label();
//			lb1.setStyle("fontSize","11");
//			lb1.setStyle("fontWeight","bold");
			hb.addChild(lb1);
//			BindingUtils.bindProperty(lb1,"text",product,"categoryName");
			vb.addChild(hb);
			var vb1:VBox=new VBox();
			vb1.setStyle("verticalGap",2);
			vb1.percentWidth=100;
			var cans:Canvas=new Canvas();
			cans.setStyle("borderStyle","outset");
			cans.width=194;
			cans.height=146;
			cans.addChild(imgshow);
			cans.setChildIndex(imgshow,0);
			vb1.addChild(cans);
//			lb2=new Label();
//			lb2.setStyle("textAlign","center");
//			lb2.percentWidth=100;
			vb1.addChild(lb2);
//			BindingUtils.bindProperty(lb2,"text",product,"name");
			vb.addChild(vb1);
			
			this.addChild(vb);
			
//			this.rawChildren.addChild(vb);
			buttons=new VBox();
			buttons.visible=false;
			buttons.setStyle("verticalGap",4);
			buttons.setStyle("paddingRight",5);
			buttons.setStyle("right",8);
			buttons.setStyle("top",15);
			
			purchase=new Button();
//			purchase.setStyle("icon",purchaseicon);
			purchase.label="购物";
			purchase.styleName="productViewbtn";
			purchase.width=50;
			purchase.toolTip="添加到购物车";
			purchase.addEventListener(MouseEvent.CLICK,purchaseHandler);
			buttons.addChild(purchase);
			
			compare=new Button();
//			compare.setStyle("icon",compareicon);
			compare.label="比较";
			compare.styleName="productViewbtn";
			compare.width=50;
			compare.toolTip="添加到比较列表";
			compare.addEventListener(MouseEvent.CLICK,compareHandler);
			buttons.addChild(compare);
			
			details=new Button();
//			details.setStyle("icon",detailsicon);
			details.label="详情";
			details.styleName="productViewbtn";
			details.width=50;
			details.toolTip="商品详细情况";
			details.addEventListener(MouseEvent.CLICK,detailsHandler);
			buttons.addChild(details);
			
			this.addChild(buttons);
//		  this.setChildIndex(vb,0);
		}
		
		private function purchaseHandler(evt:MouseEvent):void{
//			dispatchEvent(new Event('showProductCart',true));
//			var p:ProductListEvent=new ProductListEvent(ProductListEvent.ADD_PRODUCT);
//			p.product=product;
//			dispatchEvent(p);
			dispatchEvent(new ProductDetailEvent(ProductDetailEvent.PURCHASE, product));
		}
		private function compareHandler(evt:MouseEvent):void{
			if(iscompare){
				dispatchEvent(new Event('hideProductCart',true));
				dispatchEvent(new ProductDetailEvent(ProductDetailEvent.COMPARE, product));
			}else{
				iscompare=true;
				compare.label="比较";
				compare.toolTip="添加到比较列表";
				dispatchEvent(new ProductDetailEvent(ProductDetailEvent.BROWSE,null));
			}
		}
		private function detailsHandler(evt:MouseEvent):void{
			dispatchEvent(new ProductDetailEvent(ProductDetailEvent.DETAILS, product));
		}
		private function rollOverHandler(evt:MouseEvent=null):void
		{
//			if(!ism){
				setStyle("backgroundColor","#fffffe");
				this.alpha=0.9;
				setStyle("borderColor", "#CCCCCC");
				setStyle("dropShadowEnabled", true);
				buttons.visible = true;
//			}
			
		}
		
		public function rollOutHandler(event:MouseEvent=null):void
		{
			//				setStyle("backgroundColor",);
			//				this.clearStyle("backgroundColor");
			this.alpha=1;
			setStyle("borderColor", "#FFFFFF");
			setStyle("dropShadowEnabled", false);
			buttons.visible = false;
		}
		public function clickHandler(event:MouseEvent):void
		{
			if (event.target != purchase &&
				event.target != compare &&
				event.target != details)
			{
				dispatchEvent(new ProductDetailEvent(ProductDetailEvent.DETAILS, product));
			}
		}
		
		
		
		public function mouseDownHandler(event:MouseEvent):void
		{
			
			if (event.target != purchase &&
				event.target != compare &&
				event.target != details)
			{
				dragStartPoint = new Point(event.stageX, event.stageY);
				dragStartPoint = globalToLocal(dragStartPoint);
				//					Alert.show("dragstart");
			}
		}
		
		public function mouseMoveHandler(event:MouseEvent):void
		{
			if (dragStartPoint != null)
			{
				var dragEvent:DragEvent = new DragEvent(DragEvent.DRAG_START, true);
				dragEvent.localX = dragStartPoint.x;
				dragEvent.localY = dragStartPoint.y;
				dragEvent.buttonDown = true;
				dispatchEvent(dragEvent);
				
				rollOutHandler(event);
				
				dragStartPoint = null;
			}
		}
		
		public function mouseUpHandler(event:MouseEvent):void
		{
			if (dragStartPoint != null)
			{
				dragStartPoint = null;
			}
		}
	}
}