/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.merchandise.vo
{
	[RemoteClass(alias="merchandise.Discount")]   
	[Bindable] 
	public class Discount
	{
		public var _sid:String='';
		public var id:String='';
		public var type:String='2';
		public var dc_id:String='';
		public var creator:String='';
		public var createDate:String='';
		public var percend:String='';
		public function Discount()
		{
		}
	}
}