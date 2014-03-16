/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.user.component
{

	
	import flash.events.MouseEvent;
	
	import flexmdi.containers.ToolTipWin;
	import flexmdi.events.MinnMessageEvent;
	
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.Spacer;
	
	public class ExitOrModify extends HBox
	{
		public function ExitOrModify()
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
		var la:Button=new Button();
		la.setStyle("styleName","titlebtn");
		la.label="退出";
		la.addEventListener(MouseEvent.CLICK,exitLocal);
		la.buttonMode=true;
		la.useHandCursor=true;
		new ToolTipWin(la,la.label);
		this.addChild(la);
		la=new Button();
		la.setStyle("styleName","titlebtn");
		la.label="修改";
		la.addEventListener(MouseEvent.CLICK,modifyUser);
		la.buttonMode=true;
		la.useHandCursor=true;
		new ToolTipWin(la,la.label);
		this.addChild(la);
	}
	
	private function exitLocal(evt:MouseEvent):void{
		this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"exit"));
	}
	private function modifyUser(evt:MouseEvent):void{
		this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"modifyUser"));
	}
	}
}