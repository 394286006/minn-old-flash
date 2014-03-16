/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.order.component.commit
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import flexmdi.events.MinnMessageEventManager;
	
	import minn.common.DrawLine;
	import minn.common.Triangle;
	
	import mvc.model.merchandise.vo.Product;
	import mvc.view.front.product.component.ProductItem;
	import mvc.view.front.product.event.ProductListEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.controls.VRule;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.ClassFactory;
	import mx.events.FlexEvent;
	import mx.formatters.CurrencyFormatter;
	
	import skin.ButtonSkin;
	import skin.ShopCardBtn;
	
	import spark.components.Button;
	
	public class OrderProductConfig extends VBox
	{
		public var closeui_length:Number=60;
		public function OrderProductConfig()
		{
			super();
			this.setStyle("verticalGap",2);
			this.horizontalScrollPolicy="off";
			this.verticalScrollPolicy="off";
//			this.setStyle("layout","absolute");
//			this.setStyle("fontSize","13");
//			this.setStyle("fontSize","13");
//			width=600;
//			height=450;
			this.addEventListener(FlexEvent.UPDATE_COMPLETE,canvas1_updateCompleteHandler);
			this.addEventListener(FlexEvent.CREATION_COMPLETE,vbox1_creationCompleteHandler);
		}
		[Bindable]
		private var _products:ArrayCollection=null;
		[Bindable]
		public var totalmoney:Number=0;
		[Bindable]
		public var numProducts:int=0;
		[Bindable]
		public var totalWeight:Number=0;
		
		[Bindable]
		public function set products(p:ArrayCollection):void{
			_products=p;
//			product_id.addChild(pi);
//			Alert.show(product_id.toString());
			product_id.removeAllChildren();
			for(var i:int=0;i<p.length;i++){
				var spi:SpItem=new SpItem();
				product_id.addChild(spi);
				var pro:Product=p.getItemAt(i) as Product
				spi.product=pro;
			
			}
			
//			Alert.show("dfsd");
//			reCount("showproducts");
		}
		
		public function OrderChangeProdct(p:Product):void{
			Alert.show("change");
			_products.removeAll();
			var spitems:Array=product_id.getChildren();
			for(var i:int=0;i<spitems.length;i++){
				var spi:SpItem=spitems[i];
				var pro:Product=spi.product;
				if(pro.id==p.id){
					pro=p;
					spi.product=p;
//					break;
				}
				_products.addItem(pro);
			}
		
		}
		
		
		public function removeSpItem(sp:SpItem):void{
			del_clickHandler(null,sp.product)
			product_id.removeChild(sp);
//			if(product_id.getChildren().length==0){
//				CommitOrderPanel(parent).closeThis();
//			}
		}
		
		public function get products():ArrayCollection{
			return _products;
		}
		
		public function del_clickHandler(event:MouseEvent,d:Object):void{
			
			var evt:ProductListEvent=new ProductListEvent(ProductListEvent.PRODUCT_DEL_BY_ORDER,true);
			evt.product=d as Product;
			//				MinnMessageEventManager.getInstance().dispatchEvent(evt);
			this.dispatchEvent(evt);
			_products.removeItemAt(_products.getItemIndex(d));
			reCount("delete");
			
		}
		
		public function reCount(method:String):void{
			totalmoney=0;
			numProducts=0;
			totalWeight=0;
			for (var i:int=0; i < _products.length; i++)
			{
				var product:Product =_products.getItemAt(i) as Product;
				totalmoney += product._qty * Number(product.price);
				totalWeight+=product._qty*Number(product.weight);
				numProducts += product._qty;
			}
			//				.cartCount=numProducts;
			zjs.text="总件数:"+numProducts;
			zzl.text="总重量:"+kg.format(totalWeight)+"kg";
			zje.text="总金额(人民币):"+cf.format(totalmoney);
//			Alert.show(parent.toString());
			if(method!="orderdetail")
			mainApp(parent.parent).cartCount=numProducts;
			
		}
		
		
		protected function commit_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			CommitOrderPanel(parent).commit_clickHandler();
		}
		
		
		protected function vbox1_creationCompleteHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
			
			var dl:DrawLine=new DrawLine();
			dl.draw2Line(10,400,280,400);
			addChild(dl);
			
			var tri:Triangle=new Triangle();
			var v:Vector.<Number>=new Vector.<Number>();
			v.push(180, 30);
			v.push(15, 200);
			v.push(250, 400);
			tri.drawTriangle(v,0xc2be9e);
			this.addElement(tri);
			this.setElementIndex(tri,0);
			
			var lab:Label=new Label();
			lab.setStyle("paddingLeft",60);
			lab.text="订单确认列表";
			lab.setStyle("fontSize",16);
			this.addChild(lab);
			product_id=new VBox();
			product_id.percentWidth=100;
			product_id.percentHeight=100;
			var hb:HBox=new HBox();
			hb.setStyle("color",0xffffff);
			hb.setStyle("fontSize",14);
			hb.setStyle("horizontalGap",2);
			hb.setStyle("borderVisible",true);
			hb.setStyle("borderAlpha",1);
			hb.setStyle("backgroundColor",0x501b09);
			hb.setStyle("dropShadowVisible",true);
