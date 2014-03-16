package ball
{
	import com.adobe.serialization.json.JSON;
	import com.roguedevelopment.pulse.PulseEngine;
	import com.roguedevelopment.pulse.emitter.GenericEmitter;
	import com.roguedevelopment.pulse.simple.SimpleParticles;
	
	import fl.transitions.Tween;
	
	import flab3d.FlabCamera3D;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import flexmdi.containers.AdPanel;
	import flexmdi.events.winresize.WinResizeProxyEvent;
	
	import minn.common.Entrypt;
	import minn.message.Message;
	import minn.proxy.WindowProxy;
	import minn.util.MinnUtil;
	
	import mvc.model.advertise.vo.Advertise;
	import mvc.model.merchandise.vo.Product;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Image;
	import mx.controls.SWFLoader;
	import mx.core.UIComponent;
	import mx.effects.Move;
	import mx.effects.Resize;
	import mx.effects.Zoom;
	import mx.effects.easing.Elastic;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	import mx.modules.Module;
	import mx.modules.ModuleLoader;
	
	
	import spark.components.Panel;
	
	public class FirstPage extends Module
	{
		
		
		private var url1:URLRequest=new URLRequest(Config.FIRST_PAGE);
		private var urlLoader:URLLoader;
//		private var xml:XML;
		private var firstpages:ArrayCollection=new ArrayCollection();
		private var n:int=0;//pic index
		private var isDown:Boolean=true;
		
		private var list:Array=[];
		//		[Bindable]	
		//		[Embed(source='assets/img/page_flip.gif')]	
		//		private var page_flip:Class;
		private	var imgShow:FirstPagePicShow;
//		private var pageflip:Image=new Image();
		private var gw:Number=0;
		private var zoom:Zoom=new Zoom();	
		private var mv:Move=new Move();
		private var pui:UIComponent=new UIComponent();
		private var publicPanel:PublicPanel;
		
		
	
		public function FirstPage()
		{
			super();
//			this.setStyle("backgroundColor","#9da2a3");
			this.percentHeight=100;
			this.percentWidth=100;
			this.horizontalScrollPolicy="off";
			this.verticalScrollPolicy="off";
			this.layout="absolute";
			this.addEventListener(FlexEvent.CREATION_COMPLETE,application1_creationCompleteHandler);
			this.addEventListener(ResizeEvent.RESIZE ,updateCompleteHandler);
		}
		
		override protected function createChildren():void{
			super.createChildren();
			publicPanel=new PublicPanel();
			publicPanel.x=this.width-publicPanel.width-10;
			publicPanel.y=20;
			this.setStyle("horizontalScrollPolicy","off");
			this.setStyle("verticalScrollPolicy","off");
			this.addChild(publicPanel);
		}
		private function updateResizeCompleteHandler(evt:Event):void{
			//			Alert.show('update');
			for(var i:int=0;i<ads.length;i++){
				var p:AdPanel=ads[i] as AdPanel;
				p.y=this.stage.height-p.height;
				//				p.mv.play()
			}
		}
		private function updateCompleteHandler(evt:Event):void{
//			Alert.show('update');
			publicPanel.x=this.width-publicPanel.width-10;
			this.setChildIndex(publicPanel,0);
			pui.x=(this.screen.width-450)/2;
			gw=this.width;
//			pageflip.x=gw-pageflip.width+2;
			var startx:Number=250;
			startx=(this.width-150*ads.length)/2;
			for(var i:int=0;i<ads.length;i++){
				var p:AdPanel=ads[i] as AdPanel;
				if(p.isMax){
					p.windowControls.minimizeBtn.visible=false;
					p.isMax=false;
					p.mv.xTo=startx+p.width*zommmin*i+i*2;
					p.mv.yTo=this.height-p.height*zommmin;
					//			 p1.initx=startx+p1.width*zommmin*i+i*1;
					//			 p1.inity=this.height-p1.height*zommmin;
					p.zm.zoomHeightTo=zommmin;
					p.zm.zoomWidthTo=zommmin;
					p.mv.play();
					p.zm.play();
					
				}
				else{
					p.y=this.height-p.height*zommmin;
					p.x=startx+p.width*zommmin*i+i*2;
				}
				
			}
			effectstart=false;
		}
											  

		protected function application1_creationCompleteHandler(event:FlexEvent):void
		{
		
			
			
			var adurlLoader:URLLoader=new URLLoader();
			adurlLoader.dataFormat=URLLoaderDataFormat.BINARY;
			adurlLoader.addEventListener(Event.COMPLETE,createAd);
			adurlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusEvent);
			adurlLoader.addEventListener(IOErrorEvent.IO_ERROR,ioerrorEvent);
			adurlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityError);
			var request:URLRequest=new URLRequest(Config.ADVERTISE_MENU);
			adurlLoader.load(request);
			
//			xmlLoad();
		}
	
		private  function httpStatusEvent(evt:HTTPStatusEvent):void{
//						Alert.show(evt.type,"HTTPStatusEvent");
		}
		private function securityError(evt:SecurityErrorEvent):void{
			Alert.show(evt.type,"SecurityErrorEvent");
		}
		
		private  function ioerrorEvent(evt:IOErrorEvent):void{
			Alert.show(evt.type,"IOErrorEvent");
		}
		public function xmlLoad():void {
			urlLoader=new URLLoader()  ;
//			urlLoader.dataFormat=URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE,onXmlLoadComplete);
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusEvent);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,ioerrorEvent);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityError);
			urlLoader.load(url1);
		}
		private function onXmlLoadComplete(evt:Event):void {
			var arr:Array=JSON.decode(decodeURIComponent(evt.target.data));
			for(var i:int=0;i<arr.length;i++){
				var v:Product=new Product();
				firstpages.addItem(v);
			}
			MinnUtil.copyProperty(firstpages,arr);
//			xml=XML(firstpages[0].);
//			Alert.show(firstpages.length+'');
			var OBJ_LENGTH:int=firstpages.length;
			
			this.parentDocument.firstpage=firstpages;
			
//			if(OBJ_LENGTH>0)
//				loadpic();
			
		}
		private function onError(evt:IOErrorEvent):void {//XML加载出错
			Alert.show(evt.type,"首页加载提示");
			trace("配置文件加载失败");
		}

		
		private function loadpic(ind:int=0):void{
			var p:Product=firstpages.getItemAt(ind) as Product ;
			var loader:Loader=new Loader()  ;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(evt:Event):void{
				Thumb_loaded(evt,ind);
				if(ind<firstpages.length-1)
				    loadpic(++ind);
				
			});
			//				trace(xml.pic[i].@id.toString());
			var ps:Array=p._photos as Array;
			for(var j:int=0;j<ps.length;j++){
				if(ps[j].isfirst=="1"){
//											Alert.show(Config.UPLOAD_DIR_IMALEVEL2+ps[j].imgpath);
					loader.load(new URLRequest(Config.UPLOAD_DIR_IMALEVEL2+ps[j].imgpath));
					
					break;
				}
			}
		}
		
		
		private function Thumb_loaded(e:Event,ind:int):void {
			///////////
			var p:Product=firstpages.getItemAt(ind) as Product ;
			var file:Loader=e.target.loader;
//					Alert.show("Thumb_loaded"+file.toString());
			//		var mc:MovieClip=new MovieClip  ;
		
			
		}
		
		private var ads:Array=[];
		private var effectstart:Boolean=false;
		private var curAd:AdPanel;
		private var zommmin:Number=0.3;
		private function createAd(evt:Event):void{
//            var ads:Array=[];
			var adarr:Array=JSON.decode(decodeURIComponent(evt.target.data));
//			for(var i:int=0;i<arr.length;i++){
//				var v:Advertise=new Advertise();
//				ads.push(v);
//			}
//			MinnUtil.copyProperty(ac,arr);
			var startx:Number=250;
			startx=(this.width-150*adarr.length)/2;
			for(var i:int=0;i<adarr.length;i++){
			var ad:Object=adarr[i];
			
		     var p1:AdPanel=new AdPanel();
//			 var swfl:ModuleLoader=new ModuleLoader();
//				 swfl.url="ball/AdModule1.swf";
//			 p1.url("http://127.0.0.1:8009/minn/services/advertise/uploadad/chenzhimin_20110309155124.swf");
//			 Alert.show(ad.url+Config.UPLOAD_AD_DIR+ad.filename);
			 p1.url(ad.url+Config.UPLOAD_AD_DIR+ad.filename);
//			 p1.addChild(swfl);
//			 rz.addEventListener(EffectEvent.EFFECT_END,function():void{
//				 var p:AdPanel=curAd;
//				 for(var i:int=0;i<ads.length;i++){
//					 var p1:AdPanel=ads[i] as AdPanel;
//					 if(p1.ind!=p.ind)
//					 {
//						 //					if(p1.zm.isPlaying&&p1.mv.isPlaying){
//						 //					if(p1.ind>p.ind){
//						 //						p1.mv.xTo=p1.x-100;	
//						 //						p1.mv.play();
//						 //					}else{
//						 //						p1.mv.xTo=p1.x+100;	
//						 //						p1.mv.play();
//						 //					}
//						 //				}
//						 
//					 }else
//					 {
//						 //					if(p.zm.isPlaying&&p.mv.isPlaying){
//						 p.mv.xTo=p.x+100;
//						 p.mv.yTo=this.height-p.height*0.5;
//						 p.mv.play();
//						 p.zm.zoomHeightTo=0.5;
//						 p.zm.zoomWidthTo=0.5;
//						 p.zm.play();
//						 //					}
//					 }
//				 }
////				 resizeMouseOverEffect
//			 });
			 p1.addEventListener(WinResizeProxyEvent.WIN_MIN_RESIZE,resizeMouseOutEffect);
			 p1.ind=i;
			 p1.windowControls.minimizeBtn.visible=false;
			 ads.push(p1);
			 p1.width=500;
			 p1.height=300;
//			 if(i==0){
//				 te=0;
//			 }else{
//				 te=5;
//			 }
			 p1.y=this.height-p1.height;
//			 p1.x=this.width-p1.width*(i+1)+i*1;
			 p1.x=startx+p1.width*(i)+i*1;
//			 p1.initx=p1.x;
//			 p1.inity=p1.y;
//			 p1.mv.target=p1;
			 p1.addEventListener(MouseEvent.ROLL_OVER,resizeMouseOverEffect);
//			 p1.addEventListener(MouseEvent.ROLL_OUT,resizeMouseOutEffect);
			 p1.mv.xTo=startx+p1.width*zommmin*i+i*2;
			 p1.mv.yTo=this.height-p1.height*zommmin;
//			 p1.initx=startx+p1.width*zommmin*i+i*1;
//			 p1.inity=this.height-p1.height*zommmin;
			 p1.zm.zoomHeightTo=zommmin;
			 p1.zm.zoomWidthTo=zommmin;
			 this.addElement(p1);
			 p1.mv.play();
			 p1.zm.play();
			}
			
			xmlLoad();
		}
		private function resizeMouseOutEffect(evt:Event):void{
		
			if(effectstart){
			   effectstart=false;
			var p:AdPanel=AdPanel(evt.target);
//			Alert.show(p.zm.isPlaying+'');
//			if(!p.zm.isPlaying&&!p.mv.isPlaying){
//			rzmv.targets=[];
//			rz.targets=[];
//			rzmv.targets=[p];
//			rz.targets=[p];
			if(!p.zm.isPlaying&&!p.mv.isPlaying){
			for(var i:int=0;i<ads.length;i++){
				var p1:AdPanel=ads[i] as AdPanel;
				this.setChildIndex(p1,1);
				p1.mv.duration=10;
				p1.windowControls.minimizeBtn.visible=false;
				if(p1.ind!=p.ind)
				{
//					p1.mv.yTo=this.height-p1.height*zommmin;
//					p1.mv.play();
//					if(p1.zm.isPlaying&&p1.mv.isPlaying){
					p1.isMax=false;
					p1.mv.yTo=this.height-p.height*zommmin;
					if(p1.ind>p.ind){
						p1.mv.xTo=p1.x-175;	
						p1.mv.play();
//						p1.mv.reverse();
					}else{
						p1.mv.xTo=p1.x+175;	
						p1.mv.play();
//						p1.mv.reverse();
					}
//				}
					
				}else
				{
//					trace("mouse out :"+p.zm.isPlaying);
//					if(!p.zm.isPlaying&&!p.mv.isPlaying){
					p.isMax=false;
					p.windowControls.minimizeBtn.visible=false;
					p.zm.duration=5;
					p.mv.duration=5;
					p.mv.xTo=p.x+175;
					p.mv.yTo=this.height-p.height*zommmin;
					p.mv.play();
					p.zm.zoomHeightTo=zommmin;
					p.zm.zoomWidthTo=zommmin;
					p.zm.play();
					
//					}
				}
			}
			}
			}
//			p.mv.xTo=250;
//			p.mv.yTo=this.height-p.height*0.5;
//			p.mv.play();
//			p.zm.zoomHeightTo=0.5;
//			p.zm.zoomWidthTo=0.5;
//			p.zm.play();
		}
		private function resizeMouseOverEffect(evt:MouseEvent):void{
			
		
			if(!effectstart){
				effectstart=true;
			var p:AdPanel=AdPanel(evt.target);
//			if(!p.zm.isPlaying&&!p.mv.isPlaying){
//			rzmv.targets=[];
//			rz.targets=[];
//			rzmv.targets=[p];
//			rz.targets=[p];
//				p.effectend=false;
//			Alert.show(p.mouseY+'');
			if(!p.zm.isPlaying&&!p.mv.isPlaying){
			for(var i:int=0;i<ads.length;i++){
				var p1:AdPanel=ads[i] as AdPanel;
				p1.windowControls.minimizeBtn.visible=false;
//				p1.mv.yTo=this.height-p1.height*zommmin;
//				p1.mv.play();
				if(p1.ind!=p.ind)
				{
					this.setChildIndex(p1,1);
					p1.mv.yTo=this.height-p.height*zommmin;
					p1.isMax=false;
//					if(!p1.zm.isPlaying&&!p1.mv.isPlaying){
					p1.mv.duration=500;
					if(p1.ind>p.ind){
						
						p1.mv.xTo=p1.x+175;	
						p1.mv.play();
//						p1.mv.reverse();
						
					}else{
						p1.mv.xTo=p1.x-175;	
						p1.mv.play();
//						p1.mv.reverse();
//					}
					}
				}else
				{
//					if(!p.zm.isPlaying&&!p.mv.isPlaying){
					p.windowControls.minimizeBtn.visible=true;
					p.isMax=true;
					p.zm.duration=500;
					p.mv.duration=500;
					p.mv.xTo=p.x-175;
					p.mv.yTo=this.height-p.height;
					p.mv.play();
					p.zm.zoomHeightTo=1;
					p.zm.zoomWidthTo=1;
					p.zm.play();
					this.setChildIndex(p,this.getChildren().length-1);
				}
			}
		}
			}
//			p.mv.xTo=200;
//			//				 Alert.show(p1.height+'');
//			p.mv.yTo=this.height-p.height;
//			p.mv.play();
//			p.zm.zoomHeightTo=1;
//			p.zm.zoomWidthTo=1;
//			p.zm.play();
		}
		
		
	}
}