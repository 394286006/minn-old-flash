/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.preloader
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Loader;
	import mx.containers.HBox;
	import mx.effects.Blur;
	
	public class LoaderLogo extends Loader
	{
		private var blr:Blur=new Blur();
		private var count:int=0;
//		private var hb:HBox=new HBox();
		public function LoaderLogo()
		{
//			super();
//			hb.setStyle("horizontalGap",12);
			for(var i:int=0;i<6;i++){
				var rc:Rect=new Rect();
				rc.drawRect();
				this.addChild(rc);
			}
			var timer:Timer=new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		
			blr.duration=400;
			blr.blurXTo=30;
			blr.blurYTo=30;
			blr.blurXFrom=0;
			blr.blurYFrom=0;
		}
		
		private function timerHandler(event:TimerEvent):void {
//			if(count==this.)
//				count=0;
			blr.targets=[];
			var rc:Rect=getChildAt(count) as Rect;
			blr.target=rc;
			blr.play(null,true);
			
			count++;
		}
	}
}