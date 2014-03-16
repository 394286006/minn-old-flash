package mvc.view.front.product.component
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flexmdi.events.MinnMessageEvent;
	
	import minn.common.DrawLine;
	
	import mx.containers.Canvas;
	import mx.containers.Panel;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	
	import skin.ButtonSkin;
	
	import spark.components.Button;

	public class SearchProductPanel extends Panel
	{
		private var pricearr:Array=new Array();
		public function SearchProductPanel()
		{
			super();
			width=635;
			height=85;
			this.layout="absolute";
			this.setStyle("fontSize",13);
			this.setStyle("headerHeight",5);
			this.verticalScrollPolicy="off";
			this.horizontalScrollPolicy="off";
//			this.setStyle("backgroundAlpha","1");
//			this.setStyle("backgroundColor","#ffffff");
			this.addEventListener(FlexEvent.CREATION_COMPLETE,canvas1_creationCompleteHandler);
		}
		protected function canvas1_creationCompleteHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
			pricearr.push({name:''});
			for(var i:int=1;i<100;i++){
				
				pricearr.push({name:i*100});
			}
			
			price_start_id.dataProvider=pricearr;
			price_end_id.dataProvider=pricearr;
			
//			var line:DrawLine=new DrawLine();
//			line.drawLine(100,-60,100,-50,0x635f5f,5);
//			this.addChild(line);
//			line=new DrawLine();
//			line.drawLine(500,-66,500,-56,0x635f5f,5);
//			this.addChild(line);
		
			
			
			var loader:URLLoader=new URLLoader();
			var request:URLRequest =  new URLRequest(Config.CATEGORY_MENU);
			loader.addEventListener(Event.COMPLETE,menuResult);
			loader.load(request);
		}
		/**
		 * 加载类别菜单
		 **/ 
		private function menuResult(evt:Event):void{
			var loader:URLLoader=URLLoader(evt.target);
			var menus:Array=JSON.decode(decodeURIComponent(loader.data));
			maxcategory_id.dataProvider=menus;
			maxcategory_id.selectedIndex=-1;
			category_id.dataProvider=menus[0].children;
			category_id.selectedIndex=-1;
		}
		private function closeSearchProductCard(evt:MouseEvent):void{
			mainApp(parent).showSearchProductPanelHandler();
		}
		
		private function queryProductHandler(evt:MouseEvent):void{
			var condition:Object=new Object();
			condition.type_name=name_id.text;
			condition.type_maxcategory_id='';
			condition.type_category_id='';
			if(maxcategory_id.selectedIndex>0){
				var maxcategory_id:String=maxcategory_id.selectedItem.id;
				condition.type_maxcategory_id=maxcategory_id;
			}
			//				else{
			//					condition.type_maxcategory_id='';
			//				}
			if(category_id.selectedIndex>0){
				var category_id:String=category_id.selectedItem.id;
				condition.type_category_id=category_id;
			}
			//				else{
			//					condition.type_category_id='';
			//				}
			condition.type_price_start=price_start_id.text;
			condition.type_price_end=price_end_id.text;
			this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"searchProduct",condition,true));
			
		}
		private var name_id:TextInput;
		private var maxcategory_id:ComboBox;
		private var category_id:ComboBox;
		private var price_start_id:ComboBox;
		private var price_end_id:ComboBox;
		
		override	protected function createChildren():void{
			super.createChildren();
	
		
            var lab:Label=new Label();
			lab.text="名称:";
			lab.x=10;
			lab.y=5;
			this.addChild(lab);
			name_id=new TextInput();
			name_id.width=160;
			name_id.x=40;
			name_id.y=5;
			this.addChild(name_id);
			
			lab=new Label();
			lab.text="大类:";
			lab.x=205;
			lab.y=5;
			this.addChild(lab);
			
			maxcategory_id=new ComboBox();
			maxcategory_id.width=150;
			maxcategory_id.labelField="name";
			maxcategory_id.addEventListener(ListEvent.CHANGE,function(evt:ListEvent):void{
				category_id.dataProvider=maxcategory_id.selectedItem.children
			});
			maxcategory_id.x=245;
			maxcategory_id.y=5
			this.addChild(maxcategory_id);
			lab=new Label();
			lab.text="小类别:";
			lab.x=400;
			lab.y=5;
			this.addChild(lab);
			
			category_id=new ComboBox();
			category_id.width=150;
			category_id.labelField="name";
			category_id.x=450;
			category_id.y=5;
			this.addChild(category_id);
			
			lab=new Label();
			lab.text="价格范围:";
			lab.x=10;
			lab.y=35;
			this.addChild(lab);
			
			price_start_id=new ComboBox();
			price_start_id.labelField="name";
			price_start_id.width=80;
			price_start_id.x=70;
			price_start_id.y=35;
			this.addChild(price_start_id);
			
			lab=new Label();
			lab.text="~~";
			lab.x=150;
			lab.y=35;
			this.addChild(lab);
			
			price_end_id=new ComboBox();
			price_end_id.labelField="name";
			price_end_id.width=80;
			price_end_id.x=176;
			price_end_id.y=35;
			this.addChild(price_end_id);
			
			var btn:Button=new Button();
			btn.label="查找";
			btn.setStyle("skinClass",skin.ButtonSkin);
			btn.buttonMode=true;
			btn.useHandCursor=true;
			btn.addEventListener(MouseEvent.CLICK,queryProductHandler);
			btn.x=280;
			btn.y=35;
			this.addChild(btn);
			
			var closeui:UIComponent=new UIComponent();
			closeui.width=12;
			closeui.height=12;
			closeui.buttonMode=true;
			closeui.useHandCursor=true;
			closeui.graphics.lineStyle(3, 0xAF0000);
			closeui.graphics.moveTo(590,45);
			closeui.graphics.lineTo(602,55);
			closeui.graphics.moveTo(590,55);
			closeui.graphics.lineTo(602,45);
			
			closeui.addEventListener(MouseEvent.CLICK,closeSearchProductCard);
			this.addChild(closeui);
		}
	}
}