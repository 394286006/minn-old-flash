/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.proxy
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.net.LocalConnection;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	import flexmdi.containers.MDICanvas;
	import flexmdi.containers.MDIWindow;
	import flexmdi.containers.PopWin;
	import flexmdi.containers.PopWinExplorer;
	import flexmdi.events.MinnMessageEvent;
	import flexmdi.events.MinnMessageEventManager;
	import flexmdi.events.winresize.WinResizeProxyEvent;
	import flexmdi.managers.MDIManager;
	
	import minn.message.Message;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.TitleWindow;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Image;
	import mx.controls.ProgressBar;
	import mx.controls.ProgressBarMode;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.Zoom;
	import mx.events.CloseEvent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.ModuleEvent;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.managers.SystemManager;
	import mx.modules.IModuleInfo;
	import mx.modules.Module;
	import mx.modules.ModuleLoader;
	import mx.modules.ModuleManager;
	import mx.styles.StyleManager;
	
	
	import spark.components.TitleWindow;
	
	
	
	public class WindowProxy
	{
		private static const windows:ArrayCollection=new ArrayCollection();
		private static const persistentwindows:ArrayCollection=new ArrayCollection();
		private var popwins:ArrayCollection=new ArrayCollection();
		private var minpopwins:ArrayCollection=new ArrayCollection();
		private var popmv:Move=new Move();
//		private var appFacade:ApplicationFacade= ApplicationFacade.getInstance();
		//查看小图标
		[Embed(source='assets/img/title.gif')] 
		public  var popicon:Class;
		private static var windowProxy:WindowProxy=null;
		[Embed(source="assets/assets.swf", symbol="firefox_close_up")]
		private static var DEFAULT_CLOSE_UP:Class;
		
		[Embed(source="assets/assets.swf", symbol="firefox_close_over")]
		private static var DEFAULT_CLOSE_OVER:Class;
		
		[Embed(source="assets/assets.swf", symbol="firefox_close_down")]
		private static var DEFAULT_CLOSE_DOWN:Class;
		
		[Embed(source="assets/assets.swf", symbol="firefox_close_disabled")]
		private static var DEFAULT_CLOSE_DISABLED:Class;
		
		[Embed(source="assets/assets.swf", symbol="left_arrow")]
		private static var DEFAULT_LEFT_BUTTON:Class;
		
		[Embed(source="assets/assets.swf", symbol="right_arrow")]
		private static var DEFAULT_RIGHT_BUTTON:Class;
		[Bindable] 
		[Embed("assets/img/page/wait.gif")] 
		private var c:Class; 
		
		
		[Bindable]   
		[Embed("assets/img/page/done.gif")] 
		private var c1:Class; 
		[Bindable] 
		[Embed("assets/loading.swf")] 
		private var c2:Class; 
		private var progressBar:Image
		
		private static var timer:Timer=new Timer(60000);
		
		private static var _mdi:MDICanvas=null;
		private var fade:Fade=new Fade();
		private var zoom:Zoom=new Zoom();
		private var move:Move=new Move();
		private var p:Point=new Point(0,0);
		public function WindowProxy()
		{
			progressBar=new Image();
			progressBar.source=c2;
		}
		
		public static function getInstance(mdi:MDICanvas=null):WindowProxy{
			
			if(windowProxy==null)
			{
				windowProxy=new WindowProxy();
				_mdi=mdi;
			}
			return windowProxy;
		}
		
		public  function getMdiWindow(url:String,data:Object=null,persistent:Boolean=false,w:Number=600,h:Number=400):flexmdi.containers.MDIWindow{
			var mw:MDIWindow=null;
			for(var i:int=0;i<persistentwindows.length;i++){
				if(persistentwindows[i].url==url){
					mw=persistentwindows[i].uid as MDIWindow;
//					Alert.show(mw.title);
				}
			}
		
			if(mw==null){
			
			 mw=new MDIWindow();
			
			mw.height=h;
			mw.width=w;
			mw.titleIcon=c;
			var ml:ModuleLoader=new ModuleLoader();
			PopUpManager.addPopUp(progressBar,FlexGlobals.topLevelApplication as DisplayObject,false);
			PopUpManager.centerPopUp(progressBar);
			mw.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
				timer.addEventListener(TimerEvent.TIMER,function():void{
					Alert.okLabel="稍后加载";
					Alert.cancelLabel="继续加载";
					Alert.show("由于网络问题，加载时间太长，\n请选择网络好的时候再加载！","提示",Alert.OK|Alert.CANCEL,null,function(e:CloseEvent):void{
						if(e.detail==Alert.OK){
							PopUpManager.removePopUp(progressBar);
							ml.removeEventListener(ModuleEvent.READY,function():void{});
							ml.unloadModule();
							mw.removeAllChildren();
//							mw.removeAllElements();
							try{
							_mdi.removeChild(mw);
							}catch(e:Error){
								
							}
							removeWinow(url);
							timer.removeEventListener(TimerEvent.TIMER,function():void{});
							
						 }else{
							timer.start();
						}
						
					});
				});
				timer.start();
					ml.percentHeight=100;
					ml.percentWidth=100;
					ml.addEventListener(ModuleEvent.READY,function(e:ModuleEvent):void{
						mw.title=ml.child.name;
//						mw.percentHeight=100;
//						mw.percentWidth=100;
//						mw.height=ml.height;
//						mw.width=ml.width;
						
						PopUpManager.removePopUp(progressBar);
						mw.titleIcon=c1;
						if(persistent){
							persistentwindows.addItem({url:url,uid:mw});
						}else
						    windows.addItem({url:url,uid:mw});
						timer.stop();
						timer.removeEventListener(TimerEvent.TIMER,function():void{});
						ml.child.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
						 if(data!=null)
							sendMessage(new MinnMessageEvent(mw.getChildAt(0).toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,data,true));
						});
			              });
					mw.addChild(ml);
					ml.loadModule(url);
//					appFacade.startup(cmd,mw);
				
			});
			
			mw.addEventListener(CloseEvent.CLOSE,function():void{
				
//				PopUpManager.removePopUp(progressBar);
//				ml.removeEventListener(ModuleEvent.READY,function():void{});
				if(!persistent){
					ml.unloadModule();
	//				mw.removeAllChildren();
					mw.removeAllElements();
					MDIManager.global.remove(mw);
	//				_mdi.removeChild(mw);
					removeWinow(url);
				}else{
//					mw.visible=false;
					_mdi.windowManager.remove(mw);
				}
				
			});
			_mdi.windowManager.addCenter(mw);
			effectStart(mw,false);
			}else{
			
				mw.visible=true;
				_mdi.windowManager.addCenter(mw);
			}
			
			return mw;
		}
		
		
		public  function getTitleWindow(url:String,data:Object=null,parent:Object=null,showCloseButon:Boolean=false,w:Number=400,h:Number=300):mx.containers.TitleWindow{
			var tw:mx.containers.TitleWindow=new mx.containers.TitleWindow();
//			tw.width=w;
//			tw.height=h;
			tw.titleIcon=c;
			tw.showCloseButton=showCloseButon;
			var ml:ModuleLoader=new ModuleLoader();
			
			PopUpManager.addPopUp(progressBar,FlexGlobals.topLevelApplication as DisplayObject,false);
			PopUpManager.centerPopUp(progressBar);
			tw.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
				timer.addEventListener(TimerEvent.TIMER,function():void{
					Alert.okLabel="稍后加载";
					Alert.cancelLabel="继续加载";
					Alert.show("由于网络问题，加载时间太长，\n请选择网络好的时候再加载！","提示",Alert.OK|Alert.CANCEL,null,function(e:CloseEvent):void{
						if(e.detail==Alert.OK){
							ml.removeEventListener(ModuleEvent.READY,function():void{});
							ml.unloadModule();
							tw.removeAllChildren();
							tw.removeAllElements();
							PopUpManager.removePopUp(tw);
							removeWinow(url);
							timer.removeEventListener(TimerEvent.TIMER,function():void{});
							PopUpManager.removePopUp(progressBar);
						}else{
							timer.start();
						}
						
					});
				});
				timer.start();
//				ml.percentHeight=100;
//				ml.percentWidth=100;
				ml.addEventListener(ModuleEvent.READY,function():void{
				tw.title=ml.child.name;
				PopUpManager.removePopUp(progressBar);
				tw.titleIcon=c1;
					windows.addItem({url:url,uid:tw});
					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER,function():void{});
					ml.child.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
						if(data!=null)
						sendMessage(new MinnMessageEvent(tw.getChildAt(0).toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,data,true));
					});
				});
				tw.addElement(ml);
				ml.loadModule(url);
			});
			
			tw.addEventListener(CloseEvent.CLOSE,function():void{
				PopUpManager.removePopUp(progressBar);
				ml.removeEventListener(ModuleEvent.READY,function():void{});
				ml.unloadModule();
				tw.removeAllChildren();
				tw.removeAllElements();
				PopUpManager.removePopUp(tw);
				removeWinow(url);
			});
			if(parent==null)
				parent=FlexGlobals.topLevelApplication;
			PopUpManager.addPopUp(tw,parent  as DisplayObject,true,null,parent.moduleFactory);
			PopUpManager.centerPopUp(tw);
			effectStart(tw);
			
			return tw;
		}
		private function sendMessage(e:MinnMessageEvent):void{
			FlexGlobals.topLevelApplication.dispatchEvent(e);
		}
		public  function getSpTitleWindow(url:String,data:Object=null,parent:Object=null,iscenter:Boolean=true,x:Number=400,y:Number=300):spark.components.TitleWindow{
			var tw:spark.components.TitleWindow=new spark.components.TitleWindow();
//			tw.width=w;
//			tw.height=h;
			tw.alpha=0;
	
//			tw.setStyle("backgroundColor","#1ff2ff");
//			tw.setStyle("backgroundAlpha",0);
//			tw.setStyle("color","#f2f3ff");
			var ml:ModuleLoader=new ModuleLoader();
			PopUpManager.addPopUp(progressBar,FlexGlobals.topLevelApplication as DisplayObject,false);
			PopUpManager.centerPopUp(progressBar);
			tw.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
				timer.addEventListener(TimerEvent.TIMER,function():void{
					Alert.okLabel="稍后加载";
					Alert.cancelLabel="继续加载";
					Alert.show("由于网络问题，加载时间太长，\n请选择网络好的时候再加载！","提示",Alert.OK|Alert.CANCEL,null,function(e:CloseEvent):void{
						if(e.detail==Alert.OK){
							PopUpManager.removePopUp(progressBar);
							ml.removeEventListener(ModuleEvent.READY,function():void{});
							ml.unloadModule();
							tw.removeAllElements();
							PopUpManager.removePopUp(tw);
							removeWinow(url);
							timer.removeEventListener(TimerEvent.TIMER,function():void{});
						
						}else{
							timer.start();
						}
						
					});
				});
				timer.start();
//				ml.percentHeight=100;
//				ml.percentWidth=100;
				ml.addEventListener(ModuleEvent.READY,function(e:ModuleEvent):void{
					tw.title=ml.child.name;
//					tw.width=ml.child.width;
//					tw.height=ml.child.height;
//					tw.titleDisplay.width=ml.child.width;
//					tw.titleDisplay.height=ml.child.height;
					
					PopUpManager.removePopUp(progressBar);
					windows.addItem({url:url,uid:tw});
					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER,function():void{});
					ml.child.addEventListener(FlexEvent.CONTENT_CREATION_COMPLETE,function():void{
//						Alert.show(tw.getChildAt(0).toString());
						                 if(data!=null)
											sendMessage(new MinnMessageEvent(tw.getChildAt(0).toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,data,true));
										});
					 
					move.xTo=(parent as DisplayObject).width/2-ml.child.width/2;//x+tw.width;
					move.yTo=(parent as DisplayObject).height/2-ml.child.height/2;//y-tw.width;
					move.play([tw]);
				});
	
				tw.addElement(ml);
				ml.loadModule(url);
			});
			ml.addEventListener(ModuleEvent.UNLOAD,function():void{
				
			});
			tw.addEventListener(CloseEvent.CLOSE,function():void{
				PopUpManager.removePopUp(progressBar);
				ml.removeEventListener(ModuleEvent.READY,function():void{});
				ml.unloadModule();
				tw.removeAllElements();
				fade.stop();
				zoom.stop();
//				p=new Point(0,0);
				move.duration=500;
				
				move.xTo=p.x;//x+tw.width;
				move.yTo=p.y;//y-tw.width;
				move.play([tw]);
				
//				var zoom:Zoom=new Zoom();
				zoom.duration=500;
				zoom.zoomWidthTo=0.0;
				zoom.zoomHeightTo=0.0;
				zoom.play([tw]);
//				var fade:Fade=new Fade();
				fade.duration=500;
				fade.alphaFrom=1;
				fade.alphaTo=0;
				fade.play([tw]);
				move.addEventListener(EffectEvent.EFFECT_END,function():void{
					PopUpManager.removePopUp(tw);
					removeWinow(url);
					if(move!=null)
					   move.targets=[];
					if(fade!=null)
					fade.targets=[];
					if(zoom!=null)
					zoom.targets=[];
				});
			});
