package mvc.view.front.product.component
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import flexmdi.events.MinnMessageEventManager;
	
	import minn.common.DrawLine;
	import minn.common.Entrypt;
	import minn.proxy.WindowProxy;
	
	import mvc.model.merchandise.vo.Product;
	import mvc.view.front.product.event.ProductListEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.formatters.CurrencyFormatter;
	
	import skin.ShopCardBtn;
	
	import spark.components.Button;
	
	public class ShopCard extends Canvas
	{
//		[Bindable]
		private var _numProducts:int=0;
//		[Bindable]
		public var totalWeight:Number=0;
		
//		[Bindable]
		private var total:Number = 0;
		public function ShopCard()
		{
			super();
			this.percentHeight=100;
			this.width=330;
			this.setStyle("showEffect","WipeDown");
			this.setStyle("hideEffect","WipeUp");
			this.horizontalScrollPolicy="off";
			this.verticalScrollPolicy="off";
			MinnMessageEventManager.getInstance().addEventListener(ProductListEvent.PRODUCT_QTY_CHANGE_BY_ORDER,messageHandler,false);
		
//			this.addEventListener(FlexEvent.CREATION_COMPLETE,function
		}
		private function messageHandler(e:ProductListEvent):void{
			//				addProduct(e.product);
			var tp:Product=e.product;

			var items:Array = productList.items;
			total = 0; 
			numProducts = 0;
			totalWeight=0;
			productList.items=[];
			
			productList.removeAllChildren();
			for (var i:int=0; i < items.length; i++)
			{
			
				var product:Product = items[i].product;
				if(tp.id==product.id){
					product=tp;
					items[i].product=tp;
				}
				productList.addProduct(product);
				total += product._qty * Number(product.price);
				totalWeight+=product._qty * Number(product.weight);
				numProducts += product._qty;
			}
			
		}
		private function drawline():void{
			var line:DrawLine=new DrawLine();
			line.drawLine(32,0,32,52,0x635f5f);
			line_id.addChild(line);
			line=new DrawLine();
			line.drawLine(293,0,293,52,0x635f5f);
			line_id.addChild(line);
			var closeui:UIComponent=new UIComponent();
			closeui.width=12;
			closeui.height=12;
			closeui.buttonMode=true;
			closeui.useHandCursor=true;
			var graphics:Graphics=closeui.graphics;
			graphics.lineStyle(3, 0xAF0000);
			graphics.moveTo(0,0);
			graphics.lineTo(12,12);
			graphics.moveTo(0,12);
			graphics.lineTo(12,0);
			closeui.x=292;
			closeui.y=38;
			closeui.addEventListener(MouseEvent.CLICK,closeShopCard);
			line_id.addChild(closeui);
		}
		private function closeShopCard(evt:MouseEvent):void{
			mainApp(parent).shop_clickHandler(evt,1);
		}
		public function set numProducts(np:int):void{
			_numProducts=np;
		}
		[Bindable]
		public function get numProducts():int{
			return _numProducts;
		}
		protected function commit_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			mainApp(parent).shop_clickHandler(null,1);
			commitOrder_id.enabled=false;
			if(productList.getProducts().length>0){
//				Entrypt.loadswfObject("mvc/view/front/order/component/commit/CommitOrderPanel"+Config.SUBFFIX,loadswfCompleteHandler,this.parentApplication as DisplayObject);
			    
				mainApp(parent).popOrderWin({method:"add",item:productList.getProducts()});
			
			}else{
				Alert.show("你的购物车中没有商品!","提示");
			}
		}
		private function loadswfCompleteHandler(evt:Event):void{
			if(Config.SUBFFIX==Config.FLAG)
				WindowProxy.getInstance().getModuleWindow("mvc/view/front/order/component/commit/CommitOrderPanel.swf",evt.target.data as ByteArray,{method:"add",item:productList.getProducts()},this,false);
			else
				WindowProxy.getInstance().getModuleWindow("mvc/view/front/order/component/commit/CommitOrderPanel.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY),{method:"add",item:productList.getProducts()},this,false);
		}
		private function productListEventHandler(event:ProductListEvent):void
		{
			//				Alert.show(event.type);
			switch (event.type)
			{
				case ProductListEvent.ADD_PRODUCT:
					//						event.product._qty = 1;  
					//fall through into the same logic as dup  
					//						Alert.show("add");
					var items:Array = productList.items;
					for (var i:int=0; i < items.length; i++)
					{
						var product:Product = items[i].product;
						//							if(tempp.id==product.id){
						//								items[i].product=tempp;
						//								product._qty=tempp._qty;
						//							}
						//							//							else{
						//							//								ps.push(product);
						//							//							}
						total += product._qty * Number(product.price);
						totalWeight += product._qty * Number(product.weight);
						numProducts += product._qty;
						//							Alert.show(product._qty+'');
					}
					//						this.parentDocument.cartList=parr;
					//						ArrayCollection(this.parentDocument.cartList).refresh();
					//						ArrayCollection(this.parentDocument.cartList).addAll(ps);
					//						Alert.show(ps[0]._qty);
					//						this.parentDocument.cartCount=numProducts;
					numProducts_id.text="购物总数:"+numProducts;
					totalWeight_id.text="购物总重量(kg):"+totalWeight;
					total_id.text="购物总额(未计物流费):"+total;
					break;
				case ProductListEvent.DUPLICATE_PRODUCT:
					//						if(event.method!="showcard"){
					//						Alert.show("DUPLICATE_PRODUCT:"+event.product._qty);
					//						event.product._qty++;
					//						Alert.show(event.product.qty.toString());
					totalWeight += Number(event.product.weight);
					total += Number(event.product.price);
					//						numProducts++;
					
					//						}
//					numProducts_id.text="购物总数:"+numProducts;
					totalWeight_id.text="购物总重量(kg):"+totalWeight;
					total_id.text="购物总额(未计物流费):"+total;
					//						productList.addProduct(event.product);
					break;            
				case ProductListEvent.PRODUCT_QTY_CHANGE:
					//						Alert.show("PRODUCT_QTY_CHANGE:"+event.product._qty);
					//						Alert.show("change");
					var parr:ArrayCollection=new ArrayCollection();
					var tempp:Product=event.product as Product;
					var cardl:ArrayCollection =mainApp(parent).cartList;
					total = 0; 
					numProducts = 0;
					totalWeight=0;
					for (var j:int=0; j < cardl.length; j++)
					{
						var p:Product = cardl.getItemAt(j) as Product;
						if(tempp.id==p.id){
							//								product=tempp;
							p._qty=tempp._qty;
						}
						//							else{
						//								ps.push(product);
						//							}
						total += p._qty * Number(p.price);
						totalWeight += p._qty * Number(p.weight);
						numProducts += p._qty;
						//							Alert.show(product._qty+'');
						parr.addItem(p);
					}
					mainApp(parent).cartList=parr;
					//						ArrayCollection(this.parentDocument.cartList).refresh();
					//						ArrayCollection(this.parentDocument.cartList).addAll(ps);
					//						Alert.show(ps[0]._qty);
					mainApp(parent).cartCount=numProducts;
					numProducts_id.text="购物总数:"+numProducts;
					totalWeight_id.text="购物总重量(kg):"+totalWeight;
					total_id.text="购物总额(未计物流费):"+total;
					break;
				case ProductListEvent.REMOVE_PRODUCT:
					tempp=event.product;
					tempp._qty=1;
					items = productList.getProducts();
					total = 0; 
					numProducts = 0;
					totalWeight=0;
					//						Alert.show(productList.getProducts().length+'');
					for ( i=0; i < items.length; i++)
					{
						 product = items[i]as Product;
						if(tempp.id!=product.id){
							//								productList.items[i].product=tempp;
							//								product=tempp;
							//								items
							//								product._qty=1;
							//								tempp._qty=1;
						}
						total += product._qty * Number(product.price);
						totalWeight += product._qty * Number(product.weight);
						numProducts += product._qty;
					}
					//					    ArrayCollection(this.parentDocument.cartList).removeAll();
					mainApp(parent).cartList=(new ArrayCollection(productList.getProducts()));
					mainApp(parent).shop_clickHandler(null,2);
					numProducts_id.text="购物总数:"+numProducts;
					totalWeight_id.text="购物总重量(kg):"+totalWeight;
					total_id.text="购物总额(未计物流费):"+total;
					//						Alert.show("removeproduct");
					
					break;
				default:
					break;
			}
		}
		
		private function clear_clickHandler(evt:MouseEvent):void{
			productList.removeAllChildren();
			productList.items=[];
			var items:Array = productList.items;
			total = 0; 
			numProducts = 0;
			totalWeight=0;
			for (var i:int=0; i < items.length; i++)
			{
				var product:Product = items[i].product;
				total += product._qty * Number(product.price);
				totalWeight += product._qty * Number(product.weight);
				numProducts += product._qty;
			}
			ArrayCollection(mainApp(parent).cartList).removeAll();
			mainApp(parent).shop_clickHandler(null,2);
		
		}
		
		
		protected function vbox1_mouseOutHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			//				PopUpManager.removePopUp(this);
			//				this.parentDocument.shop_clickHandler(null,0);
		}
		
		private var cf:CurrencyFormatter;
		private var kg:CurrencyFormatter;
		private var line_id:Canvas;
		public var productList:ProductCompareList;
		private var numProducts_id:Label;
		private var totalWeight_id:Label;
		private var total_id:Label;
		public var commitOrder_id:Button;
		override protected function createChildren():void{
			super.createChildren();
			cf=new CurrencyFormatter();
			cf.precision=2;
			cf.currencySymbol="￥";
			kg=new CurrencyFormatter();
			cf.precision=2;
			cf.currencySymbol="";
			
			var bakbtn:Button=new Button();
			bakbtn.percentWidth=100;
			bakbtn.percentHeight=100;
			bakbtn.y=52;
			this.addChild(bakbtn);
			
			var vb:VBox=new VBox();
			vb.setStyle("verticalGap",0);
			vb.horizontalScrollPolicy="off";
			vb.verticalScrollPolicy="off";
			vb.setStyle("horizontalAlign","right");
			
			var hb:HBox=new HBox();
			hb.percentWidth=100;
			hb.height=52;
			var sp:Spacer=new Spacer();
//			sp.percentWidth=100;
//			hb.addChild(sp);
			line_id=new Canvas();
			line_id.horizontalScrollPolicy="off";
			line_id.verticalScrollPolicy="off";
			line_id.percentHeight=100;
			line_id.percentWidth=100
			hb.addChild(line_id);
		    vb.addChild(hb);
//			sp=new Spacer();
			sp.height=2;
			vb.addChild(sp);
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			hb.percentWidth=100;
			sp=new Spacer();
			sp.width=5;
			hb.addChild(sp);
			productList=new ProductCompareList();
			productList.horizontalScrollPolicy="off";
			productList.verticalScrollPolicy="off";
			productList.percentHeight=100;
			productList.percentWidth=100;
			productList.showQuantity=true;
			productList.addEventListener(ProductListEvent.ADD_PRODUCT,productListEventHandler);
			productList.addEventListener(ProductListEvent.DUPLICATE_PRODUCT,productListEventHandler);
			productList.addEventListener(ProductListEvent.PRODUCT_QTY_CHANGE,productListEventHandler);
			productList.addEventListener(ProductListEvent.REMOVE_PRODUCT,productListEventHandler);
			hb.addChild(productList);
			vb.addChild(hb);
			var btncan:Canvas=new Canvas();
			btncan.percentWidth=100;
			btncan.height=76;
		    commitOrder_id=new Button();
			commitOrder_id.label="提交";
			commitOrder_id.setStyle("skinClass", Class(skin.ShopCardBtn));
			commitOrder_id.buttonMode=true;
			commitOrder_id.useHandCursor=true;
			commitOrder_id.x=254;
			commitOrder_id.y=52;
			commitOrder_id.addEventListener(MouseEvent.CLICK,commit_clickHandler);
			btncan.addChild(commitOrder_id);
			numProducts_id=new Label();
//			BindingUtils.bindProperty(numProducts_id,"text",numProducts,numProducts);
			numProducts_id.x=19;
			numProducts_id.y=5;
			btncan.addChild(numProducts_id);
			totalWeight_id=new Label();
			totalWeight_id.x=168;
			totalWeight_id.y=5;
			btncan.addChild(totalWeight_id);
			total_id=new Label();
			total_id.x=82;
			total_id.y=28;
			btncan.addChild(total_id);
			var suerbtn:Button=new Button();
			suerbtn.x=170;
			suerbtn.y=52;
			suerbtn.label="清空";
			suerbtn.setStyle("skinClass", Class(skin.ShopCardBtn));
			suerbtn.buttonMode=true;
			suerbtn.useHandCursor=true;
			suerbtn.addEventListener(MouseEvent.CLICK,clear_clickHandler);
			btncan.addChild(suerbtn);
			vb.addChild(btncan);
			
			this.addChild(vb);
			drawline();
		}
		
	}
}