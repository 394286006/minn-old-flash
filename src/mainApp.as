/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package
{
	import com.adobe.ac.mxeffects.DistortionConstants;
	import com.adobe.ac.mxeffects.Flip;
	import com.flashdynamix.motion.effects.core.ColorEffect;
	import com.flashdynamix.motion.effects.core.FilterEffect;
	import com.flashdynamix.motion.extras.Emitter;
	import com.flashdynamix.motion.layers.BitmapLayer;
	
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.engine.SpaceJustifier;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import flexmdi.containers.MDICanvas;
	import flexmdi.events.MinnMessageEvent;
	import flexmdi.events.MinnMessageEventManager;
	
	import minn.common.DrawLine;
	import minn.common.Entrypt;
	import minn.common.MenuLabel;
	import minn.proxy.WindowProxy;
	
	import mvc.model.merchandise.vo.Product;
	import mvc.model.user.vo.User;
	import mvc.view.front.order.component.commit.CommitOrderPanel;
	import mvc.view.front.order.component.show.AlipayFrame;
	import mvc.view.front.order.component.show.AlipayFrame2;
	import mvc.view.front.order.event.OrderEvent;
	import mvc.view.front.product.component.SearchProductPanel;
	import mvc.view.front.product.component.ShopCard;
	import mvc.view.front.product.component.ShowProductPanel;
	import mvc.view.front.product.event.ProductDetailEvent;
	import mvc.view.front.product.event.ProductListEvent;
	import mvc.view.front.user.component.ExitOrModify;
	import mvc.view.front.user.component.LoginOrRegister;
	import mvc.view.front.user.component.LoginOrRegisterPanel;
	import mvc.view.front.user.component.LoginPanel;
	import mvc.view.front.user.component.RegisterPanel;
	
	import mx.collections.ArrayCollection;
	import mx.containers.ApplicationControlBar;
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.Panel;
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.controls.Menu;
	import mx.controls.SWFLoader;
	import mx.controls.Spacer;
	import mx.controls.ToggleButtonBar;
	import mx.controls.VRule;
	import mx.core.UIComponent;
	import mx.effects.Blur;
	import mx.effects.Move;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.ItemClickEvent;
	import mx.events.MenuEvent;
	import mx.events.ModuleEvent;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	import mx.modules.Module;
	import mx.modules.ModuleLoader;
	
	import skin.ExpToggleBtn;
	
	import spark.components.ButtonBar;
	import spark.components.ToggleButton;
	import spark.effects.Resize;

//	include 'mvc/base/FrontBaseImport.as';
//	include 'assets/css/app_css.css';
	public class mainApp extends  Module
	{
	
		[Bindable]
		public var user:User=null; 
		//			private var lom:LoginInfoAndExit=null;
		private var lom:ExitOrModify=null;
	
		[Embed("/assets/img/qqlogo.png")]
		private var ic:Class;
		[Embed(source="/assets/magicFxBox.swf", symbol="Box")]
		private var Box:Class;
		
		private var emittor :Emitter;
		private var layer :BitmapLayer;
		private var ct :ColorTransform;
		private var uilayer:UIComponent;
		private var tx : Number;
		private var ty : Number;
		
//		[Bindable] 
		private var menubararr:Array =[{label:"QQ:394286006",icon:ic}];
		//				<>
		//					<menuitem label="咨询" data="1">
		//						<menuitem label="MenuItem 1-A" data="1" icon='{ic}'/>
		//						<menuitem label="MenuItem 1-B" data="1B" icon='{ic}'/>
		//					</menuitem>
		//					
		//				</>;
		private var mr:Resize=new Resize();
		private var mym:Menu=null;
		[Bindable]
		public var _cartCount:int=0;
		
		public var shopCard_id:ShopCard=new ShopCard();
		private var technology_panel_id:TechnologyPanel;
		private var downmenu_resize:Resize=new Resize();
		private var downmenu_move:Move=new Move();
		private var searchProductPanel:SearchProductPanel=new SearchProductPanel();
		private var searchproduct_mv:Move=new Move();
		
		protected function button1_clickHandler(event:MouseEvent=null):void
		{
		}
		[Embed(source="/assets/lightning1.swf", symbol="Lightning1")]
		private var Lightning1:Class;
		[Embed(source="/assets/lightning2.swf", symbol="Lightning2")]
		private var Lightning2:Class;
		[Embed(source="/assets/swlight.swf", symbol="Swirl1")]
		private var Swirl1:Class;
		
		public function mainApp()
		{
			super();
			this.percentHeight=100;
			this.percentWidth=100;
			this.setStyle("layout","absolute");
			this.layout="absolute" ;
			this.setStyle("horizontalScrollPolicy","off");
			this.setStyle("verticalScrollPolicy","off");
			this.addEventListener(FlexEvent.CREATION_COMPLETE,application1_creationCompleteHandler);
		  
			this.addEventListener(ResizeEvent.RESIZE,module1_resizeHandler);
//			styleManager.loadStyleDeclarations2("assets/css/app_css.css");
			
			
		}
		private function titleLogoHandler():void{
			//				var Lightning1 : Class = getDefinitionByName("Lightning1") as Class;
			//				var Lightning2 : Class = getDefinitionByName("Lightning2") as Class;
			//				var Swirl1 : Class = getDefinitionByName("Swirl1") as Class;
			var obj : Object = {alpha:0, rotation:"-180, 180"};
			var emit1:Emitter = new Emitter(Lightning1, obj, 1, 0.5, "0,360", 20, 1);
			emit1.blendMode = BlendMode.ADD;
			emit1.alpha = 0.4;
			//			emit1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 23, -50, 50);
			
			var emit2:Emitter = new Emitter(Swirl1, obj, 1, 0.5, "0,360", 50, 1);
			emit2.blendMode = BlendMode.ADD;
			emit2.transform.colorTransform = new ColorTransform(1, 5, 1, 1, 200, -250, 250);
			
			var layer : BitmapLayer = new BitmapLayer(200, 45, 1, 0x000000, true, true);
			layer.alpha=0.4;
			//			layer.x = 130;
			//			layer.y = 125;
			
			var mtx :Matrix = new Matrix();
			mtx.tx = 65;
			mtx.ty = 20;
			
			layer.add(new ColorEffect(new ColorTransform(1, 1, 1, 0.97)));
			layer.add(new FilterEffect(new BlurFilter(8, 8, 2)));
			
			layer.draw(emit2.holder, mtx);
			layer.draw(emit1.holder, mtx);
			
			swf_id.addChild(layer);
			
			this.addEventListener(Event.ENTER_FRAME, function(e:Event):void{
				drawTitleLogo(e,emit1,emit2);
			});
			
		}
		private function drawTitleLogo(e:Event,emit1:Emitter,emit2:Emitter):void {
			emit1.rotation = -180 + 360 * Math.random();
			emit2.rotation = -180 + 360 * Math.random();
		}
		protected function magicFxHandler():void{
			//			SWFProfiler.init(this);
			//		Alert.show("show");
			////				tween = new TweensyGroup(false, true);
			//				bf = new BlurFilter(10, 10, 2);
			//				ct = new ColorTransform(1, 1, 1, 1, -115, -30, 70);
			//				
			//				layer = new BitmapLayer(this.width, titlemusic_id.height);
			//				layer.add(new ColorEffect(new ColorTransform(1, 1, 1, 0.9)));
			//				layer.add(new FilterEffect(bf));
			//				emittor = new Emitter(Box, null, 2, 1, "0, 360", "1, 110", 1, BlendMode.ADD);
			//				emittor.transform.colorTransform = ct;
			////				emittor.endColor = new ColorTransform(5, 2, 100, 1, 255, -255, -70, -255);
			//				
			//				layer.draw(emittor.holder);
			//			    tx=500;
			//			
			//				addEvent(win, Event.ENTER_FRAME, draw);
			//				addEvent(win, MouseEvent.MOUSE_MOVE, magicMove);
			//				uilayer=new UIComponent();
			////				uilayer.percentWidth=100;
			//				uilayer.addChild(layer);
			//				titlemusic_id.addChild(uilayer);
			
		}
		
		private function magicMove(e :MouseEvent) : void {
			//				var ttx:Number=stage.mouseX;
			//				var tty:Number=stage.mouseY;
			//				if(ttx<390)
			//					ttx=390;
			//				if(tty>titlemusic_id.height)
			//					tty=titlemusic_id.height+10;
			//				tx = ttx;
			//				ty = tty;
		}
		
		private function draw(e : Event) : void {
			emittor.rotation += 20;
			emittor.x += (tx - emittor.x) / 4;
			emittor.y += (ty - emittor.y) / 4;
		}
		
		protected function addEvent(ed : EventDispatcher, type : String, liststener : Function, priority : int = 0, useWeakReference : Boolean = true) : void {
			ed.addEventListener(type, liststener, false, priority, useWeakReference);
		}
		
		protected function removeEvent(ed : EventDispatcher, type : String, listener : Function) : void {
			ed.removeEventListener(type, listener);
		}
		private var blr:Blur=new Blur();
		protected function application1_creationCompleteHandler(event:FlexEvent):void
		{
			//				WindowProxy.getInstance(mdi);
			//				dd.setStyle("headerHeight",0);
			//				dd
			ExternalInterface.call('document.insertScript = function (){ call=function(url){'+
				'var height=screen.availHeight;var width=screen.availWidth;if(navigator.userAgent.indexOf("MSIE")>=0){open(url,"_blank"," scrollbars=1,resizable=1,width="+width+"px,height="+height+"px");}else{open(url,"_blank","scrollbars=yes,resizable=1,width="+width+"px,height="+height+"px");}}} ');

		
			titleLogoHandler();
			
			MinnMessageEventManager.getInstance().addEventListener(MinnMessageEvent.MESSAGE+"openLoginWin",function():void{
				popLoginWin("login");
			});
			MinnMessageEventManager.getInstance().addEventListener(MinnMessageEvent.MESSAGE+"orderShowPanel",orderShowHandler);
			MinnMessageEventManager.getInstance().addEventListener(MinnMessageEvent.MESSAGE+"loginSucesses",saveLocale);
			MinnMessageEventManager.getInstance().addEventListener(MinnMessageEvent.MESSAGE+"exit",exitLocal);
			MinnMessageEventManager.getInstance().addEventListener(MinnMessageEvent.MESSAGE+"carCount",carCountHandler);
			MinnMessageEventManager.getInstance().addEventListener(MinnMessageEvent.MESSAGE+"add2Cart",add2cartList);
			MinnMessageEventManager.getInstance().addEventListener(MinnMessageEvent.MESSAGE+"add2compareList",add2compareList);
			MinnMessageEventManager.getInstance().addEventListener("SearchProductPanel",showSearchProductPanelHandler);
			//MinnMessageEventManager.getInstance().addEventListener(ProductDetailEvent.SHOW_PRODUCT_DETAIL,productShowWin);
			var timer:Timer=new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			//				timer.start();
			blr.duration=400;
			blr.blurXTo=30;
			blr.blurYTo=30;
			blr.blurXFrom=0;
			blr.blurYFrom=0;
//			tbb.dataProvider=[firstPage_id,shopPage_id];
			//				musicHandler();
			//				magicFxHandler();
			
			Entrypt.loadswfObject("ball/FirstPage"+Config.SUBFFIX,loadFisrtPageswfCompleteHandler,this);
			Entrypt.loadswfObject("mvc/view/front/product/component/ProductShowPanel"+Config.SUBFFIX,loadShopPageswfCompleteHandler,this);
			Entrypt.loadswfObject("mvc/view/front/order/component/show/ShowOrderPanel2"+Config.SUBFFIX,loadsopswfCompleteHandler,this.parentApplication as DisplayObject);

		}
		
		
		
		private var isOpenSearchProcuctPanel:Boolean=false;
		public function showSearchProductPanelHandler(evt:Event=null):void{
			if(!isOpenSearchProcuctPanel){
				isOpenSearchProcuctPanel=true;
				searchproduct_mv.yTo=0;
			}else{
				isOpenSearchProcuctPanel=false;
				searchproduct_mv.yTo=-(searchProductPanel.height+10);
			}
			searchproduct_mv.play();
		}
		private var count:int=0;
		private function timerHandler(event:TimerEvent):void {
			//								Alert.show("show");
			//				if(count==titlepanel_id.getChildren().length)
			//					count=0;
			//				blr.targets=[];
			//				var rc:Rect=titlepanel_id.getChildAt(count) as Rect;
			//				blr.target=rc;
			//				blr.play(null,true);
			//				
			//				count++;
		}
		
		private var mc:int=0;
		private var mcb:Boolean=false;
		private function musicHandler():void{
			for(var i:int=0;i<53;i++){
				
				var dl:DrawLine=new DrawLine();
				dl.height=45;
				dl.width=10;
				dl.startX=265+i*15;
				dl.startY=45+mc;
				dl.endX=265+i*15;
				dl.endY=25+mc;
				dl.drawLine(dl.startX,dl.startY,dl.endX,dl.endY,0xc3c4c8);
				dl.addEventListener(MouseEvent.MOUSE_OVER,musicmouseoverHandler);
				dl.addEventListener(MouseEvent.MOUSE_OUT,musicmouseoverHandler);
				//					titlemusic_id.addChild(dl);
				if(i%6==0){
					mcb=!mcb;
				}
				if(!mcb){
					mc++;
				}else{
					mc--;
					
				}
			}
			
			//				var mv:Move=new Move();
			//				mv.addEventListener(EffectEvent.EFFECT_END,function(evt:EffectEvent):void{
			//					//						Alert.show(Move(evt.target).targets.length+'');
			//						var m:Move=evt.target as Move;
			////						var mm:DrawLine=m.target as DrawLine;
			//					    m.play([titlemusic_id],true);
			//						mv.play();
			//				});
			//				//					mv.target=dl;
			//				mv.duration=1000;
			//				mv.xTo=30;
			//				mv.play([titlemusic_id],true);
		}
		private function productListEventHandler(event:ProductListEvent):void
		{
			//				Alert.show(event.type);
			//				Alert.show(event.type);
			//				switch (event.type)
			//				{
			//					case ProductListEvent.ADD_PRODUCT:
			//						event.product._qty = 0;  
			//						//fall through into the same logic as dup          
			//						
			//					case ProductListEvent.DUPLICATE_PRODUCT:
			//						event.product._qty++;
			//						//						Alert.show(event.product.qty.toString());
			//						totalWeight += Number(event.product.weight);
			//						total += Number(event.product.price);
			//						numProducts++;
			//						//						productList.addProduct(event.product);
			//						break;            
			//					case ProductListEvent.PRODUCT_QTY_CHANGE:
			//						//						Alert.show("change");
			//					case ProductListEvent.REMOVE_PRODUCT:
			//						var items:Array = productList.items;
			//						total = 0; 
			//						numProducts = 0;
			//						totalWeight=0;
			//						for (var i:int=0; i < items.length; i++)
			//						{
			//							var product:Product = items[i].product;
			//							total += product._qty * Number(product.price);
			//							totalWeight += product._qty * Number(product.weight);
			//							numProducts += product._qty;
			//						}
			//						
			//						break;
			//					default:
			//						break;
			//				}
		}
		
		private function musicmouseoverHandler(evt:MouseEvent):void{
			if(evt.type==MouseEvent.MOUSE_OVER){
				var dl:DrawLine=evt.target as DrawLine;
				dl.graphics.clear();
				dl.drawLine(dl.startX,dl.startY+8,dl.endX,dl.endY-20,0xc3c4c8);
				
			}
			if(evt.type==MouseEvent.MOUSE_OUT){
				dl=evt.target as DrawLine;
				dl.graphics.clear();
				dl.drawLine(dl.startX,dl.startY,dl.endX,dl.endY,0xc3c4c8);
				
			}
		}
		
		private function askitemClickHandler(evt:MenuEvent):void {
			//				Alert.show();
			ExternalInterface.call("callMessage",evt.label.split(":")[1]);
			
		}
		/***
		 * 保存到本地内存
		 * */
		public function saveLocale(evt:MinnMessageEvent):void{
			user=evt.data as User;
			//								Alert.show(user.userName_ch);
			wellcome_id.text="欢迎:"+user.userName_ch;
			this.parentApplication.user=user;
			//				if(save2local){
			//					var so:SharedObject=SharedObject.getLocal("user");
			//					so.data.user=_user;
			//					so.flush();
			//				}
			filp2Loe();
		}
		
		public function exitLocal(evt:MinnMessageEvent):void{
			//				var so:SharedObject=SharedObject.getLocal("user");
			//				so.clear();
			//				so.flush();
			this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"closebook"));
			this.parentApplication.user=null;
			user=null;
			wellcome_id.text="";
			flip2Login();
			secondBtn.selected=false;
			firstBtn.selected=true;
			orderpanel_id.visible=false;
			firstPage_id.visible=true;
			shopPage_id.visible=false;
			this.orderWin.closeThis();
			//				sup.includeInLayout=true;
//			sup.visible=true;
		}
		public function modifyUser(evt:MinnMessageEvent):void{
			//				WindowProxy.getInstance().getPopWin("mvc/view/front/user/component/LoginOrRegisterPanel.swf",this,{type:"modify",item:user},100,460);
			
			Entrypt.loadswfObject("mvc/view/front/user/component/LoginOrRegisterPanel"+Config.SUBFFIX,loadswfCompleteHandler,this);
			//				urlLoader.load(new URLRequest(Config.MAIN_APP));
		}
		public function carCountHandler(evt:MinnMessageEvent):void{
			cartCount=int(evt.data);
			
		}
		
		public function set cartCount(cc:int):void{
			this._cartCount=cc;
			shopcount_id.text="购物车("+_cartCount+")件";
			

		}
		public function get cartCount():int{
			return _cartCount;
		}
		private function loadswfCompleteHandler(evt:Event):void{
			
			if(Config.SUBFFIX==Config.FLAG){
				WindowProxy.getInstance().getPopWin("mvc/view/front/user/component/LoginOrRegisterPanel.swf",evt.target.data as ByteArray,this,{type:"modify",item:user},100,460);
			}else{
				WindowProxy.getInstance().getPopWin("mvc/view/front/user/component/LoginOrRegisterPanel.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY),this,{type:"modify",item:user},100,460);
			}
			
		}
		private function callBack():void{
			Alert.show('callBack!');
		}
		private function searchProduct(e:MouseEvent):void{
			//				Alert.show('d');
		} 
		
		private var _compareList:ArrayCollection=new ArrayCollection();
		private var _cartList:ArrayCollection=new ArrayCollection();
		private var _firstpage:ArrayCollection=new ArrayCollection();
		
		
		public function get firstpage():ArrayCollection{
			return _firstpage;
		}
		public function set firstpage(fg:ArrayCollection):void{
			_firstpage.addAll(fg);
		}
		
		public function get compareList():ArrayCollection{
			return _compareList;
		}
		public function add2compareList(evt:MinnMessageEvent):void{
			var pro:Product=evt.data as Product;
			this._compareList.addItem(pro);
			
			
			
		}
		public function get cartList():ArrayCollection{
			return _cartList;
		}
		public function set cartList(arr:ArrayCollection):void{
			_cartList.removeAll();
			this._cartList.addAll(arr);
		}
		public function add2cartList(evt:MinnMessageEvent):void{
			
			var pro:Product=evt.data as Product;
			//				this.cartList.addItem(pro);
			////				cartCount=_cartList.length;
			//				if(shopCard_id.productList!=null)
			//					cartCount=cartList.length;//+shopCard_id.numProducts;
			//				else
			//				    cartCount=cartList.length;
			//				Alert.show(pro.id);
			addProduct(pro);
		}
		
		
		//			private function publicProduct():void{
		//					for(var j:int=0;j<comparelist.length;j++){
		//						var p:Product=comparelist.getItemAt(j) as Product;
		//						for(var k:int=0;k<cartlist.length;k++){
		//							var p1:Product=cartlist.getItemAt(k) as Product;
		//							if(p.id!=p1.id)
		//								publicProduct.addItem(p);
		//						}
		//					}
		//				
		//			}
		//			protected function login_or_register_clickHandler(event:MouseEvent,type:String):void
		//			{
		//				// TODO Auto-generated method stub
		//				var win:TitleWindow= WindowProxy.getInstance().getSpTitleWindow("mvc/view/front/user/component/LoginOrRegisterPanel.swf",type,null,event.stageX,event.stageY);
		//				//				var clazz:Class = getDefinitionByName("skip.TitleWindowSkinClass") as Class;
		//				//				win.setStyle("skinClass", clazz); 
		//			}
		
		protected function hdividedbox1_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			Alert.show('d');
		}
		
		
		
		protected function tbb_creationCompleteHandler(event:FlexEvent):void
		{
//			Entrypt.loadswfObject("ball/FirstPage"+Config.SUBFFIX,loadFisrtPageswfCompleteHandler,this);
//			Entrypt.loadswfObject("mvc/view/front/product/component/ProductShowPanel"+Config.SUBFFIX,loadShopPageswfCompleteHandler,this);
//			Entrypt.loadswfObject("mvc/view/front/order/component/show/ShowOrderPanel2"+Config.SUBFFIX,loadsopswfCompleteHandler,this.parentApplication as DisplayObject);
			
			//				for(var i:int=0;i<tbb.getChildren().length;i++){
			//					new ToolTipWin(tbb.getChildren()[i],tbb.getChildren()[i].label);
			//				}
			
		}
		
		
		
		private var downorup:Boolean=true;
		public function shop_clickHandler(evt:MouseEvent,type:int):void
		{
			// TODO Auto-generated method stub
			//				tbb.selectedIndex=1;
			//				MinnMessageEventManager.getInstance().dispatchEvent(new Event('showProductCart'));
			//				dispatchEvent(new Event('showProductCart',true));
			//				this.addChild(shopCard);
			//				PopUpManager.addPopUp(shopCard,this);
			//				if(evt!=null){
			downmenu_resize.targets=[];
			downmenu_resize.target=shopCard_id;
			if(evt!=null&&downorup==true){
				var p:Point=localToGlobal(new Point(MenuLabel(evt.target).x,MenuLabel(evt.target).y));
				shopCard_id.x=p.x-shopCard_id.width+MenuLabel(evt.target).width+35;
				//					shopCard_id.y=p.y+15;
				downmenu_move.yTo=0-1;
			}
			//				}
			
			shopCard_id.commitOrder_id.enabled=true;
			cartCount=0;
			
			shopCard_id.numProducts=0;
			if(downorup){
				if(cartList.length>0)
					downorup=false;
				else{
					return;
				}
				shopCard_id.productList.removeAllChildren();
				shopCard_id.productList.items=[];
				
				for(var i:int=0;i<cartList.length;i++){
					
//					shopCard_id.productList.addProduct(cartList.getItemAt(i) as Product,"showcard");
					shopCard_id.productList.addProduct(cartList.getItemAt(i) as Product);
					cartCount+=(cartList.getItemAt(i) as Product)._qty;
					//						Alert.show((_cartList.getItemAt(i) as Product)._qty+'');
				}	
				shopCard_id.numProducts=cartCount;
				downmenu_resize.heightTo=133+shopCard_id.productList.items.length*30;
				downmenu_move.yFrom=-(133+shopCard_id.productList.items.length*30);
				//					_cartList.removeAll();
				if(shopCard_id.productList.items.length==0){
					downmenu_resize.heightTo=0;
					downmenu_move.yTo=-(133+shopCard_id.productList.items.length*30);
				}
			}else{
				for(i=0;i<cartList.length;i++){
					
					//						shopCard_id.productList.addProduct(cartList.getItemAt(i) as Product,"showcard");
					cartCount+=(cartList.getItemAt(i) as Product)._qty;
					//						Alert.show((_cartList.getItemAt(i) as Product)._qty+'');
				}	
				//					Alert.show(shopCard_id.productList.items.length+'');
				downmenu_resize.heightTo=133+shopCard_id.productList.items.length*30;
				shopCard_id.numProducts=cartCount;
				downmenu_move.yFrom=-1;
				if(type==0||type==1){
					//						if(type!=3)
					downorup=true;
					downmenu_resize.heightTo=0;
					downmenu_move.yTo=-(133+shopCard_id.productList.items.length*30);
					//						if(type!=2)
					//							downorup=true;
				}
				if(shopCard_id.productList.items.length==0){
					downmenu_resize.heightTo=0;
					downmenu_move.yTo=-(133+shopCard_id.productList.items.length*30);
				}else{
					
				}
			}
			//				if(downorup)
			if(type==0||type==1){
				downmenu_resize.play();
				downmenu_move.play();
			}else //删除操作
				if(type==2&&shopCard_id.productList.items.length==0&&!downorup){
					//					downorup=true;
					//				cartCount=shopCard_id.numProducts;
					//					Alert.show("downorup");
					downorup=true;
					showprowin.dispClose();
					orderWin.closeThis();
					downmenu_resize.play();
					downmenu_move.play();
				}else {
					downmenu_resize.play();
				}
			
			
			//				Alert.show(shopcount_id.height+'');
		}
		
	
		//从商品列表中添加商品
		public function addProduct(p:Product):void{
			cartCount=0;
			var findp:Boolean=false;
			var pro:Product;
			for(var i:int=0;i<cartList.length;i++){
				pro=cartList.getItemAt(i) as Product;
				if(pro.id==p.id){
					findp=true;
					pro._qty+=1;
					cartList.setItemAt(pro,i);
					p=pro;
					break;
				}
			}
			if(!findp)
				cartList.addItem(p);
			for(i=0;i<cartList.length;i++){
				pro=cartList.getItemAt(i) as Product;
				cartCount+=pro._qty;
			}
			shopCard_id.numProducts=cartCount;
			//				Alert.show("downorup:"+downorup);
			if(downorup==false){
				//					Alert.show('downorup');
//				shopCard_id.productList.addProduct(p,"showcard");
				shopCard_id.productList.addProduct(p);
				shop_clickHandler(null,3);
			}
			
		}
		public function filp2Loe():void{
			//	menuTree.setStyle("borderVisible",false);
			//				lom.width=70;
			var e:Flip = new Flip( loginregister );
			e.siblings = [ lom ];
			e.direction = DistortionConstants.TOP;
			e.duration = 1000;
			e.addEventListener( EffectEvent.EFFECT_END, onEndLoginEffect );
			e.play();
		}
		private function onEndLoginEffect( event :EffectEvent ) : void
		{
			menushow.removeElement( loginregister );
			//	menushow.addElementAt(lom ,1));
			menushow.addChildAt(lom ,1);
		}
		private function flip2Login(evt:MouseEvent=null) : void
		{
			user=null;
			//				lom.width=70;
			var e :Flip = new Flip( lom );
			e.siblings = [ loginregister ];
			e.direction = DistortionConstants.LEFT;
			e.duration = 1000;
			e.addEventListener( EffectEvent.EFFECT_END, onEndLoeEffect );
			e.play();
		}
		private function onEndLoeEffect( event : EffectEvent ) : void
		{
			
			menushow.removeChild( lom );
			menushow.addChildAt( loginregister,1);
			//	menuTree.setStyle("borderVisible",true);
		}
		
		protected function ask_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
