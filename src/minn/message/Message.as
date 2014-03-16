/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package minn.message
{
	public class Message
	{
		
		private var _messageSucess:int;
		private var _messageType:String;
		private var _messageBody:*;
		private var _otherInfo:Object;
		/**
		 * @param messageSucess 0=失败，1=成功
		 * @param messageType 说明messageBody的类型
		 * @param messageBody 信息内容
		 * @param otherInfo 可附带的其它信息
		 */
		public function Message(messageSucess:int,messageType:String, messageBody:*,otherInfo:Object=null)
		{
			this._messageSucess=messageSucess;
			this._messageType=messageType;
			this._messageBody=messageBody;
			this._otherInfo=otherInfo;
		}
		
		
		public function get otherInfo():Object
		{
			return _otherInfo;
		}

		public function set otherInfo(value:Object):void
		{
			_otherInfo = value;
		}

		public function get messageBody():*
		{
			return _messageBody;
		}

		public function set messageBody(value:*):void
		{
			_messageBody = value;
		}

		public function get messageSucess():int
		{
			return _messageSucess;
		}

		public function set messageSucess(value:int):void
		{
			_messageSucess = value;
		}

		public function get messageType():String
		{
			return _messageType;
		}

		public function set messageType(value:String):void
		{
			_messageType = value;
		}

		
	}
}