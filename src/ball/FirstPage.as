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
	
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.core.utils.Mouse3D;
	import org.papervision3d.core.utils.virtualmouse.VirtualMouse;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.objects.primitives.Sphere;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	import spark.components.Panel;
	
	public class FirstPage extends Module
	{
		
		private var viewport:Viewport3D;
		private var renderer:BasicRenderEngine;
		private var scene:Scene3D;
		private var camera:FlabCamera3D;
		
		private var OBJ_LENGTH:int=9;
		private static  const CIRCLE_RANGE:int=600;//550;
		private var speedx:Number=0;
		private var speedy:Number=0;
		private var wraps:DisplayObject3D;
		private var url1:URLRequest=new URLRequest(Config.FIRST_PAGE);
		private var urlLoader:URLLoader;
//		private var xml:XML;
		private var firstpages:ArrayCollection=new ArrayCollection();
		private var n:int=0;//pic index
		private var isDown:Boolean=true;
		
		private var wrap:DisplayObject3D;
		private var rot:Number;
		private var m:BitmapFileMaterial;
		private var list:Array=[];
		//		[Bindable]	
		//		[Embed(source='assets/img/page_flip.gif')]	
		//		private var page_flip:Class;
		private	var imgShow:FirstPagePicShow;
		private var pageflip:Image=new Image();
		private var gw:Number=0;
		private var zoom:Zoom=new Zoom();	
		private var mv:Move=new Move();
		private var pui:UIComponent=new UIComponent();
		private var publicPanel:PublicPanel;
		
		
//		public var ballviewport  :Viewport3D;
//		public var ballscene     :Scene3D;
//		public var ballcamera    :Camera3D;
		public var ballSphere	 	 :Sphere;
		public var gismo	 :Cube;
		public var ballrenderer  :BasicRenderEngine;
		public var mouse3D   :org.papervision3d.core.utils.Mouse3D;
		public var vMouse	 :VirtualMouse;
		public var surface	 :Sprite;
		[Embed(source="assets/longball.swf", symbol="canvas1")]
		private var Canvas1:Class;
		
		public function FirstPage()
		{
			super();
			this.setStyle("backgroundColor","#000000");
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
			pageflip.x=gw-pageflip.width+2;
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
			// TODO Auto-generated method stub
//			var sp:Sprite=new Sprite();
//			var ui:UIComponent=new UIComponent();
//			PulseEngine.instance.root = this;
			var emitter:GenericEmitter = SimpleParticles.createEmitter({pps:17,x:126, y:193,size:33, color:65331,line:true, movement:true, minSpeed:192, 
				maxSpeed:362.45, minAngle:0, maxAngle:360, minScale:9.4, maxScale:5.55, fade:9070, pointSwarm:[200,200], 
				rotateToAngle:true, scale:[10870,0.45,1.25], lifespan:10870}) as GenericEmitter;
			emitter.width=this.screen.width;
			emitter.height=this.screen.height;
			emitter.root=pui;
			pui.x=(this.screen.width-450)/2;
//			pui.y=30;
//			ui.addChild(sp);
			this.addChild(pui);	
			pageflip.source="assets/img/page_flip.jpg";
			pageflip.width=60;
			pageflip.height=60;
			pageflip.useHandCursor=true;
			pageflip.buttonMode=true;
			
			pageflip.addEventListener(MouseEvent.MOUSE_OVER,function():void{
				zoom.targets=[];
				mv.targets=[];
				zoom.target=pageflip;
				mv.target=pageflip;
				mv.xTo=gw-5.3*pageflip.width+12;
				mv.play();
				zoom.zoomHeightTo=5.3;
				zoom.zoomWidthTo=5.3;
				zoom.play();
			});
			pageflip.addEventListener(MouseEvent.MOUSE_OUT,function():void{
				mv.xTo=gw-pageflip.width+2;
				mv.play();
				zoom.zoomHeightTo=1;
				zoom.zoomWidthTo=1;
				zoom.play();
			});
			
			pageflip.x=gw-pageflip.width+2;
			this.addChild(pageflip);
		
			var ui:UIComponent=new UIComponent();
			viewport=new Viewport3D(800,500);
			viewport.interactive=true;
			renderer=new BasicRenderEngine() ;
//			wrap=new DisplayObject3D() ;
			scene=new Scene3D  ;
//			scene.addChild(wrap);
			camera=new FlabCamera3D() ;
			ui.addChild(viewport);
			ui.x=(this.screen.width-800)/2;
			ui.y=20;
			addChild(ui);
			init3D();
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			//				stage.scaleMode=StageScaleMode.NO_SCALE;
			//				stage.align=StageAlign.TOP_LEFT;
			//				stage.quality=StageQuality.HIGH;
//			createAd();
//			xmlLoad();
			
		
			
//			addEventListener( Event.ENTER_FRAME, loop );
			
			
//			var adurlLoader:URLLoader=new URLLoader();
//			adurlLoader.dataFormat=URLLoaderDataFormat.BINARY;
//			adurlLoader.addEventListener(Event.COMPLETE,createAd);
//			adurlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusEvent);
//			adurlLoader.addEventListener(IOErrorEvent.IO_ERROR,ioerrorEvent);
//			adurlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityError);
//			var request:URLRequest=new URLRequest(Config.ADVERTISE_MENU);
//			adurlLoader.load(request);
			
//			xmlLoad();
		}
		
		public function init3D():void {
			// Create ballviewport
//			viewport = new Viewport3D(300, 300, false, true);
//			var ui:UIComponent=new UIComponent();
			//				ballviewport.x=-300
			//				ballviewport.y=-180;
//			ui.x=0;
//			ui.y=50;
//			ui.addChild(viewport);、
//			addChild(ui);
			
//			ballrenderer = new BasicRenderEngine();
			
			// Create ballscene
//			scene = new Scene3D();
			
//			camera = new Camera3D();
			
//			vMouse = viewport.interactiveSceneManager.virtualMouse;
//			mouse3D = viewport.interactiveSceneManager.m3D;
//			org.papervision3d.core.utils.Mouse3D.enabled = true;
			
			var material:MovieMaterial = new MovieMaterial( new Canvas1() );
			
			material.smooth = true;
			material.interactive = true;
			material.animated = true;
			material.allowAutoResize = false;
			
			//make an instance of the movieclip in the material
			//				surface = material.movie["surface"];
			
			//Create gismo
			//			gismo = new Cube( new MaterialsList({all:new ColorMaterial(0x888888)}), 10, 10, 10 );
			//			ballscene.addChild(gismo);
			
			//			var bx:Cube = new Cube( new MaterialsList({all:new ColorMaterial(0xFF0000)}), 10, 10, 10 );
			//			var by:Cube = new Cube( new MaterialsList({all:new ColorMaterial(0x00FF00)}), 10, 10, 10 );
			//			var bz:Cube = new Cube( new MaterialsList({all:new ColorMaterial(0x0000FF)}), 10, 10, 10 );
			//			 
			//			bx.x = 100;
			//			by.y = 100;
			//			bz.z = 100;
			//			
			//			bx.scaleX = 15;
			//			by.scaleY = 15;
			//			bz.scaleZ = 15;
			//			
			//			gismo.addChild(bx);
			//			gismo.addChild(by);
			//			gismo.addChild(bz);
			
			//Create ballSphere to draw on
			ballSphere = new Sphere( material, 500, 20, 20 );
			ballSphere.z = 400;
			
			ballSphere.rotationY = -90;
			scene.addChild(ballSphere);
			
			//			ballSphere.addEventListener(InteractiveScene3DEvent.OBJECT_MOVE, handleMouseMove);
			//			ballSphere.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS, handleMouseDown);
			
			// Create ballcamera
//			camera = new Camera3D();
			
			camera.zoom = 30;
			renderer.renderScene(scene, camera,viewport);
			//				ballcamera.x=100;
			
		}
		public function loop(event:Event):void 
		{
			ballSphere.yaw(.5);
			renderer.renderScene(scene, camera, viewport);
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
			OBJ_LENGTH=firstpages.length;
			
			this.parentDocument.firstpage=firstpages;
			
			if(OBJ_LENGTH>0)
				loadpic();
			
		}
		private function onError(evt:IOErrorEvent):void {//XML加载出错
			Alert.show(evt.type,"首页加载提示");
			trace("配置文件加载失败");
		}
//		public function initBall():void {
//			if(OBJ_LENGTH>0)
//			    loadpic();
//		}
		
		private function loadpic(ind:int=0):void{
			var p:Product=firstpages.getItemAt(ind) as Product ;
			var loader:Loader=new Loader()  ;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(evt:Event):void{
				Thumb_loaded(evt,p);
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
		
		
		private function Thumb_loaded(e:Event,pro:Product):void {
			///////////
			var file:Loader=e.target.loader;
//					Alert.show("Thumb_loaded"+file.toString());
			//		var mc:MovieClip=new MovieClip  ;
			var mc:MovieClip=new MovieClip  ;
//					createRef(file,mc);
			mc.addChild(file);
			
			var movieMaterial:MovieMaterial=new MovieMaterial(mc);
			movieMaterial.doubleSided=true;
			movieMaterial.interactive=true;
			trace("num",mc.numChildren);
			rot=360*n/OBJ_LENGTH;
			n++;
			var o:Plane=new Plane(movieMaterial,300,300,2,2);
			o.product=pro;
			o.x=CIRCLE_RANGE*Math.sin(rot*Math.PI/180);
			o.y=0;
			o.z=CIRCLE_RANGE*Math.cos(rot*Math.PI/180);
			o.rotationY=180+rot;
			wrap.addChild(o);
			o.addEventListener(InteractiveScene3DEvent.OBJECT_OVER,onInter1);
			o.addEventListener(InteractiveScene3DEvent.OBJECT_OUT,onInter2);
			o.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK,function(evt:InteractiveScene3DEvent):void{
				//			Alert.show(file.toString());
				onPlaneClick(evt,o.product as Product,file.content);
			} );
			
		}
		
		private function onPlaneClick(evt:InteractiveScene3DEvent,pro:Product,ctn:DisplayObject):void {
			
			isDown=! isDown;
			imgShow=new FirstPagePicShow();
			imgShow.useHandCursor=true;
			imgShow.buttonMode=true;
//			imgShow.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
//				PopUpManager.removePopUp(evt.currentTarget as FirstPagePicShow);
//			});
			
			PopUpManager.addPopUp(imgShow,this);
			PopUpManager.centerPopUp(imgShow);
			imgShow.imgsource=ctn;
			imgShow.product=pro;
//			Entrypt.loadswfObject("ball/FirstPagePicShow"+Config.SUBFFIX,function(evt:Event):void{
//				loadswfCompleteHandler(evt,{product:pro,imgsource:ctn});
//			},this.parentApplication as DisplayObject);
			if (!isDown) {
				//		trace(isDown)
				//		camera.tweenTo(Plane(evt.currentTarget),0);
			} else {
				//		trace(isDown)
				//		camera.tweenTo(Plane(evt.currentTarget),700);
				//		camera.resetToZero();
			}
			
		}
//		private function loadswfCompleteHandler(evt:Event,d:Object):void{
//			//			shopPage_id.loadModule("ProductShowPanel.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY));
//			//				shopPage_id.loadModule("ProductShowPanel.swf",evt.target.data as ByteArray);
//			if(Config.SUBFFIX==Config.FLAG){
//				WindowProxy.getInstance().getModuleWindow("FirstPagePicShow.swf",evt.target.data as ByteArray,d,this.parentApplication as DisplayObject,false,true);
//			}else
//				WindowProxy.getInstance().getModuleWindow("FirstPagePicShow.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY),d,this.parentApplication as DisplayObject,false,true);
//		}
		private var picStop:Boolean=false;
		private function onInter1(e:InteractiveScene3DEvent):void {
			//			mc.stop();
			//		Alert.show('tet');
			var my_tew1:Tween=new Tween(e.target,"scaleX",Elastic.easeOut,1,1.2,3,true);
			//            var ee:mx.effects.Tween=new mx.effects.Tween();
			//			ee.target=e.target;
			//			ee.
			//		picStop=true;
			//		var my_tew2:Tween=new Tween(e.target,"scaleY",Elastic.easeOut,1,1.2,3,true);
			//		removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			e.target.scaleX=1.2;
			e.target.scaleY=1.2;
		}
		private function onInter2(e:InteractiveScene3DEvent):void {
			var my_tew1:Tween=new Tween(e.target,"scaleX",Elastic.easeOut,1.2,1,3,true);
			
			//		var my_tew2:Tween=new Tween(e.target,"scaleY",Elastic.easeOut,1.2,1,3,true);
			//		picStop=false;
			e.target.scaleX=1;
			e.target.scaleY=1;
		}
		private function enterFrameHandler(event:Event):void {
			//			if(!picStop){
			
//			speedx=stage.mouseX>stage.stageWidth/2?1:-1;
//			if (stage.mouseX>stage.stageWidth/2-20&&stage.mouseX<stage.stageWidth/2+20) {
//				speedx=0;
//			}
			ballSphere.yaw(.5);
//			wrap.yaw(0.5);
			renderer.renderScene(scene,camera,viewport);
			//			}
		}
		private function createRef(p_source:DisplayObject,mc:MovieClip):void {//倒影
			
			var bd:BitmapData=new BitmapData(p_source.width,p_source.height,true,0);
			var mtx:Matrix=new Matrix() ;
			mtx.d=-1;
			mtx.ty=bd.height;
			bd.draw(p_source,mtx);
			
			var width:int=bd.width;
			var height:int=bd.height;
			mtx=new Matrix() ;
			mtx.createGradientBox(width,height,0.5*Math.PI);
			var shape:Shape=new Shape()  ;
			shape.graphics.beginGradientFill(GradientType.LINEAR,[0,0],[0.7,0],[0,0xFF],mtx);
			shape.graphics.drawRect(0,0,width,height);
			shape.graphics.endFill();
			var mask_bd:BitmapData=new BitmapData(width,height,true,0);
			mask_bd.draw(shape);
			bd.copyPixels(bd,bd.rect,new Point(0,0),mask_bd,new Point(0,0),false);
			
			var ref:Bitmap=new Bitmap()  ;
			ref.y=p_source.height;
			ref.bitmapData=bd;
			ref.alpha=0.5;
			mc.addChild(ref);
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