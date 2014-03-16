/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package
{
	import com.adobe.ac.mxeffects.DistortionConstants;
	import com.adobe.ac.mxeffects.Flip;
	import com.flashdynamix.motion.effects.core.ColorEffect;
	import com.flashdynamix.motion.effects.core.FilterEffect;
	import com.flashdynamix.motion.extras.Emitter;
	import com.flashdynamix.motion.layers.BitmapLayer;
	
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.engine.SpaceJustifier;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import flexmdi.events.MinnMessageEvent;
	import flexmdi.events.MinnMessageEventManager;
	
	import minn.common.DrawLine;
	import minn.common.Entrypt;
	import minn.common.MenuLabel;
	import minn.proxy.WindowProxy;
	
	import mvc.model.merchandise.vo.Product;
	import mvc.model.user.vo.User;
	import mvc.view.front.order.component.commit.CommitOrderPanel;
	import mvc.view.front.order.component.show.AlipayFrame;
	import mvc.view.front.order.component.show.AlipayFrame2;
	import mvc.view.front.order.event.OrderEvent;
	import mvc.view.front.product.component.SearchProductPanel;
	import mvc.view.front.product.component.ShopCard;
	import mvc.view.front.product.component.ShowProductPanel;
	import mvc.view.front.product.event.ProductDetailEvent;
	import mvc.view.front.product.event.ProductListEvent;
	import mvc.view.front.user.component.ExitOrModify;
	import mvc.view.front.user.component.LoginOrRegister;
	import mvc.view.front.user.component.LoginOrRegisterPanel;
	import mvc.view.front.user.component.LoginPanel;
	import mvc.view.front.user.component.RegisterPanel;
	
	import mx.collections.ArrayCollection;
	import mx.containers.ApplicationControlBar;
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.Panel;
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.controls.Menu;
	import mx.controls.SWFLoader;
	import mx.controls.Spacer;
	import mx.controls.ToggleButtonBar;
	import mx.controls.VRule;
	import mx.core.UIComponent;
	import mx.effects.Blur;
	import mx.effects.Move;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.ItemClickEvent;
	import mx.events.MenuEvent;
	import mx.events.ModuleEvent;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	import mx.modules.Module;
	import mx.modules.ModuleLoader;
	
	import spark.components.ButtonBar;
	import spark.effects.Resize;
	
	public class ModuleImp extends Module
	{
		[Bindable]
		public var user:User=null; 
		public function ModuleImp()
		{
			super();
		}
	}
}