//			tw.addEventListener(FlexEvent.CREATION_COMPLETE
//			
//			var ml:IModuleInfo=ModuleManager.getModule(url);	
//			ml.addEventListener(ModuleEvent.SETUP,function(e:ModuleEvent):void{
////				Alert.show('start');
////				tw.width=e.module.
//			});
//			ml.addEventListener(ModuleEvent.READY,function(e:ModuleEvent):void{
////				Alert.show((ml.factory==null).toString());
//				var m:Module=ml.factory.create() as Module;
//				tw.width=m.width;
//				tw.height=m.height;
//				m.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
////					Alert.show(FlexGlobals.topLevelApplication.hasEventListener(OperatorEvent.OPERATOR_LOGIN_TT));
//					tw.dispatchEvent(new OperatorEvent(OperatorEvent.OPERATOR_LOGIN_TT,null,true));
//				})
//				tw.addElement(m);
//			});
////			
//			ml.load();
//			Alert.show((ml.factory==null).toString());
//		   
//			m.addEventListener(ModuleEvent.READY,function(e:ModuleEvent):void{
//			
//				tw.addChild(m);
//			});
	       //tw.visible=false;
			if(parent==null&&_mdi==null)
				parent=FlexGlobals.topLevelApplication;
//			FlexGlobals.topLevelApplication.hasEventListener(OperatorEvent.OPERATOR_LOGIN_TT)
			if(_mdi!=null)
				parent=_mdi;
			PopUpManager.addPopUp(tw,parent as DisplayObject,true,null,parent.moduleFactory);
			
			if(iscenter){
				PopUpManager.centerPopUp(tw);
			}else{
			
//			Alert.show((x-tw.width).toString()+":"+x.toString());
				if(x+tw.width>1024)
					tw.x=x-2*tw.width-10;
				else 
					tw.x=x;
				tw.y=y;
			}
			effectStart(tw);
