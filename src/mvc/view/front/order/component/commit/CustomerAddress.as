/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.order.component.commit
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import minn.common.DrawLine;
	import minn.common.Triangle;
	
	import mvc.model.order.vo.OrderAddress;
	
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.controls.TextInput;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	
	public class CustomerAddress extends VBox
	{
		private var _orderaddress:OrderAddress=null;
		
		private var ways:Array=[{label:"快递方式",data:2},{label:"客户上门自提",data:0}];
		//			private var cir:Circle=new Circle();
		private var iscomplete:Boolean=false;
		public function CustomerAddress()
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,vbox1_creationCompleteHandler);
		}
		
		protected function vbox1_creationCompleteHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
			var loader:URLLoader=new URLLoader();
			var request:URLRequest =  new URLRequest(Config.AREA_MENU);
			loader.addEventListener(Event.COMPLETE,menuResult);
			loader.load(request);
			
			var dl:DrawLine=new DrawLine();
			dl.draw2Line(10,400,280,400);
			addChild(dl);
			
			//				cir.drawCircle(close_id.x+16,close_id.y+15,15,0x0a10f2,2);
			//				cir.alpha=0.4;
			//				addChild(cir);
			//				cir.visible=false;
			
			
			var tri:Triangle=new Triangle();
			var v:Vector.<Number>=new Vector.<Number>();
			v.push(200, 20);
			v.push(20, 200);
			v.push(40, 380);
			tri.drawTriangle(v,0xc2be9e);
			this.addElement(tri);
			this.setElementIndex(tri,0);
			
			//				iscomplete=true;
			
			//				if(_orderaddress!=null){
			//					receiveName_id.text=_orderaddress.receiveName;
			//					address2_id.text=_orderaddress.address;
			//					code_id.text=_orderaddress.code;
			//					email_id.text=_orderaddress.email;
			//					phone_id.text=_orderaddress.phone;
			//				}
			
			getway_id.dataProvider=ways;
		}
		/**
		 * 加载类别菜单
		 **/ 
		private var menus:Array=[];
		private function menuResult(evt:Event):void{
			var loader:URLLoader=URLLoader(evt.target);
			menus=JSON.decode(decodeURIComponent(loader.data));
			province_id.dataProvider=menus;
			//				menus.filter(returnFilterArr);
			province_id.selectedIndex=-1;
			//				city_id.dataProvider=province_id.selectedItem.children;
			//				city_id.selectedIndex=0;
			//				town_id.dataProvider=city_id.selectedItem.children;
		}
		
		
		public function set orderAddress(obj:OrderAddress):void{
			this._orderaddress=obj;
			if(obj!=null){
				receiveName_id.text=_orderaddress.receiveName;
				address2_id.text=_orderaddress.address;
				code_id.text=_orderaddress.code;
				email_id.text=_orderaddress.email;
				phone_id.text=_orderaddress.phone;
			}else{
				receiveName_id.text='';
				address2_id.text='';
				code_id.text='';
				email_id.text='';
				phone_id.text='';
			}
			
		}
		
		public function get orderAddress():OrderAddress{
			if(_orderaddress==null)
				_orderaddress=new OrderAddress();
			
			_orderaddress.address=address1_id.text+address2_id.text;
			_orderaddress.code=code_id.text;
			_orderaddress.email=email_id.text;
			_orderaddress.phone=phone_id.text;
			_orderaddress.receiveName=receiveName_id.text;
			return _orderaddress;
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
		
		
		protected function province_id_changeHandler(evt:ListEvent):void
		{
			// TODO Auto-generated method stub
			if(menus.length>0){
				//				var arr:Array=menus.filter(returnFilterArr);
				//				province_id.dataProvider=arr;
				if(province_id.selectedItem){
					city_id.dataProvider=province_id.selectedItem.children;
					city_id.selectedIndex=0;}
				if(city_id.selectedItem)
					town_id.dataProvider=city_id.selectedItem.children;
			}
			else{
				Alert.show("正在加载数据!","提示");
			}
			
		}
		private function returnFilterArr(element:*, ind:int, arr:Array):Boolean {
			return true;
			//				return (String(element.name).indexOf(province_id.text)!=-1);
		}
		public var receiveName_id:TextInput;
		public var province_id:ComboBox;
		public var city_id:ComboBox;
		public var town_id:ComboBox;
		public var address1_id:Label;
		public var address2_id:TextInput;
		public var phone_id:TextInput;
		public var email_id:TextInput;
		public var code_id:TextInput;
		public var getway_id:ComboBox;
		override protected function createChildren():void{
			super.createChildren();
			var lab:Label=new Label();
			lab.text="收货人信息";
			lab.setStyle("paddingLeft","80");
			lab.setStyle("fontSize","16");
			this.addChild(lab);
			
			var hb:HBox=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="收  货 人:";
			hb.addChild(lab);
			receiveName_id=new TextInput();
			receiveName_id.width=175;
			receiveName_id.toolTip="收货人的名字";
			hb.addChild(receiveName_id);
			this.addChild(hb);
			
			 hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="省      份:";
			hb.addChild(lab);
			province_id=new ComboBox();
			province_id.width=172;
			province_id.styleName="bookcomBox";
			province_id.labelField="name";
			province_id.editable=false;
			province_id.enabled=true;
			province_id.addEventListener(ListEvent.CHANGE,  province_id_changeHandler);
			hb.addChild(province_id);
			this.addChild(hb);
			
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="城      市:";
			hb.addChild(lab);
			city_id=new ComboBox();
			city_id.width=172;
			city_id.editable=false;
			city_id.enabled=true;
			city_id.styleName="bookcomBox";
			city_id.labelField="name";
			city_id.addEventListener(ListEvent.CHANGE,  function():void{
				town_id.dataProvider=city_id.selectedItem.children;
				town_id.selectedIndex=-1;
				address1_id.text=province_id.selectedItem.name+city_id.selectedItem.name;
			});
			hb.addChild(city_id);
			this.addChild(hb);
			
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="镇      区:";
			hb.addChild(lab);
			town_id=new ComboBox();
			town_id.width=172;
			town_id.styleName="bookcomBox";
			town_id.labelField="name";
			town_id.addEventListener(ListEvent.CHANGE,  function():void{
				address1_id.text=province_id.selectedItem.name+city_id.selectedItem.name+town_id.selectedItem.name;
			});
			hb.addChild(town_id);
			this.addChild(hb);
			
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="地      址:";
			hb.addChild(lab);
			address1_id=new Label();
			hb.addChild(address1_id);
			this.addChild(hb);
			address2_id=new TextInput();
			address2_id.width=238;
			address2_id.toolTip="详细地址";
			this.addChild(address2_id);
			
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="联系电话:";
			hb.addChild(lab);
			phone_id=new TextInput();
			phone_id.width=175;
			hb.addChild(phone_id);
			this.addChild(hb);
			
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="电子邮件:";
			hb.addChild(lab);
			email_id=new TextInput();
			email_id.width=175;
			hb.addChild(email_id);
			this.addChild(hb);
			
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="邮政编码:";
			hb.addChild(lab);
			code_id=new TextInput();
			code_id.width=175;
			hb.addChild(code_id);
			this.addChild(hb);
			
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			lab=new Label();
			lab.text="配送方式:";
			hb.addChild(lab);
			getway_id=new ComboBox();
			getway_id.styleName="bookcomBox";
			getway_id.width=175;
			hb.addChild(getway_id);
			this.addChild(hb);
		}
	}

}