//			hb.setStyle("","");
			hb.horizontalScrollPolicy="off";
			hb.verticalScrollPolicy="off";
			hb.width=285;
            var title_id:Label=new Label();
			title_id.width=hb.width-closeui_length;
			title_id.setStyle("textAlign","center");
			title_id.text="商品名称";
			hb.addChild(title_id);
			var vr:VRule=new VRule();
			vr.height=21;
			hb.addChild(vr);
			var operator_id:Label=new Label();
			operator_id.width=closeui_length;
			operator_id.setStyle("textAlign","center");
			operator_id.text="操作    ";
			hb.addChild(operator_id);
			this.addChild(hb);
			product_id.setStyle("verticalGap",1);
			this.addChild(product_id);
//			product_id=new DataGrid();
//			product_id.height=300;
//			product_id.width=220;
//			product_id.sortableColumns=false;
//			product_id.setStyle("paddingRight",10);
//			product_id.resizableColumns=false;
//			var columns:Array=new Array();
//			var adc:DataGridColumn=new DataGridColumn();
//			adc.headerText="商品名称";
//			adc.dataField="name";
//			adc.width=160;
//			columns.push(adc);
//			operation_id=new DataGridColumn();
//			operation_id.headerText="操作";
//			operation_id.width=45;
//			var inlab:Label=new Label();
//			inlab.height=12;
//			inlab.width=12;
//			inlab.useHandCursor=true;
//			inlab.buttonMode=true;
//			var g:Graphics=inlab.graphics;
//			g.lineStyle(3, 0xAF0000);
//			g.moveTo(10,5);
//			g.lineTo(22,15);
//			g.moveTo(10,20);
//			g.lineTo(18,2);
//			inlab.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
//				del_clickHandler(evt,data);
//			});
//			operation_id.itemRenderer=new ClassFactory(inlab as Class);
//
//			columns.push(operation_id);
//			product_id.columns=columns;
//			
//			this.addChild(product_id);
			cf=new CurrencyFormatter();
			cf.currencySymbol="￥";
			cf.precision="2";
			
			kg=new CurrencyFormatter();
			kg.currencySymbol="";
			kg.precision="2";
			
			hb=new HBox();
			zjs=new Label();
			zjs.text="总件数:{numProducts}";
			hb.addChild(zjs);
			zzl=new Label();
			zzl.text="总重量:{kg.format(totalWeight)}kg";
			hb.addChild(zzl);
			this.addChild(hb);
			zje=new Label();
			zje.text="总金额(人民币):{cf.format(totalmoney)}";
			this.addChild(zje);
			
			hb=new HBox();
			hb.width=210;
			var sp:Spacer=new Spacer();
			sp.percentWidth=100;
			hb.addChild(sp);
			ordercommit_id=new Button();
			ordercommit_id.label="提交订单";
			ordercommit_id.useHandCursor=true;
			ordercommit_id.setStyle("skinClass",skin.ShopCardBtn);
			ordercommit_id.buttonMode=true;
			ordercommit_id.addEventListener(MouseEvent.CLICK,commit_clickHandler);
			hb.addChild(ordercommit_id);
			this.addChild(hb);
			sp=new Spacer();
			sp.height=20;
			this.addChild(sp);
		}
		
		
		protected function canvas1_updateCompleteHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
			//				if(parentDocument!=null&&this.parentDocument.method=="showDetail"){
			//					operation_id.visible=false;
			//					ordercommit_id.visible=false;
			//				}else{
			//					operation_id.visible=true;
			//					ordercommit_id.visible=true;
			//				}
		}
		public var product_id:VBox;
//		public var product_id:DataGrid;
		public var operation_id:DataGridColumn;
		private var cf:CurrencyFormatter;
		private var kg:CurrencyFormatter;
		private var zjs:Label;
		private var zzl:Label;
		private var zje:Label;
		public var ordercommit_id:Button;
		override protected function createChildren():void{
			super.createChildren();
			
		}
	}
}