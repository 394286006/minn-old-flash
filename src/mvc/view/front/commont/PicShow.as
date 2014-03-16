/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.commont
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import flexmdi.events.MinnMessageEvent;
	import flexmdi.events.MinnMessageEventManager;
	
	import minn.common.Circle;
	
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.HRule;
	import mx.controls.Image;
	import mx.controls.VRule;
	import mx.effects.Glow;
	import mx.effects.Move;
	import mx.effects.Zoom;
	import mx.events.CloseEvent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.managers.PopUpManager;
	import mx.modules.Module;
	//created by minn email:freemanfreelift@gmail.com  qq:394286006
	public class PicShow extends Module
	{
		public function PicShow()
		{
			super();
			this.setStyle("cornerRadius",5);
			this.horizontalScrollPolicy="off";
			this.verticalScrollPolicy="off";
			this.addEventListener(FlexEvent.PREINITIALIZE,module1_preinitializeHandler);
//			this.addEventListener(FlexEvent.CREATION_COMPLETE,module1_creationCompleteHandler);
			vb=new VBox();
			vb.percentHeight=100;
			vb.percentWidth=100;
			vb.setStyle("cornerRadius",5);
			vb.addEventListener(MouseEvent.MOUSE_DOWN,vb_mouseDownHandler);
			vb.addEventListener(MouseEvent.MOUSE_UP,vb_mouseUpHandler);
			vb.addEventListener(MouseEvent.MOUSE_MOVE,vb_mouseMoveHandler);
			vb.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE,closeWin);
			this.addChild(vb);
//			module1_creationCompleteHandler();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,module1_creationCompleteHandler);
//			this.addEventListener(FlexEvent.REMOVE,removeEventHandler);
		}
		private var vb:VBox;
