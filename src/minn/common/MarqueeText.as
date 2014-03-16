/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.common
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.controls.Text;
	
	public class MarqueeText extends  Text
	{
		public var inith:Number;
		public function MarqueeText()
		{
			super();
			addEventListener(MouseEvent.ROLL_OVER,mouseHandler);
			addEventListener(MouseEvent.ROLL_OUT,mouseHandler);

		}
		private function mouseHandler(evt:MouseEvent):void{
			
			switch(evt.type){
				case MouseEvent.ROLL_OVER:
					htmlText="<font color='#F4BB83'>"+data.content+"</font>[<font color='#F4BB83'>"+data.modifyDate+"</font>]";
					break;
				case MouseEvent.ROLL_OUT:
					htmlText="<font color='#BEBCC0'>"+data.content+"</font>[<font color='#666fff'>"+data.modifyDate+"</font>]";
					break;
			}
		}
		
//		public function get data():Object{
//			return _data;
//		}
		
//		public function set data(_d:Object):void{
//			this._data=_d;
//		}
		
	}
}