//			var lp:Point=this.localToContent(new Point(ask_id.x,ask_id.y));
//							Alert.show(lp.x+':'+lp.y);
			var x:XML=
				<root>
								<menuitem label="MenuItem A" >
									<menuitem label="SubMenuItem A-1" enabled="false"/>
									<menuitem label="SubMenuItem A-2"/>
								</menuitem>
				</root>;
			var mym1:Menu=Menu.createMenu(this.parentApplication as DisplayObjectContainer,x);
			mym1.labelField="@label";
			mym1.show(100,15);
//			Menu.popUpMenu(mym,win,menubararr);
//			mym.show();
//			Alert.show('sdf');
//			mr.play();
		}
		
		private function orderShowHandler(evt:Event=null):void{
			
			if(user!=null){
				//					sup.includeInLayout=false;
//				sup.visible=false;
				//					orderpanel_id.includeInLayout=true;
				secondBtn.selected=false;
				firstBtn.selected=false;
				orderpanel_id.visible=true;
				firstPage_id.visible=false;
				shopPage_id.visible=false;
//				pageshow_id.visible=false;
			
				//					ExternalInterface.call("resizeHandler");
				this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"queryNotPayOrder",null,true));
			}else{
				Alert.show("你好，只有登录用户才能查看订单信息!","提示");
			}
		}
		private function loadsopswfCompleteHandler(evt:Event):void{
			
			if(Config.SUBFFIX==Config.FLAG){
				orderpanel_id.loadModule("mvc/view/front/order/component/show/ShowOrderPanel2",evt.target.data as ByteArray);
				//					WindowProxy.getInstance().getPopWinExplorer("ShowOrderPanel.swf",evt.target.data as ByteArray,this,null,50,280);
			}else{
				orderpanel_id.loadModule("mvc/view/front/order/component/show/ShowOrderPanel2",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY));
				//				WindowProxy.getInstance().getPopWinExplorer("ShowOrderPanel.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY),this,null,50,280);
			}
			this.dispatchEvent(new OrderEvent(OrderEvent.ORDER_QUERY,true));
			button1_clickHandler();
		}
		
		
		private var isFirst:Boolean=true;
		protected function tbb_itemClickHandler(event:ItemClickEvent):void
		{
			// TODO Auto-generated method stub
			//				orderpanel_id.includeInLayout=false;
			orderpanel_id.visible=false;
			//				sup.includeInLayout=true;
//			sup.visible=true;
			
			if(tbb.selectedIndex==1&&!isFirst)
				this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"templist",null,true));
			if(isFirst){
				Entrypt.loadswfObject("mvc/view/front/product/component/ProductShowPanel"+Config.SUBFFIX,loadShopPageswfCompleteHandler,this.parentApplication as DisplayObject);
				isFirst=false;
			}
		}
		private function createOtherCompenent(evt:ModuleEvent):void{
		
			this.addChild(technology_panel_id);
			shopCard_id.height=0;
			this.addChild(shopCard_id);
			
//			downmenu_move.target=shopCard_id;
			searchProductPanel.x=shopcount_id.x-searchProductPanel.width;
			searchProductPanel.y=-(searchProductPanel.height+10);
			this.addChild(searchProductPanel);
			searchproduct_mv.target=searchProductPanel;
			
//			Alert.show('est');
			
			
//			if(orderWin==null){
//				orderWin=new CommitOrderPanel();
//			}
			this.addChild(orderWin);
//			
//			if(showprowin==null)
//				showprowin=new ShowProductPanel();
			
			this.addChild(showprowin);
			
		
//			this.setChildIndex(win,0);
			lom=new ExitOrModify();
//		
			ExternalInterface.addCallback("callBack",callBack);
			Alert.okLabel="确定";
//			mym=Menu.createMenu(ask_id,menubararr);
//			mym.labelField="label";
//			mym.setStyle("showEffect","WipeDown");
//			mym.setStyle("hideEffect","WipeUp");
//			mym.height=5;
//			mym.width=145;
			
//			mym.dataProvider=menubararr;
//			mym.addEventListener(MenuEvent.ITEM_CLICK,askitemClickHandler);
//			mr.heightTo=26;
//			mr.target=mym;
		}
		private function loadFisrtPageswfCompleteHandler(evt:Event):void{
			if(Config.SUBFFIX==Config.FLAG){
				firstPage_id.loadModule("FirstPage.swf",evt.target.data as ByteArray);
			}else
				firstPage_id.loadModule("FirstPage.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY));
			//				firstPage_id.loadModule("FirstPage.swf",evt.target.data as ByteArray);
		
		
		}
		private function loadShopPageswfCompleteHandler(evt:Event):void{
			if(Config.SUBFFIX==Config.FLAG){
				shopPage_id.loadModule("ProductShowPanel.swf",evt.target.data as ByteArray);
			}else
				shopPage_id.loadModule("ProductShowPanel.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY));
			//				shopPage_id.loadModule("ProductShowPanel.swf",evt.target.data as ByteArray);
		}
		
		
		protected function module1_resizeHandler(evt:ResizeEvent):void
		{
			// TODO Auto-generated method stub
			if(layer!=null){
				//					uilayer.width=titlemusic_id.width;
				//					layer.width=uilayer.width;
				//					titlemusic_id.removeChild(uilayer);
				//					magicFxHandler();
				
			}
			var oe:OrderEvent=new OrderEvent(OrderEvent.ORDER_RESIZE,true);
			var obj:Object=new Object();
			obj.width=this.width;
			obj.height=this.height;
			oe.data=obj;
			dispatchEvent(oe);
			//				pageshow_id.width=this.width;
			//				pageshow_id.height=this
		}
		
		
		private var isfirst:Boolean=true;
		protected function sup_changeHandler(event:IndexChangedEvent):void
		{
			// TODO Auto-generated method stub
			//				Entrypt.loadswfObject("ball/FirstPage"+Config.SUBFFIX,loadFisrtPageswfCompleteHandler,this);
			if(isfirst){
				isfirst=false;
				Entrypt.loadswfObject("mvc/view/front/product/component/ProductShowPanel"+Config.SUBFFIX,loadShopPageswfCompleteHandler,this);
				//					for(var i:int=0;i<tbb.getChildren().length;i++){
				//						new ToolTipWin(tbb.getChildren()[i],tbb.getChildren()[i].label);
				//					}
			}
		}
		
		
		protected function technology_clickHandler(event:MouseEvent,type:int):void
		{
			// TODO Auto-generated method stub
			var localpoint:Point=this.localToGlobal(new Point(technology_id.x,technology_id.y));
			technology_panel_id.x=localpoint.x-technology_panel_id.width/2+5;
			technology_panel_id.y=localpoint.y+technology_id.height+20;
			if(type==1){
				//					shop_clickHandler(null,1);
//				downmenu_resize.heightTo=136;
				technology_panel_id.visible=false;
			}else if(type==0){
//				downmenu_resize.heightTo=0;
				technology_panel_id.visible=true;
			}
//			Alert.show(type.toString());
//			downmenu_resize.targets=[];
//			downmenu_resize.target=technology_panel_id;


//			downmenu_resize.play();
		}
		
		
		protected function acb_rollOverHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//				shopCard_id.totalWeight=0;
			//				downmenu_resize.heightTo=0;
			//				downmenu_resize.targets=[];
			//				downmenu_resize.target=shopCard_id;
			//				downmenu_resize.play();
		}
		private var loginWin:LoginOrRegisterPanel=null;
		//			private var userWin:RegisterPanel=null;
		public function popLoginWin(type:String):void{
			if(loginWin==null){
				loginWin=new LoginOrRegisterPanel();
			}
			//				if(type=="login"||type=="backuser"){
			if(!loginWin.isPopUp){
				PopUpManager.addPopUp(loginWin,this);
			}
			var val:Object=new Object();
			val.type=type;
			loginWin.currentState=type;
			if(user!=null){
				val.item=user;
			}
			PopUpManager.centerPopUp(loginWin);
			loginWin.messageHandler(val);
			//			  }
			//				else{
			//				  if(userWin==null)
			//				  userWin=new RegisterPanel();
			//				  if(!userWin.isPopUp){
			//					  PopUpManager.addPopUp(userWin,this);
			//				  }
			//				  var val:Object=new Object();
			//				  val.type=type;
			//				  if(user!=null){
			//					  val.item=user;
			//				  }
			//				  PopUpManager.centerPopUp(userWin);
			//				  userWin.messageHandler(val);
			//			  }
		}
		private var orderWin:CommitOrderPanel=new CommitOrderPanel();
		public function popOrderWin(vobj:Object):void{
			showprowin.dispClose();
			orderWin.messageHandler(vobj);
		}
		
		private var showprowin:ShowProductPanel=new ShowProductPanel();
		private function productShowWin(evt:ProductDetailEvent):void{
			showprowin.showDetail(evt.product);
			orderWin.closeThis();
		}
		private function callManagerFunction(evt:MouseEvent):void{
	
			
			ExternalInterface.call('call',Config.BASE_URL+'shopmanager.html');
		}
		private var win:Panel;
		private var menushow:HBox;
		private var acb:ApplicationControlBar;
		private var tbb:ToggleButtonBar;
		private var shopcount_id:MenuLabel;
		private var wellcome_id:MenuLabel;
		private var firstPage_id:ModuleLoader;
		private var shopPage_id:ModuleLoader;
		private var orderpanel_id:ModuleLoader;
		private var ask_id:MenuLabel;
		private var swf_id:SWFLoader;
		private var loginregister:LoginOrRegister;
		private var technology_id:MenuLabel;
		private var secondBtn:ToggleButton;
		private var firstBtn:ToggleButton;
//		private var pageshow_id:Canvas;
	 override	protected function createChildren():void{
			super.createChildren();
			
			 win=new Panel();
//			 win.addEventListener(FlexEvent.CREATION_COMPLETE,function(evt:FlexEvent):void{
//				 vr.height=acb.height*.45;
//			 });
			win.percentHeight=100;
			win.percentWidth=100;
			
			win.styleName="windstyle1";
//			win.setStyle("styleName","windstyle1");
			win.setStyle("layout","vertical");
			win.layout="vertical";
			win.setStyle("verticalGap",5);
			
			 menushow=new HBox();
			menushow.percentWidth=100;
			menushow.setStyle("horizontalGap",0);
			acb=new ApplicationControlBar();
			acb.minWidth=800;
			acb.percentWidth=100;
			acb.setStyle("paddingTop",0);
			acb.setStyle("paddingBottom",-1);
			acb.setStyle("paddingBottom",-1);
			
			acb.setStyle("horizontalGap",1);
			acb.addEventListener(MouseEvent.MOUSE_OVER,acb_rollOverHandler);
			swf_id=new SWFLoader();
			swf_id.x=1;
			swf_id.y=0;
			swf_id.height=45;
			swf_id.source="assets/titleBack.gif";
			
			acb.addChild(swf_id);
			var sp:Spacer=new Spacer();
			sp.width=100;
			acb.addChild(sp);
//			tbb=new ToggleButtonBar();
//			tbb.dataProvider=sup;
//			tbb.styleName="myToggleButtonBar";
//			tbb.buttonMode=true;
//			tbb.useHandCursor=true;
//			tbb.height=34;
//			tbb.setStyle("buttonWidth",100);
//			tbb.setStyle("fontSize",16);
//			tbb.addEventListener(ItemClickEvent.ITEM_CLICK,tbb_itemClickHandler);
//			acb.addChild(tbb);
			firstBtn=new ToggleButton();
			firstBtn.setStyle("backgroundColor","#ffffff");
			firstBtn.setStyle("fontSize","16");
			firstBtn.label="首页";
			firstBtn.height=28;
			firstBtn.width=100;
			firstBtn.buttonMode=true;
			firstBtn.useHandCursor=true;
			firstBtn.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
				secondBtn.selected=false;
				if(firstBtn.selected){
					orderpanel_id.visible=false;
					firstPage_id.visible=true;
					shopPage_id.visible=false;
				}
			});
