/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.order.component.show
{
	import flash.events.Event;
	
	import flexmdi.containers.PopWinExplorer;
	import flexmdi.events.MinnMessageEventManager;
	import flexmdi.events.winresize.WinResizeProxyEvent;
	
	import minn.common.IFrame2;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	
	import spark.effects.Move;
	
	public class AlipayFrame2 extends PopWinExplorer
	{
		private var ifr:IFrame2=new IFrame2();
		private var mv:Move=new Move();
		private var alipayurl:String='';
		override public function AlipayFrame2()
		{
			super();
			this.title="支付操作" ;
			this.showMaxBtn=false;
			this.showMinBtn=false;
			this.showWeb=true;
//			this.height=400;
//			this.width=700;
			ifr.horizontalScrollPolicy="off";
			ifr.verticalScrollPolicy="off";
			ifr.percentHeight=100;
			ifr.percentWidth=100;
			this.addChild(ifr);
			this.addEventListener(FlexEvent.CREATION_COMPLETE,completeHandler);
//			this.addEventListener(FlexEvent.UPDATE_COMPLETE,function():void{
//		
//			});
			MinnMessageEventManager.getInstance().addEventListener(WinResizeProxyEvent.WIN_WEB_REFRESH,webHandler);
		  
		}
		
		
		
		private function completeHandler(evt:FlexEvent):void{
		
		
			this.width=FlexGlobals.topLevelApplication.screen.width-20;
			this.height=FlexGlobals.topLevelApplication.screen.height-20;
			mv.xTo=10;
			mv.yTo=3;
			mv.target=this;
			mv.play();
//			ifr.width=this.width;
//			ifr.height=this.height;
			ifr.source=alipayurl;
			ifr.visible=true;
		}
		private function webHandler(e:WinResizeProxyEvent):void{
//			Alert.show(alipayurl);
				ifr.source=alipayurl;
				ifr.visible=true;
		}
		public function messageHandler(url:String):void{
		    alipayurl=url;
//			ifr.source=alipayurl;
////			Alert.show(alipayurl);
//			
//			ifr.visible=true;
		}
	}
}