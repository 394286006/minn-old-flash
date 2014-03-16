package mvc.view.front.product.component
{
	import flash.events.MouseEvent;
	
	import mvc.model.merchandise.vo.Product;
	
	import mx.containers.Panel;
	import mx.controls.Alert;
	import mx.effects.Move;
	
	import skin.BookBtnSkin;
	
	import spark.components.Button;
	
	public class ShowProductPanel extends Panel
	{
		private var pd:ProductDetails=null;
		private var showprowin_mv:Move=new Move();
		private var isFirstShow:Boolean=true;
		private var hasShow:int=0;
		public function ShowProductPanel()
		{
			super();
			width=800;
			height=505;
			y=-800;
			layout="absolute";
		
			horizontalScrollPolicy="off";
			verticalScrollPolicy="off";
			
		}
		
		override protected function createChildren():void{
			super.createChildren();
			 pd=new ProductDetails();
			this.addElement(pd);
			var btn:Button=new Button();
			btn.x=750;
			btn.y=5
			btn.height=32;
			btn.width=32;
			btn.setStyle("skinClass",Class(skin.BookBtnSkin));
			btn.useHandCursor=true;
			btn.buttonMode=true;
            btn.addEventListener(MouseEvent.CLICK,dispClose);
			this.addElement(btn);
			showprowin_mv.target=this;
			showprowin_mv.duration=2000;
		}
		public function dispClose(evt:MouseEvent=null):void{
//			this.dispatchEvent(=
			showprowin_mv.yTo=-800;
			showprowin_mv.play();
		}
		public function showDetail(p:Product):void{
//			if(isFirstShow){
//				isFirstShow=false;
//				hasShow+=1;
				showprowin_mv.yTo=50;
//			}
			showprowin_mv.play();
			pd.currentState="detail";
		    pd.product=p;
		}
	}
}