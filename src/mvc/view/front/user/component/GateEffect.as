package mvc.view.front.user.component
{
	import com.adobe.ac.mxeffects.Distortion;
	import com.adobe.ac.mxeffects.DistortionConstants;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;

	public class GateEffect
	{
		private var leftDistort : Distortion;
		private var rightDistort : Distortion;
		private var percentage:Number=0;
		public function GateEffect(target:*)
		{
			initGateDistortion(target.parentDocument);
			var timer:Timer=new Timer(15,25);
			timer.addEventListener(TimerEvent.TIMER,openGate);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,function():void{
				target.dispatchEvent(new Event(Event.CLOSE,true));
				leftDistort=null;
				rightDistort=null;
				percentage=null;
				target=null;
				timer=null;
			});
			timer.start();
		}
		
		
		private function initGateDistortion(target:*) : void
		{
//			var direction : String = String( directionGroup.selectedValue );
			
			var leftRect:Rectangle;
			var rightRect : Rectangle;
//			if( direction == DistortionConstants.LEFT || direction == DistortionConstants.RIGHT )
//			{
				leftRect = new Rectangle( 0, 0 );
				leftRect.width = target.width / 2;
				leftRect.height = target.height;
				rightRect = new Rectangle( leftRect.width, 0 );
				rightRect.width = leftRect.width;
				rightRect.height = leftRect.height;							
//			}
//			else if( direction == DistortionConstants.TOP || direction == DistortionConstants.BOTTOM )
//			{
//				leftRect = new Rectangle( 0, 0 );
//				leftRect.width = target.width;
//				leftRect.height = target.height / 2;
//				rightRect = new Rectangle( 0, leftRect.height );
//				rightRect.width = leftRect.width;
//				rightRect.height = leftRect.height;								
//			}
			leftDistort = new Distortion( target, leftRect );
			leftDistort.buildMode = DistortionConstants.POPUP;
//			leftDistort.smooth = speedModeRadioButton.selected;
			rightDistort = new Distortion( target, rightRect );
			rightDistort.buildMode = DistortionConstants.POPUP;
//			rightDistort.smooth = speedModeRadioButton.selected;
		}
		
		public function openGate(evt:TimerEvent) : void
		{				
//			var direction : String = String( directionGroup.selectedValue );
//			
//			if( lastDirection != direction )
//			{
//				destroyGateDistortion();
//				getGateDistortion();	
//				lastDirection = direction;		
//			}
//			
//			var percentage : Number = openGateSlider.value;
			percentage+=4;
//			for(var percentage:int=5;percentage<100;percentage+=5){
			leftDistort.openDoor( percentage, DistortionConstants.LEFT, Number( 20 ) );
			rightDistort.openDoor( percentage, 
				rightDistort.reverseDirection( DistortionConstants.LEFT ), 
				Number( 20 ) );
//		}
		
		}
	}
}