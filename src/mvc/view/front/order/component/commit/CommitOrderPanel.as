/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.order.component.commit
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import flexmdi.events.MinnMessageEvent;
	
	import minn.common.Entrypt;
	import minn.message.Message;
	import minn.proxy.WindowProxy;
	import minn.util.MinnUtil;
	
	import mvc.controller.ControllerCommand;
	import mvc.controller.ControllerService;
	import mvc.model.merchandise.vo.Product;
	import mvc.model.order.OrderProxy;
	import mvc.model.order.vo.Order;
	import mvc.model.order.vo.OrderAddress;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Panel;
	import mx.controls.Alert;
	import mx.effects.Move;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.ListEvent;
	import mx.events.ValidationResultEvent;
	import mx.rpc.events.FaultEvent;
	import mx.validators.NumberValidator;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	public class CommitOrderPanel extends Panel
	{
		private var products:Array=null;
		private var orderAddress:OrderAddress=null;
		public var method:String="add";
		//			[Bindable]
		private var order:Order=null;
		private var modifyindex:int=-1;
		private var cop_mv:Move=new Move();
		private var validatorArray:Array;
		public function CommitOrderPanel()
		{
			super();
			width=880;
			height=440 ;
			y=50;
			x=-900;
			this.setStyle("fontSize",13);
			layout="horizontal";
			this.verticalScrollPolicy="off";
			this.horizontalScrollPolicy="off";
			this.addEventListener(FlexEvent.CREATION_COMPLETE,module1_creationCompleteHandler);
//			this.addEventListener(FlexMouseEvent.,function(){
//			  Alert.show('d');
//			});
			
		}
		
		public function closeThis(evt:Event=null):void{
			cop_mv.xTo=-920;
			cop_mv.play();
		}
		public function messageHandler(val:Object):void{
			order=null;
			address_id.orderAddress=null;
//			orderProductConfig_id.operation_id.visible=true;
			orderProductConfig_id.ordercommit_id.visible=true;
			productDetail_id.qtybtn.visible=true;
			if(productDetail_id.qtybtn!=null)
				productDetail_id.qtybtn.enabled=false;
			
			method=val.method;
			productDetail_id.method=method;
			if(val.hasOwnProperty('modifyindex'))
				modifyindex=val.modifyindex;
			if(val.method=="add"){
				products=val.item as Array;
				orderProductConfig_id.products=new ArrayCollection(products);
			}
			if(val.method=="modify"||val.method=="showDetail"||val.method=="orderdetail"){
//				if(val.hasOwnProperty("type")&&val.type=="showdetail"){
					//						orderProductConfig_id.ordercommit_id.visible=false;
//					orderProductConfig_id
//					orderProductConfig_id.operation_id.visible=false;
					orderProductConfig_id.ordercommit_id.label="修改订单";
//					orderProductConfig_id.ordercommit_id.visible=false;
//					productDetail_id.qtybtn.visible=false;
//				}
				//					Alert.show(val.item);
				order=val.item as Order;
				//					Alert.show(order+'');
				var address:OrderAddress=null;
				if(order._orderAddress is OrderAddress)
					address=order._orderAddress as OrderAddress;
				else{
					address=new OrderAddress();
					MinnUtil.propertyMap(order._orderAddress,address);
				}
				address_id.orderAddress=address;
				var md:Array=order._products as Array;
				var ac:ArrayCollection=new ArrayCollection();
				if(md.length>0){
					if(md[0] is Product)
					{
						products=md;
						ac.addAll(new ArrayCollection(md));
					}else{
						
						for(var i:int=0;i<md.length;i++){
							var v:Product=new Product();
							ac.addItem(v);
						}
						MinnUtil.copyProperty(ac,md);
						products=ac.toArray();
					}
				}
				orderProductConfig_id.products=ac;
			}
			orderProductConfig_id.reCount(method);
			showProductDetail(null,products[0] as Product);
			
			cop_mv.xTo=20;
			cop_mv.play();
			
		}
		
		protected function module1_creationCompleteHandler(event:FlexEvent=null):void
		{
			cop_mv.duration=2000;
			cop_mv.target=this;
			Alert.okLabel="确定";
		}
		protected function button1_clickHandler(event:MouseEvent=null):void
		{
			// TODO Auto-generated method stub
			this.dispatchEvent(new CloseEvent(CloseEvent.CLOSE,true));
		}
		
		
		private function pageChangeHandler():void{
			
			//				if(book_id.currentPageIndex==book_id.pageCount){
			//				}else{
			//				}
		}
		
		protected function label1_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//				book_id.currentPageIndex=2;
		}
		
		protected function orderProductConfig_id_creationCompleteHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
