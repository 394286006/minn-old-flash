package minn.preloader
{
	import com.flashdynamix.motion.Tweensy;
	import com.flashdynamix.motion.TweensyGroup;
	import com.flashdynamix.motion.TweensyTimeline;
	import com.flashdynamix.motion.effects.PerlinDisplacementEffect;
	import com.flashdynamix.motion.effects.core.ColorEffect;
	import com.flashdynamix.motion.effects.core.FilterEffect;
	import com.flashdynamix.motion.layers.BitmapLayer;
	
	import fl.motion.easing.Linear;
	
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import flash.net.FileReferenceList;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import mx.controls.Alert;
	import mx.controls.ProgressBar;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;
	import mx.managers.BrowserManager;
	import mx.managers.PopUpManager;
	import mx.preloaders.DownloadProgressBar;
	import mx.preloaders.SparkDownloadProgressBar;
	
	public class PreLoaderbak1 extends SparkDownloadProgressBar
	{
		//显示进度的文字
		private var progressText:TextField;
		private var waitTxt:TextField;
		//进度条
		public var img:WelcomeProgressBar;
		//logo页面
		public var logo:WelcomeLogo;
//		public var llogo:LoaderLogo;
		private var _timer:Timer;
		
		private var _displayStartCount:uint = 0;
		
		private var _initProgressCount:uint = 0;
		
		private var _downloadComplete:Boolean = false;
		
		private var _showingDisplay:Boolean = false;
		
		private var rslBaseText:String = "Loading app: ";
		
		private var numberRslTotal:Number = 1;
		
		private var numberRslCurrent:Number = 1;
		private var tween:TweensyGroup;
		private var layer :BitmapLayer;
		private var holder :Sprite;
		[Embed(source="assets/alienRainFxBox.swf", symbol="Box")]
		private var Box:Class;
		[Embed(source="assets/longball.swf", symbol="canvas1")]
		private var Canvas1:Class;
		public function PreLoader()
		{
			super();
			//加入logo
			
			logo = new WelcomeLogo();
		   
			logo.addEventListener(Event.ADDED_TO_STAGE,logoHandler);
			this.addChild(logo);
						
//			
//			for(var i : int = 0;i < 20; i++) {
//				addBlob();
//			}
			
			progressText = new TextField();
			this.addChild(progressText);
			progressText.width=300;
			progressText.height=100;
//			llogo = new LoaderLogo();
//			llogo.x=(this.stageWidth-logo.width)/2+250;
//			llogo.y=(this.stageHeight-logo.height)/2;
//			this.addChild(llogo);			
//			加入进度条
			img = new WelcomeProgressBar();
			img.addEventListener(Event.ADDED_TO_STAGE,imgHandler);
//			img.x=150;
//			img.y=332;
//			this.preloader=img as Sprite;
			this.addChild(img);
			//加入进度文字
		
			waitTxt=new TextField();
			waitTxt.addEventListener(Event.ADDED_TO_STAGE,waitTxtHandler);
			waitTxt.width=60;
			waitTxt.height=60;
			
			this.addChild(waitTxt);
			

			
		}
		
		private function logoHandler(evt:Event):void{
			logo.x=(this.stageWidth-logo.width)/2+80;
			logo.y=(this.stageHeight-logo.height)/2;
		}
		private function waitTxtHandler(evt:Event):void{
			waitTxt.x=(this.stage.width -waitTxt.width)/2+90;
			waitTxt.y=(this.stage.height-waitTxt.height)/2+logo;
			
		}
		private function imgHandler(evt:Event):void{
			img.x=logo.x+120;
			img.y=(this.stage.height)/2+160;
			progressText.x=logo.x+125;
			progressText.y=(this.stage.height)/2+250;
		}
		private function addBlob() : void {
			var item :Sprite = new Box();
			item.y = -100;
			item.x = (Math.random() * 900) - 20;
			item.scaleX = item.scaleY = 3 + (Math.random() * 3);
			item.blendMode = (Math.random() > 0.5) ? BlendMode.ADD : BlendMode.HARDLIGHT;

			var ct : ColorTransform = new ColorTransform();
			ct.redOffset = 50 + (25 * Math.random());
			ct.greenOffset = 150 + (50 * Math.random());
			item.transform.colorTransform = ct;
			var tl : TweensyTimeline = tween.to(item, {scaleX:'3', scaleY:'3', y:"400, 500", x:"-10, 10"}, 1 + Math.random() * 0.5, Linear.easeNone, Math.random() * 2);
			tl.delayEnd = 1 + Math.random();
			tl.repeatType = TweensyTimeline.REPLAY;
			holder.addChild(item);
		}
		
		override protected function initCompleteHandler(event:Event):void
		{
//			img.visible=false;
//			var g:Graphics=this.graphics;
//			//			g.lineStyle(1,0x000000);
//			g.beginFill(0x2714b0,0.9);
//			g.drawCircle(waitTxt.x+waitTxt.width/2-13,waitTxt.y+waitTxt.height/2+5,30);
//			progressText.visible=false;
//			_timer = new Timer(1000, 6);
           
//			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
//			
//			_timer.start();
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		private var count:int=5;
		private function timerHandler(evt:TimerEvent):void
		{
			
			count-=1;
//			waitTxt.htmlText="<font size='60' color='#b02419'>"+count+ "</font>";
			if(count<0){
				
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		override protected function rslCompleteHandler(evt:RSLEvent):void{
			
		}
		override protected function progressHandler(evt:ProgressEvent):void{
			//计算进度，并且设置文字进度和进度条的进度。
						var prog:Number = evt.bytesLoaded/evt.bytesTotal*100;
						progressText.htmlText = "<font size='20' color='#F4BB83'>已下载 " + String(int(prog)) + "%</font>";
						
							img.progress = prog;
							img.refresh();
		}
		
		override protected function initProgressHandler(evt:Event):void{
		
		}
       

	

	}
}