//			var clazz:Class = getDefinitionByName("skip.TitleWindowSkinClass") as Class;
			
//			tw.setStyle("skinClass", clazz);
//			Alert.show(tw.getChildAt(0).toString());
			return tw;
		}
		
		public  function getModuleWindow(url:String,bytes:ByteArray,data:Object=null,parent:Object=null,mdu:Boolean=true,ree:Boolean=false,rep:Boolean=false,x:Number=400,y:Number=300):ModuleLoader{
//			var tw:spark.components.TitleWindow=new spark.components.TitleWindow();
			//			tw.width=w;
			//			tw.height=h;
//			tw.alpha=0;
			
			//			tw.setStyle("backgroundColor","#1ff2ff");
			//			tw.setStyle("backgroundAlpha",0);
			//			tw.setStyle("color","#f2f3ff");
			var ml:ModuleLoader=new ModuleLoader();
//			PopUpManager.addPopUp(progressBar,FlexGlobals.topLevelApplication as DisplayObject,false);
//			PopUpManager.centerPopUp(progressBar);
//			tw.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
//				timer.addEventListener(TimerEvent.TIMER,function():void{
//					Alert.okLabel="稍后加载";
//					Alert.cancelLabel="继续加载";
//					timer.stop();
//					Alert.show("由于网络问题，加载时间太长，\n请选择网络好的时候再加载！","提示",Alert.OK|Alert.CANCEL,null,function(e:CloseEvent):void{
//						if(e.detail==Alert.OK){
//							ml.removeEventListener(ModuleEvent.READY,function():void{});
//							ml.unloadModule();
//							tw.removeAllElements();
//							PopUpManager.removePopUp(tw);
//							removeWinow(url);
//							timer.removeEventListener(TimerEvent.TIMER,function():void{});
//							PopUpManager.removePopUp(progressBar);
//						}else{
//							timer.start();
//						}
//						
//					});
//				});
//				timer.start();
				//				ml.percentHeight=100;
				//				ml.percentWidth=100;
				ml.addEventListener(ModuleEvent.READY,function(e:ModuleEvent):void{
//					tw.title=ml.child.name;
					//					tw.width=ml.child.width;
//					tw.titleDisplay.width=ml.child.width;
//					tw.titleDisplay.height=ml.child.height;
					//					tw.height=ml.child.height;
//					PopUpManager.removePopUp(progressBar);
				  
					
					windows.addItem({url:url,uid:ml});
//					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER,function():void{});
					ml.child.addEventListener(FlexEvent.CONTENT_CREATION_COMPLETE,function():void{
//						ml.x=(parent.screen.width-ml.child.loaderInfo.width)/2;
//						ml.y=(parent.screen.height-ml.child.loaderInfo.height)/2;
						
//						Alert.show(ml.child.loaderInfo.width.toString());
//												Alert.show(ml.toString());
//						move						trace("winproxy:"+ml.toString());
						if(rep){
							move.targets=[];
							move.duration=500;
							
							move.xTo=x;//x+tw.width;
							move.yTo=y;//y-tw.width;
							move.play([ml]);
						}else{
							if(ree){
									ml.x=(parent.screen.width-ml.child.loaderInfo.width)/2;
									ml.y=(parent.screen.height-ml.child.loaderInfo.height)/2;
							}else{
								move.targets=[];
								move.duration=500;
								
								move.xTo=(parent.screen.width-ml.child.loaderInfo.width)/2-80;
								move.yTo=(parent.screen.height-ml.child.loaderInfo.height)/2-40;
								move.play([ml]);
							}
							
						}
						
						if(data!=null)
							sendMessage(new MinnMessageEvent(ml.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,data,true));
					});
				});
				
//				tw.addElement(ml);
				ml.loadModule(url,bytes);
				
//			});
			ml.addEventListener(ModuleEvent.UNLOAD,function():void{
				PopUpManager.removePopUp(ml);
			});
			ml.addEventListener(CloseEvent.CLOSE,function(evt:CloseEvent):void{
				PopUpManager.removePopUp(progressBar);
				ml.removeEventListener(ModuleEvent.READY,function():void{});
				ml.unloadModule();
				
//				tw.removeAllElements();
//				fade.stop();
//				zoom.stop();
//				//				p=new Point(0,0);
//				move.duration=500;
//				
//				move.xTo=p.x;//x+tw.width;
//				move.yTo=p.y;//y-tw.width;
//				move.play([tw]);
//				
//				//				var zoom:Zoom=new Zoom();
//				zoom.duration=500;
//				zoom.zoomWidthTo=0.0;
//				zoom.zoomHeightTo=0.0;
//				zoom.play([tw]);
//				//				var fade:Fade=new Fade();
//				fade.duration=500;
//				fade.alphaFrom=1;
//				fade.alphaTo=0;
//				fade.play([tw]);
//				move.addEventListener(EffectEvent.EFFECT_END,function():void{
					PopUpManager.removePopUp(ml);
//					MDIManager.global.remove(ml);
					removeWinow(url);
//					if(move!=null)
//						move.targets=[];
//					if(fade!=null)
//						fade.targets=[];
//					if(zoom!=null)
//						zoom.targets=[];
//				});
			});
			
			if(parent==null)
				parent=FlexGlobals.topLevelApplication;
			//			FlexGlobals.topLevelApplication.hasEventListener(OperatorEvent.OPERATOR_LOGIN_TT)
			
			PopUpManager.addPopUp(ml,parent as DisplayObject,mdu,null,parent.moduleFactory);
						PopUpManager.centerPopUp(ml);
//			effectStart(tw);
			//			Alert.show((x-tw.width).toString()+":"+x.toString());
//			if(x+tw.width>1024)
//				tw.x=x-2*tw.width-10;
//			else 
//				tw.x=x;
//			tw.y=y;
			
			
		
			return ml;
		}
		public  function getCanvasWindow(url:String,data:Object=null,parent:Object=null,mdu:Boolean=true,x:Number=400,y:Number=300):HBox{
			var tw:HBox=new HBox();
			tw.setStyle("",0);
			//			tw.width=w;
			//			tw.height=h;
			var ml:ModuleLoader=new ModuleLoader();
			//			PopUpManager.addPopUp(progressBar,FlexGlobals.topLevelApplication as DisplayObject,false);
			//			PopUpManager.centerPopUp(progressBar);
			//			tw.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
			//				timer.addEventListener(TimerEvent.TIMER,function():void{
			//					Alert.okLabel="稍后加载";
			//					Alert.cancelLabel="继续加载";
			//					timer.stop();
			//					Alert.show("由于网络问题，加载时间太长，\n请选择网络好的时候再加载！","提示",Alert.OK|Alert.CANCEL,null,function(e:CloseEvent):void{
			//						if(e.detail==Alert.OK){
			//							ml.removeEventListener(ModuleEvent.READY,function():void{});
			//							ml.unloadModule();
			//							tw.removeAllElements();
			//							PopUpManager.removePopUp(tw);
			//							removeWinow(url);
			//							timer.removeEventListener(TimerEvent.TIMER,function():void{});
			//							PopUpManager.removePopUp(progressBar);
			//						}else{
			//							timer.start();
			//						}
			//						
			//					});
			//				});
			//				timer.start();
			//				ml.percentHeight=100;
			//				ml.percentWidth=100;
			ml.addEventListener(ModuleEvent.READY,function(e:ModuleEvent):void{
				//					tw.title=ml.child.name;
				//					tw.width=ml.child.width;
				//					tw.titleDisplay.width=ml.child.width;
				//					tw.titleDisplay.height=ml.child.height;
				//					tw.height=ml.child.height;
				//					PopUpManager.removePopUp(progressBar);
				
				
				windows.addItem({url:url,uid:ml});
				//					timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,function():void{});
				ml.child.addEventListener(FlexEvent.CONTENT_CREATION_COMPLETE,function():void{
					ml.x=(parent.screen.width-ml.child.loaderInfo.width)/2;
					ml.y=(parent.screen.height-ml.child.loaderInfo.height)/2;
					
					//						Alert.show(ml.child.loaderInfo.width.toString());
					//												Alert.show(ml.toString());
					//												trace("winproxy:"+ml.toString());
					if(data!=null)
						sendMessage(new MinnMessageEvent(ml.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,data,true));
				});
			});
			
			//				tw.addElement(ml);
			ml.loadModule(url);
			
			//			});
			ml.addEventListener(ModuleEvent.UNLOAD,function():void{
				PopUpManager.removePopUp(ml);
			});
			
			ml.addEventListener(CloseEvent.CLOSE,function():void{
				PopUpManager.removePopUp(progressBar);
				ml.removeEventListener(ModuleEvent.READY,function():void{});
				ml.unloadModule();
				//				tw.removeAllElements();
				//				fade.stop();
				//				zoom.stop();
				//				//				p=new Point(0,0);
				//				move.duration=500;
				//				
				//				move.xTo=p.x;//x+tw.width;
				//				move.yTo=p.y;//y-tw.width;
				//				move.play([tw]);
				//				
				//				//				var zoom:Zoom=new Zoom();
				//				zoom.duration=500;
				//				zoom.zoomWidthTo=0.0;
				//				zoom.zoomHeightTo=0.0;
				//				zoom.play([tw]);
				//				//				var fade:Fade=new Fade();
				//				fade.duration=500;
				//				fade.alphaFrom=1;
				//				fade.alphaTo=0;
				//				fade.play([tw]);
				//				move.addEventListener(EffectEvent.EFFECT_END,function():void{
				PopUpManager.removePopUp(ml);
				//					MDIManager.global.remove(ml);
				removeWinow(url);
				//					if(move!=null)
				//						move.targets=[];
				//					if(fade!=null)
				//						fade.targets=[];
				//					if(zoom!=null)
				//						zoom.targets=[];
				//				});
				
			});
			
			if(parent==null)
				parent=FlexGlobals.topLevelApplication;
			//			FlexGlobals.topLevelApplication.hasEventListener(OperatorEvent.OPERATOR_LOGIN_TT)
			
			PopUpManager.addPopUp(ml,parent as DisplayObject,mdu,null,parent.moduleFactory);
			return tw;
		}

		public  function getPopWinExplorer(url:String,bytes:ByteArray,_parent:DisplayObject,data:Object=null,inity:Number=100,initx:Number=380):PopWinExplorer{
			var win:PopWinExplorer=null;
			var ml:ModuleLoader=null;
			
			for(var i:int=0;i<popwins.length;i++){
				if(popwins[i].url==url){
					win=popwins[i].win;
				    ml=win.getChildAt(0) as ModuleLoader;
				}
			}
			if(win==null){
				win=new PopWinExplorer();
				win.titleIcon= popicon;
				//				win.controlBarVisible=true;
				ml=new ModuleLoader();
				ml.addEventListener(ModuleEvent.READY,function(evt:ModuleEvent):void{
					popwins.addItem({url:url,win:win});
					ml.child.addEventListener(FlexEvent.CONTENT_CREATION_COMPLETE,function():void{
						if(data!=null)
							sendMessage(new MinnMessageEvent(ml.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,data)); 
						
					});
					win.addElement(ml);	
					//					Alert.show(ml.child.name);
					win.title=ml.child.name;
					//					win.height=ml.child.height+50;
					//					Alert.show(win.height+'');
					//					win.width=ml.child.width+60;
					win.initX=initx;
					win.initY=inity;
					popmv.xTo=initx;
					popmv.yTo=inity;
					popmv.target=win;
					popmv.play();
				});
				win.addEventListener(CloseEvent.CLOSE,function():void{
					ml.unloadModule();
					win.removeAllElements();
					PopUpManager.removePopUp(win);
					removePopWinUrl(url);
					//					Alert.show(minpopwins.getItemIndex(win).toString());
					removeMinPopWin(win);
					moveminwin();
				});
				win.addEventListener(WinResizeProxyEvent.WIN_RESTORE_RESIZE,function():void{
					//					Alert.show("restore");
					if(win.showMaxBtn){
						win.showWeb=true;
					}
					removeMinPopWin(win);
					win.height=win.initH;
					win.width=win.initW;
					popmv.xTo=win.initX;
					popmv.yTo=win.initY;
					popmv.target=win;
					popmv.play();
					moveminwin();
				});
				win.addEventListener(WinResizeProxyEvent.WIN_MIN_RESIZE,function():void{
//					if(!minpopwins.contains(win))
					if(win.showMaxBtn){
						win.showWeb=false;
					}
					win.isMin=true;
					win.initH=win.measuredHeight;
					win.initW=win.measuredWidth;
					win.height=32;
					win.width=160;
					//				   Alert.show(minpopwins.length+'');
					popmv.xTo=269+160*(minpopwins.length)+2;
					//				   Alert.show((280*(minpopwins.length+1)).toString());
					popmv.yTo=25;
					popmv.target=win;
					popmv.play();
					if(!minpopwins.contains(win))
					minpopwins.addItem(win);
				});
				
				win.addEventListener(WinResizeProxyEvent.WIN_MAX_RESIZE,function(evt:WinResizeProxyEvent){
					win.showMaxBtn=true;
					win.showWeb=true;
					removeMinPopWin(win);
					win.isMax=true;
					win.width=Application.application.screen.width-20;
					win.height=Application.application.screen.height-20;
					popmv.xTo=8;
					//				   Alert.show((280*(minpopwins.length+1)).toString());
					popmv.yTo=0;
					popmv.target=win;
					popmv.play();
					moveminwin();
				});
				
				win.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE,function(evt:FlexMouseEvent):void{
					if(!win.isMin){
						if(win.showMaxBtn){
							win.showWeb=false;
						}
						win.isMin=true;
						win.initH=win.measuredHeight;
						win.initW=win.measuredWidth;
						win.height=32;
						win.width=160;
						//				   Alert.show(minpopwins.length+'');
						popmv.xTo=269+160*(minpopwins.length)+2;
						//				   Alert.show((280*(minpopwins.length+1)).toString());
						popmv.yTo=25;
						popmv.target=win;
						popmv.play();
						if(!minpopwins.contains(win))
						minpopwins.addItem(win);
					}
				});
				ml.loadModule(url,bytes);
				if(_parent==null)
					_parent=FlexGlobals.topLevelApplication  as DisplayObject;
				PopUpManager.addPopUp(win,_parent);
				PopUpManager.centerPopUp(win);
				
				
				//				_mdic.windowManager.add(win);
				//				_mdic.windowManager.addCenter(win);
				//				(_parent as MDICanvas).windowManager.addCenter(win);
				//				PopUpManager.addPopUp(win,_parent):
				//				_mdi.windowManager.add(win);
				//				_mdi.windowManager.absPos(win,0,0);
			}else{
				//				_mdic.windowManager.bringToFront(win);
				//				PopUpManager.bringToFront(win);
				//				(_parent as MDICanvas).windowManager.bringToFront(win);
//				Alert.show("winproxy:"+ml.toString());
				if(data!=null)
					sendMessage(new MinnMessageEvent(ml.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,data)); 
			}
			
			
			return win;
			
		}
		
		private function moveminwin():void{
			for(var i:int=0;i<minpopwins.length;i++){
				var win:*=minpopwins.getItemAt(i);
				win.isMin=true;
				win.initH=win.measuredHeight;
				win.initW=win.measuredWidth;
				win.height=32;
				win.width=160;
				//				   Alert.show(minpopwins.length+'');
				popmv.xTo=269+160*i+2;
				//				   Alert.show((280*(minpopwins.length+1)).toString());
				popmv.yTo=25;
				popmv.target=win;
				popmv.play();
			}
		}
		
		public  function getPopWin(url:String,bytes:ByteArray,_parent:DisplayObject,data:Object=null,inity:Number=100,initx:Number=380):PopWin{
			var win:PopWin=null;
			var ml:ModuleLoader=null;
			
			for(var i:int=0;i<popwins.length;i++){
				if(popwins[i].url==url)
					win=popwins[i].win;
			}
			if(win==null){
				win=new PopWin();
				win.titleIcon= popicon;
				//				win.controlBarVisible=true;
				ml=new ModuleLoader();
				ml.addEventListener(ModuleEvent.READY,function(evt:ModuleEvent):void{
					popwins.addItem({url:url,win:win});
				   
					ml.child.addEventListener(FlexEvent.CONTENT_CREATION_COMPLETE,function():void{
//						Alert.show("proxy:"+ml.toString());
//						win.height=ml.child.height;
//						win.width=ml.child.width;
						if(data!=null){
							sendMessage(new MinnMessageEvent(ml.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,data));
						}
						
					});
					win.addChild(ml);	
//										Alert.show(ml.child.name);
					win.title=ml.child.name;
					//					win.height=ml.child.height+50;
					//					Alert.show(win.height+'');
					//					win.width=ml.child.width+60;
					win.initX=initx;
					win.initY=inity;
					popmv.xTo=initx;
					popmv.yTo=inity;
					popmv.target=win;
					popmv.play();
				});
				win.addEventListener(CloseEvent.CLOSE,function():void{
					ml.unloadModule();
					win.removeAllElements();
					PopUpManager.removePopUp(win);
					removePopWinUrl(url);
					//					Alert.show(minpopwins.getItemIndex(win).toString());
					removeMinPopWin(win);
					moveminwin();
				});
				win.addEventListener(WinResizeProxyEvent.WIN_RESTORE_RESIZE,function():void{
					//					Alert.show("restore");
					removeMinPopWin(win);
					win.height=win.initH;
					win.width=win.initW;
					popmv.xTo=win.initX;
					popmv.yTo=win.initY;
					popmv.target=win;
					popmv.play();
					//					Alert.show(minpopwins.getItemIndex(win).toString());
					win.percentHeight=100;
					win.percentWidth=100;
					moveminwin();
				});
				win.addEventListener(WinResizeProxyEvent.WIN_MIN_RESIZE,function(evt:WinResizeProxyEvent):void{
					//					Alert.show('outsize win resize:'+win.measuredHeight);
					//					win.title=ml.child.name;
					//				   win.initX=win.x;
					//				   win.initY=win.y;
//					var win:PopWin=evt.target as PopWin;
//					if(!minpopwins.contains(win))
					
					win.isMin=true;
					win.initH=win.measuredHeight;
					win.initW=win.measuredWidth;
					win.height=32;
					win.width=160;
					//				   Alert.show(minpopwins.length+'');
					popmv.xTo=269+160*(minpopwins.length)+2;
					//				   Alert.show((280*(minpopwins.length+1)).toString());
					popmv.yTo=25;
					popmv.target=win;
					popmv.play();
					if(!minpopwins.contains(win))
						minpopwins.addItem(win);
				});
				win.addEventListener(WinResizeProxyEvent.WIN_MAX_RESIZE,function(evt:WinResizeProxyEvent){
					win.isMax=true;
					win.width=Application.application.screen.width-20;
					win.height=Application.application.screen.height-20;
					popmv.xTo=8;
					//				   Alert.show((280*(minpopwins.length+1)).toString());
					popmv.yTo=0;
					popmv.target=win;
					popmv.play();
					//					Alert.show(minpopwins.getItemIndex(win).toString());
					removeMinPopWin(win);
				});
				
//				win.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE,function():void{
////					var win:PopWin=evt.target as PopWin;
////					if(!minpopwins.contains(win))
////						minpopwins.addItem(win);
//					if(!win.isMin){
//					win.isMin=true;
//					win.initH=win.measuredHeight;
//					win.initW=win.measuredWidth;
//					win.height=32;
//					win.width=160;
//					//				   Alert.show(minpopwins.length+'');
//					popmv.xTo=269+160*(minpopwins.length)+2;
//					//				   Alert.show((280*(minpopwins.length+1)).toString());
//					popmv.yTo=25;
//					popmv.target=win;
//					popmv.play();
//					if(!minpopwins.contains(win))
//						minpopwins.addItem(win);
//					}
//				});
				ml.loadModule(url,bytes);
				PopUpManager.addPopUp(win,_parent);
				PopUpManager.centerPopUp(win);
				
				
				//				_mdic.windowManager.add(win);
				//				_mdic.windowManager.addCenter(win);
				//				(_parent as MDICanvas).windowManager.addCenter(win);
				//				PopUpManager.addPopUp(win,_parent):
				//				_mdi.windowManager.add(win);
				//				_mdi.windowManager.absPos(win,0,0);
			}else{
				//				_mdic.windowManager.bringToFront(win);
				//				PopUpManager.bringToFront(win);
				//				(_parent as MDICanvas).windowManager.bringToFront(win);
				ml=win.getChildAt(0) as ModuleLoader;
				if(data!=null){
					sendMessage(new MinnMessageEvent(ml.toString()+MinnMessageEvent.CREATIONCOMPLETE_MESSAGE,data));
				
				win.isMin=false;
				if(win.x!=win.initX){
				removeMinPopWin(win);
				win.height=win.initH;
				win.width=win.initW;
				popmv.xTo=win.initX;
				popmv.yTo=win.initY;
				popmv.target=win;
				popmv.play();
				//					Alert.show(minpopwins.getItemIndex(win).toString());
				win.percentHeight=100;
				win.percentWidth=100;
				PopUpManager.bringToFront(win);
				moveminwin();
				}
				}
				
			}
			
			
			return win;
			
		}
		private function removeMinPopWin(win:Object):void{
			if(minpopwins.getItemIndex(win)!=-1)
				minpopwins.removeItemAt(minpopwins.getItemIndex(win));
		}
		private  function removePopWinUrl(url:String):void{
			for(var i:int=0;i<popwins.length;i++){
				var o:Object=popwins.getItemAt(i);
				if(o.url==url){
					popwins.removeItemAt(i);
					//					minpopwins.removeItemAt(minpopwins.getItemIndex(o.win));
				}
			}
		}
		private function effectStart(obj:*,iszoom:Boolean=false):void{
			fade.stop();
			zoom.stop();
			fade.targets=[];
			zoom.targets=[];
			fade.duration=2500;
			fade.alphaFrom=0;
			fade.alphaTo=1;
			fade.play([obj]);
			zoom.duration=2000;
			zoom.zoomWidthTo=1.1;
			zoom.zoomHeightTo=1.1;
			if(iszoom)
			zoom.play([obj]);
			
		}
		
		public function checkExistWindow(url:String):*{
			for(var i:int=0;i<windows.length;i++){
				var objw:Object=windows[i];
				if(objw.url==url)
					return objw.uid;
			}
			return null;
		}
		
		private function removeWinow(url:String=null):void{
			if(url!=null){
				for(var i:int=0;i<windows.length;i++){
					var objw:Object=windows.getItemAt(i);
					if(objw.url==url){
						windows.removeItemAt(i);
					}
				}
			}else{
				windows.removeAll();
			}
			try
			{
			if(windows.length%3==0||windows.length==0){
				var lc1:LocalConnection = new LocalConnection();
				var lc2:LocalConnection = new LocalConnection();
				lc1.connect( "gcConnection" );
				lc2.connect( "gcConnection" );
			}
			}
			catch (e:Error)
			{
			}
		}
		
		public function showAllWindow():void{
			_mdi.windowManager.cascade();
		}
		public function removeAllWindow():void{
			for(var i:int=0;i<windows.length;i++){
				var objw:Object=windows.getItemAt(i);
				PopUpManager.removePopUp(objw.uid as IFlexDisplayObject);
			}
			_mdi.windowManager.removeAll();
			removeWinow();
		}
	}
}