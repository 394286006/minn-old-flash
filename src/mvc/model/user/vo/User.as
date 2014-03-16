/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.user.vo
{

	[RemoteClass(alias="user.User")]   
	[Bindable]   
	public class User
	{
		public var _sid:String='';
		public var id:String='';
		public var userName_en:String='';
		public var password:String='';
		public var userName_ch:String='';
		public var email:String='';
		public var qq_msn:String='';
		public var backemail:String='';
		public var country:String='';
		public var city:String='';
		public var zip:String='';
		public var homePhone:String='';
		public var officePhone:String='';
		public var detailAddress:String='';
		//public var creator:String='';
		
		public var createDate:String='';
		
		private var _color:int=0;
		public function set color(c:int):void{
			this._color=c;
		}
		public function get color():int
		{
			return _color;
		}
		
		public function User()
		{
			
		}
	}
}