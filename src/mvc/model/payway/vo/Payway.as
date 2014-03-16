/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.payway.vo
{
	[RemoteClass(alias="operator.Operator")]   
	[Bindable]   
	public class Payway
	{
		public var _sid:String='';
		public var id:String='';
		public var name:String='';
		public var descript:String='';
		public var paynum:Number=0;
		public var creator:String='';
		public var createDate:String='';
		
		private var _color:int=0;
		public function set color(c:int):void{
			this._color=c;
		}
		public function get color():int
		{
			return _color;
		}
		public function Payway()
		{
		}
	}
}