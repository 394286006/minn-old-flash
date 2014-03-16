/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.common
{
	import mx.core.UIComponent;
	
	public class Rect extends UIComponent
	{
		private var size:uint         = 80;
		private var bgColor:uint      = 0x2ae34a;
		private var borderColor:uint  = 0x666666;
		private var borderSize:uint   = 0;
		private var cornerRadius:uint = 9;
		private var gutter:uint       = 5;
		
		public function Rect()
		{
			super();
		}
		
		public function drawRect():void {
			graphics.beginFill(bgColor);
			graphics.lineStyle(1, borderColor);
			graphics.drawRoundRect(0, 0, 8, 8, 0);
			graphics.endFill();
		}
		

	}
}