//			firstBtn.top=-30;
//			firstBtn.setStyle("top",-30);
//			firstBtn.setStyle("paddingBottom",-5);
			firstBtn.setStyle("skinClass",skin.ExpToggleBtn);
			acb.addChild(firstBtn);
			secondBtn=new ToggleButton();
			secondBtn.setStyle("backgroundColor","#ffffff");
			secondBtn.setStyle("fontSize","16");
			secondBtn.label="商品";
			secondBtn.height=28;
			secondBtn.width=100;
			secondBtn.buttonMode=true;
			secondBtn.useHandCursor=true;
			secondBtn.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
				firstBtn.selected=false;
				if(secondBtn.selected){
					orderpanel_id.visible=false;
					shopPage_id.visible=true;
					firstPage_id.visible=false;
					
				}
			});
			//			firstBtn.top=-30;
			//			firstBtn.setStyle("top",-30);
			//			firstBtn.setStyle("paddingBottom",-5);
			secondBtn.setStyle("skinClass",skin.ExpToggleBtn);
			acb.addChild(secondBtn);
			sp=new Spacer();
			sp.percentWidth=100;
			acb.addChild(sp);
			var manager_id:MenuLabel=new MenuLabel();
			manager_id.text="后台管理";
			manager_id.addEventListener(MouseEvent.CLICK,callManagerFunction);
			acb.addChild(manager_id);
			var vr:VRule=new VRule();
			vr.addEventListener(FlexEvent.UPDATE_COMPLETE,function(evt:FlexEvent):void{
				evt.target.height=acb.height*.45;
			});
			vr.top=5;
			//			vr.height=acb.height*.45;
			vr.alpha=0.75;
			acb.addChild(vr);
			technology_panel_id=new TechnologyPanel();
			technology_panel_id.visible =false;
			technology_panel_id.setStyle("showEffect","WipeDown");
			technology_panel_id.setStyle("hideEffect","WipeUp");
