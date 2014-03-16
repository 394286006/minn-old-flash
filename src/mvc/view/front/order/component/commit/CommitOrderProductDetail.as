
/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.order.component.commit
{
	import com.hurlant.util.der.Integer;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flexmdi.events.MinnMessageEvent;
	import flexmdi.events.MinnMessageEventManager;
	
	import minn.common.Circle;
	import minn.common.DrawLine;
	import minn.common.Triangle;
	
	import mvc.model.merchandise.vo.Product;
	import mvc.view.front.product.event.ProductListEvent;
	
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.controls.Text;
	import mx.controls.TextInput;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.ValidationResultEvent;
	import mx.utils.StringUtil;
	import mx.validators.NumberValidator;
	import mx.validators.Validator;
	
	import skin.BookBtnSkin;
	import skin.ShopCardBtn;
	
	import spark.components.Button;

	public class CommitOrderProductDetail extends Canvas
	{
		[Bindable]
		private var _product:Product;
		
		public var method:String="";
		
		public function set product(p:Product):void{
			this._product=p;
			name_id.text=p.name;
			qty_id.text=p._qty.toString();
			upTime_id.text=p.upTime;
			downTime_id.text=p.downTime;
			desc_id.text=p.descript;
		}
		public function get product():Product{
			return this._product;
		}
		public function CommitOrderProductDetail()
		{
			super();
			this.horizontalScrollPolicy="off";
			this.verticalScrollPolicy="off";
			this.percentHeight=100;
			this.addEventListener(FlexEvent.CREATION_COMPLETE,completeHandler);
			this.addEventListener(FlexEvent.UPDATE_COMPLETE,canvas1_updateCompleteHandler);
		}
		private function completeHandler(evt:Event):void{
			
			var dl:DrawLine=new DrawLine();
			dl.draw2Line(10,400,280,400);
			addChild(dl);
			//				cir.drawCircle(close_id.x+16,close_id.y+15,15,0x0a10f2,2);
			//				addChild(cir);
			//				cir.alpha=0.4;
			//				cir.visible=false;
			
			var tri:Triangle=new Triangle();
			var v:Vector.<Number>=new Vector.<Number>();
			v.push(200, 20);
			v.push(250, 200);
			v.push(20, 410);
			tri.drawTriangle(v,0xc2be9e);
			this.addElement(tri);
			this.setElementIndex(tri,0);
		}
		
		protected function modify_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//				MinnMessageEventManager
		
			var validatorErrorArray:Array = Validator.validateAll(validatorArray); 
			var err:ValidationResultEvent; 
			var errorMessageArray:Array = []; 
			if(validatorErrorArray.length>0){
				for each (err in validatorErrorArray) { 
					errorMessageArray.push(err.message); 
				} 
				
				if(errorMessageArray.length >0){
					Alert.show(errorMessageArray.join("\n\n"), "请按照以下错误提示信息重新填写", Alert.OK);
					
					return;
				}
			}
		
			var evt:ProductListEvent=new ProductListEvent(ProductListEvent.PRODUCT_QTY_CHANGE_BY_ORDER,true);
			product._qty=int(qty_id.text);
			//				var evt:ProductListEvent = new ProductListEvent(ProductListEvent.PRODUCT_QTY_CHANGE,true);
			evt.product = product;
			
			//				dispatchEvent(evt);
			//				e.product=product;
//			Alert.show(this.parent.toString());
//			CommitOrderPanel(parent.parent).orderProductConfig_id.OrderChangeProdct(product);
	
			CommitOrderPanel(parent).orderProductConfig_id.reCount(method);
//							MinnMessageEventManager.getInstance().dispatchEvent(evt);
			if(method=="orderdetail") return;
			dispatchEvent(evt);
		}
		
		protected function close_id_mouseOverHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//				cir.visible=true;
		}
		
		
		protected function close_id_mouseOutHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//				cir.visible=false;
		}
		
		
		protected function numbervalidator1_invalidHandler(event:ValidationResultEvent):void
		{
			// TODO Auto-generated method stub
			//				Alert.show("请输入整型值!","提示");
		}
		
		
		protected function canvas1_updateCompleteHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