//		override protected function createChildren():void{
//			super.createChildren();
//		
//		}
		private function removeEventHandler(evt:FlexEvent):void{
//			Alert.show("tigao");
		}
		private var imgshow:Image=null;
		private var zoom:Zoom=null;
		//			private var zoom:Scale=null;
		private var dept:Number=1;
		private var hb:HBox=null;
		//			var vb:VBox=null;
		private var leftvr:VRule=null;
		private var rightvr:VRule=null;
		
		private var curindex:int=0;
		private var imglevel2:Array=null;
		private var g:Glow=new Glow();
		private var iscreate:Boolean=false;
		protected function module1_preinitializeHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
			//				this.addEventListener(this.parent.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,messageHandler);
			//				MinnMessageEventManager.getInstance().addEventListener(this.parent.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,messageHandler);
			MinnMessageEventManager.getDisp().addEventListener(this.parent.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,messageHandler);
			
			g.duration=1000;
			g.blurXTo=30;
			g.blurYTo=30;
			g.alphaFrom=0.5;
			g.alphaTo=1.5;
			g.addEventListener(EffectEvent.EFFECT_END,function():void{
				g.play(null,true);
			});
		}
		private function messageHandler(e:MinnMessageEvent):void{
			imglevel2=e.data.photos as Array;
			curindex=e.data.curindex;
			if(!iscreate)
			module1_creationCompleteHandler();
		}
		protected function module1_creationCompleteHandler(event:FlexEvent=null):void
		{
			//			    vb=new VBox();
			//				vb.setStyle("verticalGap",0);
			if(imglevel2!=null&&!iscreate){
				iscreate=true;
			var hr:HRule=new HRule();
			hr.height=0;
			vb.addChild(hr);
			
			vb.setStyle("backgroundAlpha",0.5);
			vb.setStyle("cornerRadius",5);
			vb.setStyle("backgroundColor",0x5B2B1B7);
			hb=new HBox();
			hb.setStyle("horizontalGap",0);
			var vb1:VBox=new VBox();
			vb1.setStyle("verticalGap",0);
			leftvr=new VRule();
			leftvr.width=0;
			vb1.addChild(leftvr);
			var leftcan:Canvas=new Canvas();
			//				can.percentHeight=100;
			//				can.percentWidth=100;
			var left:Image=new Image();
			leftcan.addChild(left);
			left.buttonMode=true;
			left.useHandCursor=true;
			left.source="assets/img/fancy_left.png";
			left.addEventListener(MouseEvent.CLICK,function(evt:Event):void{
				//					closeWin();
				--curindex;
				
				if(curindex<0){
					curindex=0;
				}else if(curindex>imglevel2.length-1){
					curindex=imglevel2.length-1;
				}
				imgshow.source=Config.UPLOAD_DIR_IMALEVEL2+imglevel2[curindex].imgpath;
			});
			left.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void{
				var cir:Circle=new Circle();
				cir.drawCircle(15,13,10,0x0a10f2,3);
				leftcan.addChild(cir);
				g.target=cir;
				g.play();
				
			});
			left.addEventListener(MouseEvent.MOUSE_OUT,function():void{
				g.stop();
				leftcan.removeChild(g.target as Circle);
				g.targets=[];
				
			});
			
			vb1.addChild(leftcan);
			hb.addChild(vb1);
			imgshow=new Image();
			if(imglevel2[curindex].hasOwnProperty("imgpath"))
			imgshow.source=Config.UPLOAD_DIR_IMALEVEL2+imglevel2[curindex].imgpath;
			
			
			imgshow.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
				//300;
				imgshow.width=imgshow.loaderInfo.width;
				imgshow.height=imgshow.loaderInfo.height;
				leftvr.height=imgshow.height/2-30;
				rightvr.height=imgshow.height/2-30;
			});
			imgshow.addEventListener(MouseEvent.MOUSE_WHEEL,imgshow_mouseWheelHandler);
			
			hb.addChild(imgshow);
			vb1=new VBox();
			vb1.setStyle("verticalGap",0);
			
			rightvr=new VRule();
			rightvr.width=0;
			//				rightvr.percentHeight=45;
			vb1.addChild(rightvr);
			var rightcan:Canvas=new Canvas();
			var right:Image=new Image();
			right.buttonMode=true;
			right.useHandCursor=true;
			rightcan.addChild(right);
			right.source="assets/img/fancy_right.png";
			//				right.setStyle("paddingTop",10);
			right.addEventListener(MouseEvent.CLICK,function(evt:Event):void{
				//					closeWin();
				++curindex;
				if(curindex>imglevel2.length-1){
					curindex=imglevel2.length-1;
					//						imgshow.source=imglevel2[curindex];
				}
				imgshow.source=Config.UPLOAD_DIR_IMALEVEL2+imglevel2[curindex].imgpath;
				
			});
			right.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void{
				var cir:Circle=new Circle();
				cir.drawCircle(15,13,10,0x0a10f2,3);
				rightcan.addChild(cir);
				g.target=cir;
				g.play();
				
			});
			right.addEventListener(MouseEvent.MOUSE_OUT,function():void{
				g.stop();
				rightcan.removeChild(g.target as Circle);
				g.targets=[];
				
			});
			vb1.addChild(rightcan);
			
			hb.addChild(vb1);
			vb.addChild(hb);
			hr=new HRule();
			hr.height=0;
			vb.addChild(hr);
			PopUpManager.addPopUp(vb,this);
			PopUpManager.centerPopUp(vb);
			//				zoom=new Scale();
			zoom=new Zoom();
			zoom.target=imgshow;
			zoom.duration=1;
			zoom.addEventListener(EffectEvent.EFFECT_END,zoomEndHandler);
			//				   Alert.show(this.width+"");
			//					zoom.stop();
			
			//					m.xTo=this.screen.width/2-imgshow.width/2;
			//					m.yTo=this.screen.height/2-imgshow.height/2;
			//					m.play();
			
			//					imgshow.x=200;
			//					imgshow.y=50;
			
			//				});
			
			imgshow.addEventListener(MouseEvent.MOUSE_UP,function():void{
				//				Alert.show("mouseup");
				ismv=false;
			});
			//			hb.setChildIndex(imgshow,0);
			}
		}
		private function closeWin(e:Event=null):void{
//							Alert.show('d');
			//				vb.removeAllChildren();
			PopUpManager.removePopUp(vb);
			this.dispatchEvent(new CloseEvent(CloseEvent.CLOSE,true));
		}
		private function zoomEndHandler(e:EffectEvent):void{
			var m:Move=new Move();
			m.target=vb;
			m.xTo=this.screen.width/2-vb.width/2;
			m.yTo=this.screen.height/2-vb.height/2;
			//			  Alert.show(hb.width.toString());
			//			  m.xTo=zoom.originX;
			//			  m.yTo=zoom.originY;
			//			  Alert.show(leftimgh+'');
			leftvr.height=vb.height/2-30;
			rightvr.height=vb.height/2-30;
			m.play();
		}
		protected function imgshow_mouseWheelHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//                Alert.show('d');
			if(event.delta>0){
				dept+=0.1;
				
			}else{
				dept-=0.1;
				if(dept<0.6)
					dept=0.6;
			}
			zoom.zoomHeightTo=dept;
			zoom.zoomWidthTo=dept;
			(!zoom.isPlaying)
			zoom.play();
			
		}
		
		
		
		
		
		
		private var startx:Number=0;
		private var starty:Number=0;
		private var ismv:Boolean=false;
		protected function vb_mouseDownHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			ismv=true;
			startx=vb.mouseX;
			starty=vb.mouseY;
			//				Alert.show(startx.toString());
		}
		
		
		protected function vb_mouseUpHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			ismv=false;
			//				Alert.show("mouseup");
			
		}
		
		
		protected function vb_mouseMoveHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(ismv){
				var p1:Point=localToGlobal(new Point(startx,starty));
				//				var p2:Point=localToGlobal(new Point(event.stageX ,event.stageY));
				var p2:Point=localToGlobal(new Point(vb.mouseX ,vb.mouseY));
				//				trace("x"+p2.x+" y:"+p2.y);
				trace("x"+(p2.x-p1.x)+" y:"+(p2.y-p1.y));
				
				vb.x=vb.x+ (p2.x-p1.x);//vb.x-(event.stageX-startx)-100;
				vb.y=vb.y+(p2.y-p1.y);//vb.y-(event.stageY-starty)-50;
			}
			//				trace("curent:"+vb.x);
		}

	}
}