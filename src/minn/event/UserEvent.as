/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.event
{
	import flash.events.Event;
	
	public class UserEvent extends Event
	{
		public static const LOGIN:String="login";
		public static const CANCEL:String="cancel";		
		public static const LOGINRESULT:String="loginReslut";
		public static const REGISTER:String="register";		
		public static const REGISTERRESULT:String="registerResult";
		
		public function UserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}