//			orderProductConfig_id.product_id.addEventListener(ListEvent.ITEM_CLICK,showProductDetail);
			
			
		}
		public function showProductDetail(evt:ListEvent,da:Product=null):void{
			//				Alert.show(evt.target.toString());
			var obj:Product=null;
			if(evt!=null){
				productDetail_id.qtybtn.enabled=true;
				obj=evt.target.selectedItem as Product;
			}else{
				obj=da;
			}
			productDetail_id.qtybtn.enabled=true;
			productDetail_id.product=obj;
		}
		
		private function alertClickHandler(event:CloseEvent):void {
			//				WindowProxy.getInstance().getPopWin("mvc/view/front/user/component/LoginOrRegisterPanel.swf",this,"default",100,460);
			//				Entrypt.loadswfObject("mvc/view/front/user/component/LoginOrRegisterPanel"+Config.SUBFFIX,loadswfCompleteHandler,this);
			//				this.parentDocument.popLoginWin({type:"login"});
			this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"openLoginWin",true));
			
		}
		private function loadswfCompleteHandler(evt:Event):void{
			//				mm.loadModule("2011010812342.swf",Entrypt.uncompress(evt.target.data as ByteArray,KEY));
			if(Config.SUBFFIX==Config.FLAG){
				WindowProxy.getInstance().getPopWin("mvc/view/front/user/component/LoginOrRegisterPanel.swf",evt.target.data as ByteArray,this,{type:"default"},100,460);
			}else
				WindowProxy.getInstance().getPopWin("mvc/view/front/user/component/LoginOrRegisterPanel.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY),this,{type:"default"},100,460);
			//             WindowProxy.getInstance().getPopWin("mvc/view/front/user/component/LoginOrRegisterPanel.swf",evt.target.data as ByteArray,this,{type:"default"},100,460);
		}
		
		public function commit_clickHandler():void{
			
			var validatorErrorArray:Array = Validator.validateAll(validatorArray); 
			var err:ValidationResultEvent; 
			var errorMessageArray:Array = []; 
			if(validatorErrorArray.length>0){
				for each (err in validatorErrorArray) { 
					errorMessageArray.push(err.message); 
				} 
				
				if(errorMessageArray.length >0){
					Alert.show(errorMessageArray.join("\n\n"), "请按照以下错误提示信息重新填写", Alert.OK);
					if(errorMessageArray.length>1){
						//							book_id.currentPageIndex=0;
					}
					return;
				}
			}
			
			if(parentApplication.user==null){
				Alert.show("你好,需要下订单,请先登录!","提示",Alert.OK,this,alertClickHandler);
				return;
			}
			
			if(orderProductConfig_id.product_id.getChildren().length==0){
				Alert.show("你好,订单列表中没有商品,如果是修改操作,请返回我的订单进行操作!","提示");
				return;
			}
			var proxy:OrderProxy=ControllerService.getInstance(ControllerCommand.ORDER_PROXY);
			if(method=="add"){
				//					orderProductConfig_id.ordercommit_id.enabled=false;
				order=new Order();
				order._sid=this.parentApplication.PRIVATEKEY;
				order._orderAddress=address_id.orderAddress;
				order._products=orderProductConfig_id.products.toArray();
				order.totalmoney=orderProductConfig_id.totalmoney;
				order.totalweight=orderProductConfig_id.totalWeight;
				order.totalqty=orderProductConfig_id.numProducts;
				order.getway=address_id.getway_id.selectedItem.data;
				order.flag=1;
				order.creator=parentApplication.user.id;
				order.out_trade_no=parentApplication.user.userName_en+MinnUtil.getCurentDateAndTime("YYYYMMDDHHNNSS");
				
				//				    Alert.show(parentApplication.user.userName_en+MinnUtil.getCurentDateAndTime("YYYYMMDDHHNNSS"));
				
				proxy.add(order,commitOrderResultHandler,commitFaultHandler);
			}else{
				//					curOrder.
				order._sid=this.parentApplication.PRIVATEKEY;
				order._orderAddress=address_id.orderAddress;
				//					Alert.show(address_id.orderAddress.receiveName);
				order._products=orderProductConfig_id.products.toArray();
				order.totalmoney=orderProductConfig_id.totalmoney;
				order.totalweight=orderProductConfig_id.totalWeight;
				order.totalqty=orderProductConfig_id.numProducts;
				order.getway=address_id.getway_id.selectedItem.data;
				proxy.modify(order,orderModifyResultHandler,orderModifyFaultResultHandler);
			}
		}
		
		private function orderModifyResultHandler(evt:Message):void{
			//				if(WindowProxy.getInstance().checkExistWindow("mvc/view/front/order/component/show/ShowOrderPanel.swf"))
			//				   Alert.show(order._orderAddress.id);
			//					loadssopwfCompleteHandler(null,{item:order,modifyindex:modifyindex});
			this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"modifyOrderPanel",{item:order,modifyindex:modifyindex},true));
			this.closeThis();
			//					else
			//				Entrypt.loadswfObject("mvc/view/front/order/component/show/ShowOrderPanel"+Config.SUBFFIX,function(evt:Event):void{
			//					loadssopwfCompleteHandler(evt,curOrder);
			//				});
		}
		private function orderModifyFaultResultHandler(evt:FaultEvent):void{
			//				Alert.show("请求的操作失败,请联系管理员!","提示");
		}
		private function commitOrderResultHandler(message:Message):void{
			
			//			   Alert.show(message.messageBody+'');
			//				Entrypt.loadswfObject("mvc/view/front/order/component/show/ShowOrderPanel"+Config.SUBFFIX,loadssopwfCompleteHandler,this);
			this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"orderShowPanel",null,true));
			this.closeThis();
		}
		
		private function commitFaultHandler(evt:Event):void{
			Alert.show("提交出现异常,请联系管理员!","提示");
			orderProductConfig_id.ordercommit_id.enabled=true;
		}
		private function loadssopwfCompleteHandler(evt:Event,d:Object=null):void{
			if(evt!=null){
				if(Config.SUBFFIX==Config.FLAG){
					WindowProxy.getInstance().getPopWinExplorer("ShowOrderPanel.swf",evt.target.data as ByteArray,this,d,50,280);
				}else
					WindowProxy.getInstance().getPopWinExplorer("ShowOrderPanel.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY),this,d,50,280);
				
			}else{
				WindowProxy.getInstance().getPopWinExplorer("ShowOrderPanel.swf",null,this,d,50,280);
			}
			button1_clickHandler();
			
		}
		private var address_id:CustomerAddress;
		public var orderProductConfig_id:OrderProductConfig;
		private var productDetail_id:CommitOrderProductDetail;
		
		override protected function createChildren():void{
			super.createChildren();
		
			address_id=new CustomerAddress();
			address_id.width=240;
//			address_id.height=300;
			address_id.verticalScrollPolicy="off";
			address_id.horizontalScrollPolicy="off";
			address_id.percentHeight=100;
			this.addChild(address_id);
			orderProductConfig_id=new OrderProductConfig();
			orderProductConfig_id.width=280;
			orderProductConfig_id.height=300;
			orderProductConfig_id.percentHeight=100;
			orderProductConfig_id.addEventListener(FlexEvent.CREATION_COMPLETE,orderProductConfig_id_creationCompleteHandler);
			this.addChild(orderProductConfig_id);
			productDetail_id=new CommitOrderProductDetail();
			productDetail_id.width=300;
			productDetail_id.percentHeight=100;
			this.addChild(productDetail_id);
			
			validatorArray=new Array();
			var sv:StringValidator=new StringValidator();
			sv.source=address_id.receiveName_id;
			sv.requiredFieldError="收货人不能为空！";
			sv.property="text";
			sv.required=true;
			validatorArray.push(sv);
			
			sv=new StringValidator();
			sv.source=address_id.address2_id;
			sv.requiredFieldError="详细地址不能不能为空！";
			sv.property="text";
			sv.required=true;
			validatorArray.push(sv);
			
			sv=new StringValidator();
			sv.source=address_id.phone_id;
			sv.requiredFieldError="联系电话不能为空！";
			sv.property="text";
			sv.required=true;
			validatorArray.push(sv);
			
			sv=new StringValidator();
			sv.source=address_id.email_id;
			sv.requiredFieldError="email邮件不能为空！";
			sv.property="text";
			sv.required=true;
			validatorArray.push(sv);
			
			sv=new StringValidator();
			sv.source=address_id.code_id;
			sv.requiredFieldError="编码不能为空！";
			sv.property="text";
			sv.required=true;
			validatorArray.push(sv);
			
			var nv:NumberValidator=new NumberValidator();
			nv.source=productDetail_id.qty_id;
		    nv.requiredFieldError="编码不能为空！";
			nv.property="text";
			nv.integerError="请输入整形!";
			nv.invalidCharError="请输入整形!";
			nv.invalidFormatCharsError="请输入整形!";
			nv.minValue="1" ;
			nv.domain="int";
			nv.trigger=productDetail_id.qtybtn;
			nv.triggerEvent="click";
			validatorArray.push(nv);
		}
	}
}