//			downmenu_resize.target=technology_panel_id;
			
			technology_id=new MenuLabel();
			technology_id.text="技术支持";
			technology_id.addEventListener(MouseEvent.MOUSE_OVER,function(evt:MouseEvent):void{
				technology_clickHandler(evt,0);
				
			});
			technology_id.addEventListener(MouseEvent.MOUSE_OUT,function(evt:MouseEvent):void{
				technology_clickHandler(evt,1);
			});
			
			
		
			acb.addChild(technology_id);
			 vr=new VRule();
			vr.addEventListener(FlexEvent.UPDATE_COMPLETE,function(evt:FlexEvent):void{
			   evt.target.height=acb.height*.45;
			});
			vr.top=5;
//			vr.height=acb.height*.45;
			vr.alpha=0.75;
			acb.addChild(vr);
			var img:Image=new Image();
			img.source=ic;
			acb.addChild(img);
		
		    ask_id=new MenuLabel();
			ask_id.text="咨询";
			ask_id.styleName="titlemenubtn";
			ask_id.addEventListener(MouseEvent.CLICK,ask_clickHandler);
			acb.addChild(ask_id);
			vr=new VRule();
			vr.addEventListener(FlexEvent.UPDATE_COMPLETE,function(evt:FlexEvent):void{
				evt.target.height=acb.height*.45;
			});
			vr.top=5;
