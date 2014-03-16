
package book.controls.flexBookClasses
{
	import flash.events.Event;
	import mx.core.IFlexDisplayObject;

	public class FlexBookEvent extends Event
	{
		public function FlexBookEvent(type:String, bubbles:Boolean, cancelable:Boolean, index:Number, content:*, renderer:IFlexDisplayObject)
		{
			this.index = index;
			this.content = content;
			this.renderer = renderer;
			super(type, bubbles, cancelable);
		}
		
		public var index:Number;
		public var content:*;
		public var renderer:IFlexDisplayObject;
		
		public static const TURN_START:String = "turnStart";
		public static const TURN_END:String = "turnEnd";
		
	}
}