//		Alert.show(parent.toString());
			if(this.parent.parent!=null&&CommitOrderPanel(this.parent).method=="showDetail"){
				if(qtybtn!=null)
				qtybtn.visible=false;
				
			}else{
				if(qtybtn!=null)
				qtybtn.visible=true;
			}
		}
		private var validatorArray:Array;
		private var name_id:Label;
		public var qty_id:TextInput;
		public var qtybtn:Button;
		private var upTime_id:Label;
		private var downTime_id:Label;
		private var desc_id:Text;
		private var close_id:Button;
		override protected function createChildren():void{
			super.createChildren();
			var vb:VBox=new VBox();
			vb.setStyle("paddingLeft",25);
			vb.setStyle("verticalGap",3);
		    var lab:Label=new Label();
			lab.setStyle("paddingLeft",90);
			lab.setStyle("fontSize",16);
			vb.addChild(lab);
			var hb:HBox=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="名称:";
			hb.addChild(lab);
			name_id=new Label();
			name_id.text="{product.name}";
			hb.addChild(name_id);
			vb.addChild(hb);
			
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="购买件数:";
			hb.addChild(lab);
			qty_id=new TextInput();
			qty_id.width=40;
			qty_id.text="{product._qty}";
			hb.addChild(qty_id);
			lab=new Label();
			lab.text="件";
			hb.addChild(lab);
			qtybtn=new Button();
			qtybtn.styleName="bookbtn";
			qtybtn.enabled=false;
			qtybtn.label="修改";
			qtybtn.setStyle("skinClass",skin.ShopCardBtn);
			qtybtn.useHandCursor=true;
			qtybtn.buttonMode=true;
			qtybtn.addEventListener(MouseEvent.CLICK,modify_clickHandler);
			hb.addChild(qtybtn);
			vb.addChild(hb);
			
			 hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="上架时间:";
			hb.addChild(lab);
			upTime_id=new Label();
			upTime_id.text="{product.upTime}";
			hb.addChild(upTime_id);
			vb.addChild(hb);
			
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="下架时间";
			hb.addChild(lab);
			downTime_id=new Label();
			downTime_id.text="{product.downTime}";
			hb.addChild(upTime_id);
			vb.addChild(hb);
			lab=new Label();
			lab.text="简述";
			vb.addChild(lab);
			desc_id=new Text();
			desc_id.text="{product.descript}";
			vb.addChild(desc_id);
			var sp:Spacer=new Spacer();
			sp.height=20;
			vb.addChild(sp);
			this.addChild(vb);
			close_id=new Button();
			close_id.x=240;
			close_id.y=365;
			close_id.height=32;
			close_id.width=32;
			close_id.setStyle("skinClass",skin.BookBtnSkin);
			close_id.useHandCursor=true;
			close_id.buttonMode=true;
			close_id.alpha=0.9;
			close_id.addEventListener(MouseEvent.MOUSE_OVER,close_id_mouseOverHandler);
			close_id.addEventListener(MouseEvent.MOUSE_OUT,close_id_mouseOutHandler);
			close_id.addEventListener(MouseEvent.CLICK,CommitOrderPanel(parent).closeThis);	
			this.addChild(close_id);
			validatorArray=new Array();
			 var bv:NumberValidator=new NumberValidator();
			 bv.source=qty_id;
			 bv.property="text";
			 bv.integerError="请输入整形!";
			 bv.invalidCharError="请输入整形!";
			 bv.invalidFormatCharsError="请输入整形!";
			 bv.minValue=1;
			 bv.domain="int";
			 bv.trigger=qtybtn;
			 bv.triggerEvent="click";
		}
	}
}