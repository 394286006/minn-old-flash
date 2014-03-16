// ActionScript file
/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
var req:URLRequest=null;
var loader:URLLoader=null;
private function orderListener():void{
	req = new URLRequest(Config.ORDER_POLLING);
	loader = new URLLoader();
	loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatusChange);
	loader.addEventListener(Event.COMPLETE, onComplete);
	loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
	loader.load(req);
}

private function onStatusChange(event:HTTPStatusEvent):void
{
	//				this.txtLogs.text += 'Status changed to '+ String(event.status)+'\n';
	//				Alert.show("HTTPStatusEvent:"+event.toString());
}


// result returned
private function onComplete(event:Event):void
{
	//				this.txtLogs.text += 'Completed! Result is '+String(event.currentTarget.data)+'\n';
	//				this.txtLogs.text += 'Start another request!\n';
	//				this.startRequest();
	Alert.show("onComplete:"+event.currentTarget.data);
}

// error handler
private function onIOError(event:IOErrorEvent):void
{
	//				this.txtLogs.text += 'IO Error: '+String(event)+'\n';
	//				this.stopRequest();
	Alert.show("IOErrorEvent:"+event.toString());
}