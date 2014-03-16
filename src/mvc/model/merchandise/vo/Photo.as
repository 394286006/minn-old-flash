/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.model.merchandise.vo
{
	[RemoteClass(alias="merchandise.Photo")]   
	[Bindable]   
	public class Photo
	{
		public var _sid:String='';
		public var id:String='';
		public var mcd_id:String='';
//		public var name_cn:String='';
		public var imgname:String='';
		public var imgpath:String='';
		public var creator:String='';
		public var createDate:String='';
		public var isfirst:String='';
		public var phone_order:int;
		public var level1type:String='';
		public var level2type:String='';
		public var sourcename:String='';
		public function Photo()
		{
		}
	}
}