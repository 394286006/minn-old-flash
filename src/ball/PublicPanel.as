package ball
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import minn.common.DrawLine;
	import minn.common.MarqueeText;
	
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.Text;
	import mx.core.UIComponent;
	import mx.effects.Move;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	
	public class PublicPanel extends Canvas //UIComponent
	{
		
		private var marquee_id:VBox;
		private var mesStrs:Array=[];
		private var mv:Move;
		private var marqueeCanvas_id:Canvas;
		private var isrollover:Boolean=false;
		public function PublicPanel()
		{
			super();
			this.height=460;
			this.width=260;
			horizontalScrollPolicy="off";
			verticalScrollPolicy="off";
			mv=new Move();
//			this.setStyle("horizontalScrollPolicy","off");
//			this.setStyle("verticalScrollPolicy","off");
            this.addEventListener(FlexEvent.CREATION_COMPLETE,completeHandler);
			mv.addEventListener(EffectEvent.EFFECT_END,function():void{
				marquee_id.y=marqueeCanvas_id.height;
			    mv.play();
			});
			
		}
		override protected function createChildren():void{
			super.createChildren();
			
			var line:DrawLine=new DrawLine();
			line.drawLine(10,10,10,height,0xffffff);
			this.addChild(line);
			line=new DrawLine();
			line.drawLine(10,height,width,height,0xffffff);
			this.addChild(line);
			line=new DrawLine();
			line.drawLine(10,10,20,10,0xffffff);
			this.addChild(line);
			
			var lb:Label=new Label();
			lb.setStyle("color",0x676674);
			lb.setStyle("fontSize",14);
			lb.text="最新消息";
			lb.x=20;
			//			lb.y=100;
			this.addChild(lb);
			line=new DrawLine();
			line.drawLine(80,10,width,10,0xffffff);
			this.addChild(line);
			
			line=new DrawLine();
			line.drawLine(width,10,width,height,0xffffff);
			this.addChild(line);
			marqueeCanvas_id=new Canvas();
			marqueeCanvas_id.percentHeight=100;
			marqueeCanvas_id.percentWidth=100;
			marqueeCanvas_id.x=15;
			marqueeCanvas_id.y=20;
			marqueeCanvas_id.horizontalScrollPolicy="off";
			marqueeCanvas_id.verticalScrollPolicy="off";
			marquee_id=new VBox();
			marqueeCanvas_id.addChild(marquee_id);
			marquee_id.percentWidth=100;
			marquee_id.horizontalScrollPolicy="off";
			marquee_id.verticalScrollPolicy="off";
			marquee_id.setStyle("verticalGap",5);
			mv.target=marquee_id;
			marquee_id.addEventListener(MouseEvent.ROLL_OUT,function():void{
				isrollover=false;
				mv.resume();
			});
			marquee_id.addEventListener(MouseEvent.ROLL_OVER,function():void{
				isrollover=true;
				mv.pause();
			});
			marquee_id.addEventListener(FlexEvent.UPDATE_COMPLETE,function():void{
//				if(marquee_id.height!=0&&(marquee_id.height>marqueeCanvas_id.height)){
//				if(!isrollover){
//					if(marquee_id.height<marqueeCanvas_id.height)
//					mv.duration=50*(marquee_id.height);
//					else{
//					mv.duration=50*(marquee_id.height);
////					}
//					mv.repeatDelay=-10;
//					mv.yTo=-marqueeCanvas_id.height;
//					mv.play();
//				}
//				}
			});
			this.addChild(marqueeCanvas_id);
	
		}
		
		private function completeHandler(evt:FlexEvent):void{
			var urlLoader:URLLoader=new URLLoader();
			urlLoader.dataFormat=URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE,loadcompleteHandler);
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusEvent);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,ioerrorEvent);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityError);
			var request:URLRequest=new URLRequest(Config.PUBLIC_MESSAGE);
			urlLoader.load(request);
		}
		private  function httpStatusEvent(evt:HTTPStatusEvent):void{
			//			Alert.show(evt.type,"HTTPStatusEvent");
		}
		private function securityError(evt:SecurityErrorEvent):void{
			Alert.show(evt.type,"SecurityErrorEvent");
		}
		
		private  function ioerrorEvent(evt:IOErrorEvent):void{
			Alert.show(evt.type,"IOErrorEvent");
		}
		private function loadcompleteHandler(evt:Event):void{
			
			mesStrs=JSON.decode(decodeURIComponent(evt.target.data));
			var rownum:int=0;
			for(var i:int=0;i<mesStrs.length;i++)
			{
				var mt:MarqueeText=new MarqueeText();
				mt.useHandCursor=true;
				mt.buttonMode=true;
				mt.enabled=false;
				mt.percentWidth=100;
				mt.setStyle("color","#ffffff");
				mt.setStyle("fontSize",14);
				if(String(mesStrs[i].content).length/16==0){
					rownum+=1;
				}else{
					rownum+=String(mesStrs[i].content).length/16+1;
				}
				mt.htmlText="<font color='#F4BB83'>"+mesStrs[i].content+"</font>[<font color='#666fff'>"+mesStrs[i].modifyDate+"</font>]";
				mt.data=mesStrs[i];
				mt.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
//					Alert.show(evt.target.data);
				});
				marquee_id.addChild(mt);
			}
		
//			if(marquee_id.height>marqueeCanvas_id.height)
			marquee_id.y=marqueeCanvas_id.height;
			mv.duration=50*(marqueeCanvas_id.height);
			mv.repeatDelay=-10;
			mv.yTo=-25*rownum;
			mv.play();
		}
		
	}
}