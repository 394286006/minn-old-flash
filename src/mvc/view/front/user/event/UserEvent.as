/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.user.event
{
	import flash.events.Event;
	
	public class UserEvent extends Event
	{
		
		public static const USER_LOGIN:String="USER_LOGIN";
		public static const USER_LOGIN_RESULT:String="USER_LOGINRESULT";
		
		public static const USER_CANCEL:String="USER_CANCEL";		
		
		public static const USER_REGISTER:String="USER_REGISTER";		
		public static const USER_REGISTERR_ESULT:String="USER_REGISTERR_ESULT";
		
		public static const USER_ADD:String="USER_ADD";
		public static const USER_ADD_RESULT:String="USER_ADD_RESULT";
		
		public static const USER_MODIFY:String="USER_MODIFY";
		public static const USER_MODIFY_RESULT:String="USER_MODIFY_RESULT";
		
		public static const USER_DEL:String="USER_DEL";
		public static const USER_DEL_RESULT:String="USER_DEL_RESULT";
		
		public static const USER_QUERY:String="USER_QUERY";
		public static const USER_QUERY_RESULT:String="USER_QUERY_RESULT";
		
		private var _data:Object;
		
		public function UserEvent(type:String, data:Object=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._data=data;
		}
		
		public function get data():Object{
			return this._data;
		}
		
		public function set data(v:Object):void{
			this._data=v;
		}
	}
}