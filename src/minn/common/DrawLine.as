/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.common
{
	import mx.core.UIComponent;
	
	public class DrawLine extends UIComponent
	{
		public function DrawLine()
		{
			super();
		}
		public var startX:Number;
		public var startY:Number;
		public var endX:Number;
		public var endY:Number;
		public function draw2Line(startx:Number,starty:Number,endx:Number,endy:Number,_linecolor:uint=0x000000):void{
			
			graphics.lineStyle(1,_linecolor);
			graphics.moveTo(startx,starty);
			graphics.lineTo(endx,endy);
			graphics.moveTo(startx,endy+10);
			graphics.lineTo(endx,endy+10);
		}
		public function drawLine(startx:Number,starty:Number,endx:Number,endy:Number,linecolor:uint=0x666666):void{
			graphics.lineStyle(1, linecolor);
			graphics.moveTo(startx,starty);
			graphics.lineTo(endx,endy);
		}
	}
}