//			vr.height=acb.height*.45;
			vr.alpha=0.75;
			acb.addChild(vr);
			var order_id:MenuLabel=new MenuLabel();
			order_id.text="我的订单";
			order_id.styleName="menuLabelStyle";
			order_id.buttonMode=true;
			order_id.useHandCursor=true;
			order_id.addEventListener(MouseEvent.CLICK,orderShowHandler);
			acb.addChild(order_id);
			vr=new VRule();
			vr.top=5;
			vr.addEventListener(FlexEvent.UPDATE_COMPLETE,function(evt:FlexEvent):void{
				
				evt.target.height=acb.height*.45;
			});
			vr.alpha=0.75;
			acb.addChild(vr);
			shopcount_id=new MenuLabel();
			shopcount_id.text="购物车(0)件";
			shopcount_id.styleName="menuLabelStyle";
			shopcount_id.buttonMode=true;
			shopcount_id.useHandCursor=true;
			shopcount_id.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
				shop_clickHandler(evt,1);
			});
			acb.addChild(shopcount_id);
			 wellcome_id=new MenuLabel();
//			wellcome_id.text="欢迎";
			acb.addChild(wellcome_id);
			
			menushow.addChild(acb);
			
			loginregister=new LoginOrRegister();
		
			loginregister.setStyle("paddingTop",10);
			menushow.addChild(loginregister);
