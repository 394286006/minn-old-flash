package mvc.view.front.product.component
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import minn.common.MenuLabel;
	import minn.common.PageToolBar;
	import minn.proxy.WindowProxy;
	
	import mx.containers.HBox;
	import mx.controls.Spacer;
	import mx.controls.VRule;
	
	import spark.components.Label;
	
	public class ProductTitleBar extends HBox
	{
		
		public var pagePar:PageToolBar=null;
		private var sclabel:Label=null;
		public function ProductTitleBar()
		{
			super();
			this.setStyle("verticalAlign","middle");
			this.setStyle("horizontalScrollPolicy","off");
			this.setStyle("paddingTop",0);
		}
		public function set cartCount(cc:int):void{
			sclabel.text="购物车 ("+cc+"件)";
		}
		override protected function createChildren():void{
			super.createChildren();
			var sp:Spacer=new Spacer();
			sp.percentWidth=100;
			this.addChild(sp);
			pagePar=new PageToolBar();
//			pagePar.pageSize=2;
			this.addChild(pagePar);
			var vr:VRule=new VRule();
			vr.alpha=0.75;
			vr.height=this.height*0.75;
			this.addChild(vr);
//			var label:MenuLabel=new MenuLabel();
//			label.text="返回搜索";
//			label.addEventListener(MouseEvent.CLICK,function():void{dispatchEvent(new Event('hideProductCart',true))});
//			this.addChild(label);
		    vr=new VRule();
			vr.alpha=0.75;
			vr.height=this.height*0.75;
			this.addChild(vr);
//			label=new Label();
//			label.text="我的订单";
//			label.addEventListener(MouseEvent.CLICK,function():void{WindowProxy.getInstance().getPopWinExplorer("mvc/view/front/order/component/show/ShowOrderPanel.swf",null,null,50,280)});
//			this.addChild(label);
//			vr=new VRule();
//			vr.alpha=0.75;
//			vr.height=this.height*0.75;
//			this.addChild(vr);
//			sclabel=new Label();
//			sclabel.text="购物车 (0件)";
//			sclabel.addEventListener(MouseEvent.CLICK,function():void{dispatchEvent(new Event('showProductCart',true))});
//			this.addChild(sclabel);
		}
	}
}