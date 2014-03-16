
/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.common
{
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	
	import spark.effects.Move3D;
     
	public class LoaderProgressBar extends Canvas
	{
		private var mv:Move3D=new Move3D();
		public function LoaderProgressBar()
		{
			super();
			this.width=150;
			this.height=150;
			this.addEventListener(FlexEvent.CREATION_COMPLETE,completeHandler);
		}
		private function effectEndHandler(evt:EffectEvent):void{
			mv.play();
		}
		private function completeHandler(evt:FlexEvent):void{
			var cir:Circle=new Circle();
			cir.drawCircle(5,5,5);
			cir.x=10;
			cir.y=10;
			this.addChild(cir);
			mv.xTo=50;
			mv.yTo=50;
			mv.zTo=50;
			mv.target=cir;
			mv.addEventListener(EffectEvent.EFFECT_END,effectEndHandler);
			mv.play();
			
		}
	}
}