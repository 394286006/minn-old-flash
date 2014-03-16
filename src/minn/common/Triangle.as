/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.common
{
	import mx.core.UIComponent;
	
	public class Triangle extends UIComponent
	{
		public function Triangle()
		{
			super();
		}
		
		public function drawTriangle(vertices:Vector.<Number>,_color:uint=0x000000,indices:Vector.<int>=null):void{
			
			graphics.lineStyle(1,_color);
			graphics.drawTriangles(vertices,indices);
			
		}
	}
}