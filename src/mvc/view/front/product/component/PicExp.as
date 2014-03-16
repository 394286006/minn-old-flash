package mvc.view.front.product.component
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import minn.common.Circle;
	import minn.common.Entrypt;
	import minn.proxy.WindowProxy;
	
	import mvc.model.merchandise.vo.Product;
	
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Image;
	import mx.effects.Blur;
	import mx.effects.Move;
	import mx.effects.Zoom;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	
	public class PicExp extends VBox
	{
		private var imgarr:Array;
		private var zoom:Zoom=null;
		private var mv:Move=null;
		private var _product:Product;
		private var curindex:String=null;
		private var bigimg:Image;
		private var exp:Canvas;
		private var back:Image;
		private var forword:Image;
		private var shows:HBox;
		public function PicExp()
		{
			super();
			this.width=450;
			this.height=455;
			this.horizontalScrollPolicy="off";
			this.verticalScrollPolicy="off";
			this.setStyle("verticalGap",0);
			this.addEventListener(MouseEvent.MOUSE_OVER,hbox1_mouseOverHandler);
			this.addEventListener(FlexEvent.CREATION_COMPLETE,vbox1_creationCompleteHandler);
		}
		
		override protected function createChildren():void{
			super.createChildren();
			bigimg=new Image();
			bigimg.useHandCursor=true;
			bigimg.buttonMode=true;	
			bigimg.percentWidth=100;
			bigimg.height=340;
			bigimg.addEventListener(MouseEvent.CLICK,bigimg_clickHandler);
			this.addChild(bigimg);
			exp=new Canvas();
			exp.height=80;
			exp.percentWidth=100;
			exp.setStyle("borderColor","#CEBBBB");
			exp.setStyle("borderStyle","solid");
			exp.horizontalScrollPolicy="off";
			exp.verticalScrollPolicy="off";
			exp.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
				forword.x=exp.width-32;
			});
			back=new Image();
			back.useHandCursor=true;
			back.buttonMode=true;
			back.x=0;
			back.y=20;
			back.source="assets/img/fancy_left.png";
			back.addEventListener(MouseEvent.CLICK,back_clickHandler);
			exp.addChild(back);
			shows=new HBox();
			shows.setStyle("horizontalGap","5");
			shows.percentWidth=100;
			shows.horizontalScrollPolicy="off";
			shows.verticalScrollPolicy="off";
			shows.x=30;
			shows.y=2;
			exp.addChild(shows);
			forword=new Image();
			forword.useHandCursor=true;
			forword.buttonMode=true;
			forword.y=20;
			forword.source="assets/img/fancy_right.png";
			forword.addEventListener(MouseEvent.CLICK,forword_clickHandler);
			exp.addChild(forword);
			this.addChild(exp);
		}
		
		[Bindable]
		public function get product():Product{
			return _product;
		}
		
		public function set product(p:Product):void{
			this._product=p;
			imgarr=p._photos as Array;
			hbox1_creationCompleteHandler();
		}
		
		protected function hbox1_creationCompleteHandler(event:FlexEvent=null):void
		{
			// TODO Auto-generated method stub
			shows.removeAllElements();
			shows.removeAllChildren();
			mv=new Move();
			mv.duration=1000;
			mv.target=shows;
			zoom=new Zoom();
			for(var i:int=0;i<imgarr.length;i++){
				
				var img:Image=new Image();
				img.source=Config.UPLOAD_DIR_IMALEVEL1+imgarr[i].imgpath;
				img.height=80;
				img.width=100;
				img.id=i.toString();
				img.data=Config.UPLOAD_DIR_IMALEVEL2+imgarr[i].imgpath;
				img.addEventListener(MouseEvent.ROLL_OVER,function(evt:MouseEvent):void{
					//						zoom.targets=[];
					bigimg.source=(evt.currentTarget as Image).data.toString();
					curindex=(evt.currentTarget as Image).id;
					zoom.target=(evt.currentTarget as Image);
					zoom.zoomHeightTo=1.5;
					zoom.zoomWidthTo=1.5;
					zoom.play();
				});
				img.addEventListener(MouseEvent.ROLL_OUT,function(evt:MouseEvent):void{
					//						zoom.targets=[];
					zoom.target=(evt.currentTarget as Image);
					zoom.zoomHeightTo=1;
					zoom.zoomWidthTo=1;
					zoom.play();
				});
				img.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
					//						bigimg.source=(evt.currentTarget as Image).source;
					//						curindex=(evt.currentTarget as Image).id;
				});
				shows.addChild(img);
			}
			mv.addEventListener(EffectEvent.EFFECT_START,function():void{
				back.enabled=false;
				forword.enabled=false;
			});
			mv.addEventListener(EffectEvent.EFFECT_END,function():void{
				back.enabled=true;
				forword.enabled=true;
			});
			bigimg.source=bigimg.source=Config.UPLOAD_DIR_IMALEVEL2+imgarr[0].imgpath;
			exp.setChildIndex(shows,0);
		}
		
		
		protected function hbox1_mouseOverHandler(event:MouseEvent):void
		{
			
		}
		
		
		private var count:int=1;
		private var total:int=16;
		
		protected function forword_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
			total=shows.getChildren().length;
			var t:int=0;
			if(total%4==0)
				t=total/4;
			else{
				t=total/4+1;
			}
			//				trace(count);
			if(count<t){
				//				   shows.move(shows.x-30*6,2);
				mv.xTo=shows.x-100*4;
				mv.play();
				count++;
			}else{
				//					forword.visible=false;
			}
		}
		
		
		protected function back_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
			if(count>1){
				mv.xTo=shows.x+100*4;
				mv.play();
				count--;
			}else{
				
			}
		}
		
		
		protected function bigimg_clickHandler(event:MouseEvent):void
		{
			Entrypt.loadswfObject("mvc/view/front/commont/PicShow"+Config.SUBFFIX,loadswfCompleteHandler,this);
//			WindowProxy.getInstance().getModuleWindow("mvc/view/front/commont/PicShow.swf",{photos:product._photos,curindex:curindex},this,false,true);
		}
		private function loadswfCompleteHandler(evt:Event):void{
//			shopPage_id.loadModule("ProductShowPanel.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY));
			//				shopPage_id.loadModule("ProductShowPanel.swf",evt.target.data as ByteArray);
			if(Config.SUBFFIX==Config.FLAG){
				WindowProxy.getInstance().getModuleWindow("PicShow.swf",evt.target.data as ByteArray,{photos:product._photos,curindex:curindex},this,false,true);
			}else
			    WindowProxy.getInstance().getModuleWindow("PicShow.swf",Entrypt.uncompress(evt.target.data as ByteArray,this.parentApplication.KEY),{photos:product._photos,curindex:curindex},this,false,true);
		}
		
		private var blr:Blur=null;
		
		protected function vbox1_creationCompleteHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
			blr=new Blur();
			//				var cir:Circle=new Circle();
			//				exp.addChild(cir);
			//				cir.drawCircle(back.x+7,back.y+6,10,0x0a10f2,3);
			blr.duration=1000;
			blr.blurXTo=30;
			blr.blurYTo=30;
			blr.addEventListener(EffectEvent.EFFECT_END,function():void{
				blr.play();
			});
			
			back.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void{
				var cir:Circle=new Circle();
				cir.drawCircle(15,32,10,0x0a10f2,3);
				exp.addChild(cir);
				blr.target=cir;
				blr.play();
				
			});
			back.addEventListener(MouseEvent.MOUSE_OUT,function():void{
				blr.stop();
				exp.removeChild(blr.target as Circle);
				blr.targets=[];
				
			});
			
			forword.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void{
				var cir:Circle=new Circle();
				cir.drawCircle(forword.x+16,32,10,0x0a10f2,3);
				exp.addChild(cir);
				blr.target=cir;
				blr.play();
				
			});
			forword.addEventListener(MouseEvent.MOUSE_OUT,function():void{
				blr.stop();
				exp.removeChild(blr.target as Circle);
				blr.targets=[];
				
			});
			
		}
	}
}