//			loginregister.top=50;
			sp=new Spacer();
			sp.width=5;
			menushow.addChild(sp);
//			
			win.addChild(menushow);
			
			var pageshow_id:Canvas=new Canvas();//WipeLeft WipeRight 
			pageshow_id.percentHeight=100;
			pageshow_id.percentWidth=100;
			pageshow_id.setStyle("showEffect","WipeLeft");
			pageshow_id.setStyle("hideEffect","WipeRight");
			pageshow_id.horizontalScrollPolicy="off";
			pageshow_id.verticalScrollPolicy="off";
			
			firstPage_id=new ModuleLoader();
			firstPage_id.addEventListener(ModuleEvent.READY,createOtherCompenent);
			firstPage_id.setStyle("showEffect","WipeDown");
			firstPage_id.setStyle("hideEffect","WipeUp");
			firstPage_id.label="首页";
			firstPage_id.percentHeight=100;
			firstPage_id.percentWidth=100;
			firstPage_id.setStyle("horizontalScrollPolicy","off");
			firstPage_id.setStyle("verticalScrollPolicy","off");
			pageshow_id.addChild(firstPage_id);
			shopPage_id=new ModuleLoader();
			shopPage_id.setStyle("showEffect","WipeUp");
			shopPage_id.setStyle("hideEffect","WipeDown");
			shopPage_id.label="商品";
			shopPage_id.percentHeight=100;
			shopPage_id.percentWidth=100;
			shopPage_id.setStyle("horizontalScrollPolicy","off");
			shopPage_id.setStyle("verticalScrollPolicy","off");
			shopPage_id.visible=false;
			pageshow_id.addChild(shopPage_id);
//			win.addChild(pageshow_id);
			
			orderpanel_id=new ModuleLoader();
			orderpanel_id.setStyle("showEffect","WipeLeft");
			orderpanel_id.setStyle("hideEffect","WipeRight");
			orderpanel_id.label="我的订单";
			orderpanel_id.percentHeight=100;
			orderpanel_id.percentWidth=100;
			orderpanel_id.setStyle("horizontalScrollPolicy","off");
			orderpanel_id.setStyle("verticalScrollPolicy","off");
			orderpanel_id.visible=false;
			pageshow_id.addChild(orderpanel_id);
			win.addChild(pageshow_id);
			
			this.addChild(win);
		
//			Alert.show("create");
		}
			
	}
}