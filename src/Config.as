/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package
{
	public class Config
	{
		private static var _BASE_URL:String = "http://127.0.0.1:8009/minn/";
//		private static var _BASE_URL:String = "http://www.minwwls.com/";
		private static var _UPLOAD_URL:String = BASE_URL+"services/upload/upLoad.php";
		private static var _UPLOAD_DIR:String = BASE_URL+"services/uploadfile/";
		private static var _UPLOAD_AD_DIR:String = "services/advertise/uploadad/";
		private static var _UPLOAD_DIR_IMALEVEL1:String = BASE_URL+"services/uploadfile/imglevel1/";
		private static var _UPLOAD_DIR_IMALEVEL2:String = BASE_URL+"services/uploadfile/imglevel2/";
		private static var _ADVERTISE_MENU:String = BASE_URL+"services/data/advertise.txt";
		private static var _CATEGORY_MENU:String = BASE_URL+"services/data/category.txt";
		private static var _AREA_MENU:String = BASE_URL+"services/data/area.txt";
		private static var _FIRST_PAGE:String = BASE_URL+"services/data/firstpic.txt";
		private static var _PUBLIC_MESSAGE:String = BASE_URL+"services/data/publicmessage.txt";
		private static var _ORDER_POLLING:String = BASE_URL+"services/polling/polling.php";
		private static var _KEY_LOADER:String = BASE_URL+"services/test/test.php";
		private static var _PRIVATE_KEY_LOADER:String = BASE_URL+"services/test/securityRamdom.php";
		private static var _MAIN_APP:String = BASE_URL+"mainApp.jpg";
		public static var SUBFFIX:String=".swf";
		public static var FLAG:String=".swf";
//		public static var SUBFFIX:String=".jpg";
		public function Config()
		{
		}
		
		public static function get  BASE_URL():String{
			return _BASE_URL;
		}
		
		public static function set BASE_URL(url:String):void{
			_BASE_URL=url;
		}
		
		public static function get  UPLOAD_URL():String{
			return _UPLOAD_URL;
		}
		
		public static function set UPLOAD_URL(url:String):void{
			_UPLOAD_URL= BASE_URL+url;
		}
		
		public static function get  UPLOAD_DIR():String{
			return _UPLOAD_URL;
		}
		
		public static function set UPLOAD_DIR(url:String):void{
			_UPLOAD_DIR= BASE_URL+url;
		}
		
		public static function get  UPLOAD_DIR_IMALEVEL1():String{
			return _UPLOAD_DIR_IMALEVEL1;
		}
		
		public static function set UPLOAD_DIR_IMALEVEL1(url:String):void{
			_UPLOAD_DIR_IMALEVEL1=BASE_URL+url;
		}
		
		
		public static function get  UPLOAD_DIR_IMALEVEL2():String{
			return _UPLOAD_DIR_IMALEVEL2;
		}
		
		public static function set UPLOAD_DIR_IMALEVEL2(url:String):void{
			_UPLOAD_DIR_IMALEVEL2=BASE_URL+url;
		}
		
		public static function get  CATEGORY_MENU():String{
			return _CATEGORY_MENU;
		}
		
		public static function set CATEGORY_MENU(url:String):void{
			_CATEGORY_MENU=BASE_URL+url;
		}
		
		public static function get  AREA_MENU():String{
			return _AREA_MENU;
		}
		
		public static function set AREA_MENU(url:String):void{
			_AREA_MENU=BASE_URL+url;
		}
		
		public static function get  FIRST_PAGE():String{
			return _FIRST_PAGE;
		}
		
		public static function set FIRST_PAGE(url:String):void{
			_FIRST_PAGE=BASE_URL+url;
		}
		
		public static function get  ORDER_POLLING():String{
			return _ORDER_POLLING;
		}
		
		public static function set ORDER_POLLING(url:String):void{
			_ORDER_POLLING=BASE_URL+url;
		}
		
		public static function get  KEY_LOADER():String{
			return _KEY_LOADER;
		}
		
		public static function set KEY_LOADER(url:String):void{
			_KEY_LOADER=BASE_URL+url;
		}
		
		public static function get  MAIN_APP():String{
			return _MAIN_APP;
		}
		
		public static function set MAIN_APP(url:String):void{
			_MAIN_APP=BASE_URL+url;
		}
		
		public static function get  PRIVATE_KEY_LOADER():String{
			return _PRIVATE_KEY_LOADER;
		}
		
		public static function set PRIVATE_KEY_LOADER(url:String):void{
			_PRIVATE_KEY_LOADER=BASE_URL+url;
		}
		public static function get  PUBLIC_MESSAGE():String{
			return _PUBLIC_MESSAGE;
		}
		
		public static function set PUBLIC_MESSAGE(url:String):void{
			_PUBLIC_MESSAGE=BASE_URL+url;
		}
		public static function get  UPLOAD_AD_DIR():String{
			return _UPLOAD_AD_DIR;
		}
		
		public static function set UPLOAD_AD_DIR(url:String):void{
			_UPLOAD_AD_DIR= BASE_URL+url;
		}
		public static function get  ADVERTISE_MENU():String{
			return _ADVERTISE_MENU;
		}
		
		public static function set ADVERTISE_MENU(url:String):void{
			_ADVERTISE_MENU= BASE_URL+url;
		}
	}
}