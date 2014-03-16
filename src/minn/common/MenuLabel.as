
/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.common
{
	import flash.events.MouseEvent;
	
	import spark.components.Label;
	
	public class MenuLabel extends Label 
	{
		[Bindable]
		public var overColor:String="#e6de31";
		[Bindable]
		public var outColor:String="#575252";

		public function MenuLabel()
		{
			super();
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseChangeColorChange);
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseChangeColorChange);
			this.setStyle("color",outColor);
			this.buttonMode=true;
			this.useHandCursor=true;
		}
		
		private function mouseChangeColorChange(evt:MouseEvent):void{
			switch(evt.type){
				case MouseEvent.MOUSE_OVER:
					this.setStyle("color",overColor);
					break;
				case MouseEvent.MOUSE_OUT:
					this.setStyle("color",outColor);
					break;
			}
			
		}
	}
}