/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.user.component
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import flexmdi.containers.ToolTipWin;
	
	import minn.common.Entrypt;
	import minn.proxy.WindowProxy;
	
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.Spacer;
	
	public class LoginOrRegister extends HBox
	{
		private var lbtn:Button;
		private var ebtn:Button;
		public function LoginOrRegister()
		{
			super();
			this.setStyle("horizontalGap",2);
			this.setStyle("paddingTop",8);
			this.setStyle("verticalScrollPolicy","off");
			this.setStyle("horizontalScrollPolicy","off");
		}
		
		override  protected function createChildren():void
		{
			
			super.createChildren();
			var sp:Spacer=new Spacer();
			sp.width=0;
			this.addChild(sp);
			lbtn=new Button();
			lbtn.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
				login_or_register_clickHandler(evt,'default')
			});
			lbtn.label="登陆";
			lbtn.setStyle("styleName","titlebtn");
			lbtn.buttonMode=true;
			lbtn.useHandCursor=true;
			new ToolTipWin(lbtn,lbtn.label);
			this.addChild(lbtn);
			ebtn=new Button();
			ebtn.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
				login_or_register_clickHandler(evt,'Register')
			});
			ebtn.setStyle("styleName","titlebtn");
			ebtn.buttonMode=true;
			ebtn.useHandCursor=true;
			ebtn.label="注册";
			new ToolTipWin(ebtn,ebtn.label);
			this.addChild(ebtn);
		}
		
		protected function login_or_register_clickHandler(event:MouseEvent,type:String):void
		{
//			Button(event.target).enabled=false;
			lbtn.enabled=false;
			ebtn.enabled=false;
			Entrypt.loadswfObject("mvc/view/front/user/component/LoginOrRegisterPanel"+Config.SUBFFIX,function(evt:Event):void{
				loadswfCompleteHandler(evt,type)
			},this.parentApplication as DisplayObject);
//			WindowProxy.getInstance().getPopWin("mvc/view/front/user/component/LoginOrRegisterPanel.swf",this,{type:type},100,460);
			
		}
		private function loadswfCompleteHandler(evt:Event,type:String):void{
			if(Config.SUBFFIX==Config.FLAG)
				WindowProxy.getInstance().getPopWin("mvc/view/front/user/component/LoginOrRegisterPanel.swf",evt.target.data as ByteArray,this,{type:type},100,460);
				else
			WindowProxy.getInstance().getPopWin("mvc/view/front/user/component/LoginOrRegisterPanel.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY),this,{type:type},100,460);
//			WindowProxy.getInstance().getPopWin("LoginOrRegisterPanel.swf",evt.target.data as ByteArray,this,{type:type},100,460);
			lbtn.enabled=true;
			ebtn.enabled=true;
		}
	}
}