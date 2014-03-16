// ActionScript file
/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
include "../base/BaseObjectImport.as"; 
import flexmdi.containers.MDIWindow;
import flexmdi.events.MinnMessageEvent;
import flexmdi.events.MinnMessageEventManager;

import minn.proxy.WindowProxy;
import minn.util.MinnUtil;

import mvc.controller.ControllerCommand;
import mvc.controller.ControllerService;
import mvc.model.order.OrderProxy;
import mvc.view.front.product.event.ProductListEvent;

import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
private var me:MinnMessageEvent;
private var mem:MinnMessageEventManager;
private var me1:ProductListEvent;
import minn.common.Circle;
import minn.common.DrawLine;
import minn.common.Triangle;

import mx.containers.Form;
import mx.containers.FormItem;
import mx.containers.HBox;
import mx.containers.Panel;
import mx.containers.TabNavigator;
import mx.containers.TitleWindow;
import mx.controls.Button;
import mx.controls.CheckBox;
import mx.controls.LinkButton;
import mx.controls.SWFLoader;
import mx.controls.Spacer;
import mx.core.UIComponent;
import mx.effects.Move;
import mx.effects.Resize;
import mx.events.Request;
import mx.managers.PopUpManager;
import mx.modules.Module;
import mx.modules.ModuleLoader;
import mx.modules.ModuleManager;
import mx.rpc.remoting.RemoteObject;
import mx.skins.halo.ButtonSkin;
import mx.states.State;
import mx.states.Transition;
import com.adobe.serialization.json.JSON;
import com.hurlant.crypto.Crypto;
import com.hurlant.crypto.symmetric.ICipher;
import com.hurlant.util.der.ByteString;
import com.adobe.serialization.json.JSON;
import mx.controls.ProgressBar;
import mx.managers.PopUpManager;
import flexmdi.containers.IFrame;
import flexmdi.containers.PopWin;
import flexmdi.containers.ToolTipWin;

import minn.common.Entrypt;
import minn.common.IFrame;
import minn.message.Message;
import mx.rpc.events.FaultEvent;
import mvc.model.merchandise.vo.Product;
import mvc.model.user.vo.User;

import com.adobe.ac.mxeffects.DistortionConstants;
import com.adobe.ac.mxeffects.Flip;

import flexmdi.containers.ToolTipWin;

import minn.common.DrawLine;
import minn.common.Entrypt;
import minn.common.Rect;
import minn.message.Message;

import mvc.model.merchandise.vo.Product;
import mvc.model.user.vo.User;
//import mvc.view.front.product.component.ShopCard;
import mvc.view.front.user.component.ExitOrModify;

import mx.collections.ArrayCollection;
import mx.controls.Menu;
import mx.effects.Blur;
import mx.effects.Move;
import mx.effects.Resize;
import mx.events.EffectEvent;
import mx.events.ItemClickEvent;
import mx.events.MenuEvent;
import mx.managers.PopUpManager;
import mx.modules.Module;
import mx.rpc.remoting.RemoteObject;
import book.controls.FlexBook;
import book.controls.flexBookClasses.FlexBookEvent;

import com.adobe.ac.mxeffects.Distortion;
import com.adobe.ac.mxeffects.effectClasses.DistortBaseInstance;
import spark.components.ButtonBarButton;
import spark.components.TitleWindow;
import spark.components.Panel;

import flexmdi.events.MinnMessageEvent;
import flexmdi.events.MinnMessageEventManager;
import flexmdi.events.winresize.WinResizeProxyEvent;

import minn.message.Message;
import minn.util.MinnUtil;

import mx.events.ValidationResultEvent;
import mx.managers.PopUpManager;
import mx.validators.ValidationResult;
import mx.validators.Validator;
import mx.events.ListEvent;
import com.roguedevelopment.pulse.particle.LineParticle;
import mx.core.IUIComponent;
import com.roguedevelopment.pulse.particle.GenericParticle;

private var tw:ToolTipWin;
private var wp:WindowProxy;
private var _ti:Timer;
private var _btn:Button;
private var _tw:spark.components.TitleWindow;
private var _p:mx.containers.Panel;
private var __p:spark.components.Panel;
private var _w:PopWin;
private var _ckb:CheckBox;
private var _f:Form;
private var _fi:FormItem;
private var _hb:HBox;
private var _mv:Move;
private var _rz:Resize;
private var _lb:LinkButton;
private var _bsb:ButtonSkin;
private var _sp:Spacer;
private var _pm:PopUpManager;
private var _st:State;
private var _st1:Transition;
private var _mm:MinnMessageEvent;
private var _tn:TabNavigator;
private var _pb:ProgressBar;
//private var _li:LineParticle;
//private var _l1:IUIComponent;
//private var _ger:GenericParticle;
//private var _tmr:Timer;
