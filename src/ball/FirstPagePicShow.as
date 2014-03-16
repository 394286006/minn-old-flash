package ball
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import flexmdi.containers.ToolTipWin;
	import flexmdi.events.MinnMessageEvent;
	import flexmdi.events.MinnMessageEventManager;
	
	import mvc.model.merchandise.vo.Product;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Image;
	import mx.effects.Move;
	import mx.effects.Zoom;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.managers.PopUpManager;
	import mx.modules.Module;
	
	public class FirstPagePicShow extends Canvas //Module
	{
		private var buttons:VBox=null;
		private var purchase:Button=null;
		private var compare:Button=null;
		private var details:Button=null;
		
		[Embed('/assets/icon_cart_empty.gif')]
		private var purchaseicon:Class;
		[Embed('/assets/icon_compare.gif')]
		private var compareicon:Class;
		[Embed('/assets/icon_details.png')]
		private var detailsicon:Class;
		[Bindable]
		private var _product:Product;
		
		private var _img:Image=null;
		private var dept:Number=1;
		private var zoom:Zoom=null;
		private var m:Move=null;
		private var iscreate:Boolean=false;
		public function FirstPagePicShow()
		{
			super();
			this.width=550;
			this.height=400;
			this.setStyle("cornerRadius",5);
			this.horizontalScrollPolicy="off";
			this.verticalScrollPolicy="off";
			this.addEventListener(FlexEvent.PREINITIALIZE,module1_preinitializeHandler);
			this.addEventListener(FlexEvent.CREATION_COMPLETE,createComplelteHandler);
			this.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE,closethis);
			this.addEventListener(MouseEvent.MOUSE_DOWN,vb_mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,vb_mouseUpHandler);
			this.addEventListener(MouseEvent.MOUSE_MOVE,vb_mouseMoveHandler);
		
		}
		protected function module1_preinitializeHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
			//				this.addEventListener(this.parent.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,messageHandler);
			//				MinnMessageEventManager.getInstance().addEventListener(this.parent.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,messageHandler);
//			MinnMessageEventManager.getDisp().addEventListener(this.parent.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,messageHandler);
//			Alert.show("parent:"+this.parent.toString());
		}
		private var item:Object;
		private function messageHandler(e:MinnMessageEvent):void{
			item=e.data;
			product=e.data.product as Product;
			if(!iscreate)
				createComplelteHandler();
		}
		protected function imgshow_mouseWheelHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//                Alert.show('d');
			if(event.delta>0){
				dept+=0.1;
				
			}else{
				dept-=0.1;
				if(dept<0.6)
					dept=0.6;
			}
			zoom.zoomHeightTo=dept;
			zoom.zoomWidthTo=dept;
			(!zoom.isPlaying)
			zoom.play();
			
		}
		
		private function zoomEndHandler(e:EffectEvent):void{
			m=new Move();
			m.target=this;
			var p1:Point=this.localToContent(new Point(this.screen.width/2-width/2,this.screen.height/2-height/2));
			m.xTo=p1.x;
			m.yTo=p1.y;
//			m.xTo=this.parentApplication.screen.width/2-_img.measuredWidth/2;//p1.x;
//			m.yTo=this.parentApplication.screen.height/2-_img.measuredHeight/2;//p1.y;
			m.play();
		}
		private function closethis(evt:FlexMouseEvent):void{
			PopUpManager.removePopUp(this);
		}
		override protected function createChildren():void{
			_img=new Image();
//			_img.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
//				PopUpManager.removePopUp((evt.currentTarget as Image).parent as FirstPagePicShow);
//			});
			_img.percentHeight=100;
			_img.percentWidth=100;
			_img.useHandCursor=true;
			_img.buttonMode=true;
//			_img.addEventListener(FlexEvent.CREATION_COMPLETE,imgcompleteHandler);
//			_img.addEventListener(FlexEvent.UPDATE_COMPLETE,imgcompleteHandler);
			this.addChild(_img);
			buttons=new VBox();
			buttons.x=480;
			buttons.y=20;
			buttons.setStyle("verticalGap",10);
			purchase=new Button();
			purchase.width=50;
			purchase.addEventListener(MouseEvent.CLICK,add2Cart);
//			purchase.setStyle("icon",purchaseicon);
			purchase.label="购物";
//			purchase.toolTip="添加到购物车";
			new ToolTipWin(purchase,"添加到购物车");
			buttons.addChild(purchase);
			compare=new Button();
			compare.width=50;
//			compare.setStyle("icon",compareicon);
			compare.label="比较";
			compare.addEventListener(MouseEvent.CLICK,add2Compare);
			new ToolTipWin(compare,"添加到比较列表");
//			compare.toolTip="添加到比较列表";
			buttons.addChild(compare);
			this.addChild(buttons);
			
			zoom=new Zoom();
			zoom.target=this;
			zoom.duration=1;
		
			zoom.addEventListener(EffectEvent.EFFECT_END,zoomEndHandler);
			this.addEventListener(MouseEvent.MOUSE_WHEEL,imgshow_mouseWheelHandler);
		}
		
		private function add2Compare(evt:MouseEvent):void{
//			parentApplication.add2compareList(product);
			this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"add2compareList",product,true));
		}
		private function add2Cart(evt:MouseEvent):void{
//			parentApplication.add2cartList(product);
			this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"add2Cart",product,true));
		}
		private function imgcompleteHandler(evt:FlexEvent):void{
			this.width=_img.width;
			this.height=_img.height;
			
		}
		
		private function createComplelteHandler(evt:FlexEvent=null):void{
//			this.width=_img.width;
//			this.height=_img.height;
			iscreate=true;
//			imgsource=item.imgsource;
		}
		
		public function set imgsource(source:Object):void{
			 _img.source=source;
		}
		
		public function get product():Product{
			return this._product;
		}
		public function set product(pro:Product):void{
			this._product=pro;
			_img.toolTip=_product.descript;
		}
		private var startx:Number=0;
		private var starty:Number=0;
		private var ismv:Boolean=false;
		protected function vb_mouseDownHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			ismv=true;
			startx=this.mouseX;
			starty=this.mouseY;
			//				Alert.show(startx.toString());
		}
		
		
		protected function vb_mouseUpHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			ismv=false;
			//				Alert.show("mouseup");
			
		}
		
		
		protected function vb_mouseMoveHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(ismv){
				var p1:Point=localToGlobal(new Point(startx,starty));
				//				var p2:Point=localToGlobal(new Point(event.stageX ,event.stageY));
				var p2:Point=localToGlobal(new Point(this.mouseX ,this.mouseY));
				//				trace("x"+p2.x+" y:"+p2.y);
				trace("x"+(p2.x-p1.x)+" y:"+(p2.y-p1.y));
				
				this.x=this.x+ (p2.x-p1.x);//vb.x-(event.stageX-startx)-100;
				this.y=this.y+(p2.y-p1.y);//vb.y-(event.stageY-starty)-50;
			}
			//				trace("curent:"+vb.x);
		}
	}
}