/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.user.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import flexmdi.containers.PopWin;
	import flexmdi.events.MinnMessageEvent;
	
	import minn.common.MenuLabel;
	import minn.message.Message;
	import minn.util.MinnUtil;
	
	import mvc.controller.ControllerCommand;
	import mvc.controller.ControllerService;
	import mvc.model.user.UserProxy;
	import mvc.model.user.vo.User;
	
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.containers.HBox;
	import mx.controls.Alert;
	import mx.controls.Label;
	import mx.controls.Spacer;
	import mx.controls.TextInput;
	import mx.effects.Fade;
	import mx.events.FlexEvent;
	import mx.events.StateChangeEvent;
	import mx.events.ValidationResultEvent;
	import mx.managers.PopUpManager;
	import mx.states.State;
	import mx.states.Transition;
	import mx.validators.EmailValidator;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import skin.ButtonSkin;
	import skin.ShopCardBtn;
	
	import spark.components.Button;

	public class LoginOrRegisterPanel extends PopWin
	{
		[Bindable]
		private var user:User=null;
		
		private var userProxy:UserProxy=null;
		public function LoginOrRegisterPanel()
		{
			super();
			name="登陆";
			creationPolicy="all";
			this.percentHeight=100;
			this.percentWidth=100;
			layout="vertical" ;
//			this.setStyle("backgroundColor", "#a78b6f");
			this.setStyle("verticalGap",0);
			this.setStyle("fontSize",13);
				this.addEventListener(FlexEvent.CREATION_COMPLETE,module1_creationCompleteHandler);
				this.addEventListener(FlexEvent.REMOVE,module1_removeHandler);
				this.addEventListener(StateChangeEvent.CURRENT_STATE_CHANGE,popwin1_currentStateChangeHandler);
		}
		protected function module1_removeHandler(event:Event):void
		{
		}
		
		protected function module1_creationCompleteHandler(event:FlexEvent):void
		{
		}
		public function messageHandler(val:Object):void{
			//				Alert.show(e.data.toString());
			var type:String=val.type;
			//				if(val.type=="modify")
			//                     this.currentState=type;
			if(val.hasOwnProperty("item")){
				user=val.item as User;
				//					Alert.show(user.backemail);
				//					userName_ch_id.text=user.userName_ch;
				//					userName_en_id.text=user.userName_en;
				//					password_id.text=user.password;
				//					email_id.text=user.email;
				//					qq_msn_id.text=user.qq_msn;
			}
			//					currentState=type;
			
			//				}
		}
		private function click_Handler(evt:Event):void{
			
			//				Alert.show(this.parent.parent.toString());
			var validatorErrorArray:Array = Validator.validateAll(validatorArray); 
			var err:ValidationResultEvent; 
			var errorMessageArray:Array = []; 
			if(validatorErrorArray.length>0){
				for each (err in validatorErrorArray) { 
					errorMessageArray.push(err.message); 
				} 
				if(errorMessageArray.length >0){
					Alert.show(errorMessageArray.join("\n\n"), "请按照以下错误提示信息重新填写", Alert.OK,this.parentApplication as Sprite);
					
					return;
				}
			}
			
			if(userProxy==null)
				userProxy=ControllerService.getInstance(ControllerCommand.USER_PROXY);
			if(currentState=='Register'){
				if(password_id.text!=confirm_id.text){
					Alert.show("确认密码不正确!","提示",4,this.parentApplication as Sprite);
					confirm_id.text="";
					password_id.text="";
					return;
				}
				user=new User();
				user._sid=this.parentApplication.PRIVATEKEY;
				user.userName_ch=userName_ch_id.text;
				user.userName_en=userName_en_id.text;
				user.password=password_id.text;
				user.email=email_id.text;
				user.qq_msn=qq_msn_id.text;
				user.backemail=bakemail_id.text;
				userProxy.add(user,addResultHandler);
				//					Alert.show("注册");
			}else if(currentState=='backUser'){
				//				   Alert.show("backuser");
				user=new User();
				user._sid=this.parentApplication.PRIVATEKEY;
				user.userName_en=userName_en_id.text;
				user.backemail=bakemail_id.text;
				//userProxy.backPwd(user,backPwdResultHandler);
			}else if(currentState=='modify'){
				user._sid=this.parentApplication.PRIVATEKEY;
				//					user.id=this.parentApplication.user.id;
				user.userName_ch=userName_ch_id.text;
				user.userName_en=userName_en_id.text;
				user.password=password_id.text;
				user.email=email_id.text;
				user.qq_msn=qq_msn_id.text;
				user.backemail=bakemail_id.text;
				userProxy.modify(user,modifyResultHandler);
			}
			else if(currentState=='login'){
				user=new User();
				//					user.userName_ch=userName_ch.text;
				user._sid=this.parentApplication.PRIVATEKEY;
				user.userName_en=userName_en_id.text;
				user.password=password_id.text;
				userProxy.login(user,loginResultHandler);
			}else if(currentState=='modifypwd'){
				if(newpassword_id.text!=confirm_id.text){
					Alert.show("确认密码不正确!","提示",4,this.parentApplication as Sprite);
					confirm_id.text="";
					newpassword_id.text="";
					return;
				}
				if(user.password!=password_id.text){
					Alert.show("原密码不正确!","提示",4,this.parentApplication as Sprite);
					password_id.text='';
					return;
				}
				user._sid=this.parentApplication.PRIVATEKEY;
				user.password=newpassword_id.text;
				//user._oldpassword=password_id.text;
				//userProxy.updatePwd(user,modifypwdResultHandler);
			}
		}
		
		private function modifypwdResultHandler(message:Message):void{
			Alert.show(message.messageBody,'提示',4,this.parentApplication as Sprite);
			PopUpManager.removePopUp(this);		
		}
		
		private function backPwdResultHandler(message:Message):void{
			if(message.messageSucess==1)
				PopUpManager.removePopUp(this);
			Alert.show(message.messageBody,'提示',4,this.parentApplication as Sprite);
			
		}
		
		private function addResultHandler(message:Message):void{
			Alert.show(message.messageBody,'提示',4,this.parentApplication as Sprite);
			PopUpManager.removePopUp(this);		
		}
		private function modifyResultHandler(message:Message):void{
			Alert.show(message.messageBody,'提示',4,this.parentApplication as Sprite);
			this.parentDocument.user=user;
			PopUpManager.removePopUp(this);		
			
		}
		private function loginResultHandler(message:Message):void{
			if(user==null)
				user=new User();
			if(message.messageSucess==1){
				MinnUtil.propertyMap(message.messageBody,user);
				//					this.parentApplication.saveLocale(user,so_check_id.selected);
				this.dispatchEvent(new MinnMessageEvent(MinnMessageEvent.MESSAGE+"loginSucesses",user,true));
				PopUpManager.removePopUp(this);
			}else{
				Alert.show(message.messageBody,'提示',4,this.parentApplication as Sprite);
			}
			//				Alert.show(message.messageBody);
		}
		
		
		protected function userName_en_id_mouseOutHandler(event:FocusEvent):void
		{
			if(userProxy==null)
				userProxy=ControllerService.getInstance(ControllerCommand.USER_PROXY);
			user=new User();
			if(userName_en_id.text!=''){
				user._sid=this.parentApplication.PRIVATEKEY;
				user.userName_en=userName_en_id.text;
				
				userProxy.userCheck(user,userCheckResultHandler);
			}
		}
		private function userCheckResultHandler(message:Message):void{
			
			if(message.messageSucess==0){
				Alert.show(message.messageBody,"提示",4,this.parentApplication as Sprite);
				userName_en_id.text="";
			}
			
		}
		
		private function emailValidator_valid(evt:ValidationResultEvent):void {
			if(this.currentState=="Register"){
				if(email_id.text==""&&bakemail_id.text=="")
					Alert.show(evt.message,"提示",4,this.parentApplication as Sprite);
				return;
			}
			
		}
		
		private function emailValidator_invalid(evt:ValidationResultEvent):void {
			if(this.currentState=="Register"){
				if(email_id.text!=""&&bakemail_id.text!="")
					Alert.show(evt.message,"提示",4,this.parentApplication as Sprite);
				return;
			}else 
				if(this.currentState=="modify"){
					//					Alert.show(evt.message,"提示");
				}
		}
		
		protected function popwin1_currentStateChangeHandler(event:StateChangeEvent):void
		{
			spacer2.includeInLayout=false;
			spacer3.includeInLayout=false;
			spacer4.includeInLayout=false;
			spacer5.includeInLayout=false;
			updatebtn.includeInLayout=false;
			backbtn.includeInLayout=false;
			registerbtn.includeInLayout=false;
			loginbtn.includeInLayout=false;

			spacer2.visible=false;
			spacer3.visible=false;
			spacer4.visible=false;
			spacer5.visible=false;
			updatebtn.visible=false;
			backbtn.visible=false;
			registerbtn.visible=false;
			loginbtn.visible=false;
			emaillabel_id.visible=false;
			emaillabel_id.includeInLayout=false;
			qmlabel_id.visible=false;
			qmlabel_id.includeInLayout=false;
			be_id.visible=false;
			be_id.includeInLayout=false;
			compwdlabel_id.visible=false;
			compwdlabel_id.includeInLayout=false;
			
			userNameValidator.enabled=false;
			 password_idValidator.enabled=false;
			newpassword_idValidator.enabled=false;
			confirm_idValidator.enabled=false;
			userName_ch_idValidator.enabled=false;
			 email_idValidator.enabled=false;
			bakemail_idValidator.enabled=false;
			
			if(currentState=="Register"){
//				Alert.show(currentState);
				userNameValidator.enabled=true;
				password_idValidator.enabled=true;
				confirm_idValidator.enabled=true;
				userName_ch_idValidator.enabled=true;
				email_idValidator.enabled=true;
				bakemail_idValidator.enabled=true;
				spacer2.visible =true;
				backbtn.visible=true;
				loginbtn.visible=true;
			
				spacer2.includeInLayout=true;
				backbtn.includeInLayout=true;
				backbtn.setStyle("color","#000000");
				loginbtn.includeInLayout=true;
				loginbtn.setStyle("color","#000000");
				loginButton.label="注册" ;

				this.title='注册';
			
				pwdlabel_id.visible=true;
				pwdlabel_id.includeInLayout=true;
				compwdlabel_id.visible=true;
				compwdlabel_id.includeInLayout=true;
				compwdlabel2_id.visible=false;
				compwdlabel2_id.includeInLayout=false;
				namelabel_id.visible=true;
				namelabel_id.includeInLayout=true;
				emaillabel_id.visible=true;
				emaillabel_id.includeInLayout=true;
				qmlabel_id.visible=true;
				qmlabel_id.includeInLayout=true;
				be_id.visible=true;
				be_id.includeInLayout=true;
				userName_ch_id.text='';
				userName_en_id.text='';
				password_id.text='';
				email_id.text='';
				qq_msn_id.text='';
				bakemail_id.text="";
			
			}else if(currentState=="modify"){
				userNameValidator.enabled=true;
				userName_ch_idValidator.enabled=true;
				email_idValidator.enabled=true;
				loginButton.label="确定";
				spacer3.visible=true;
				updatebtn.visible=true;
				updatebtn.text="修改密码?";
				updatebtn.setStyle("color","#000000");
				spacer3.includeInLayout=true;
				updatebtn.includeInLayout=true;
				this.title='修改用户信息';
				userName_ch_id.text=user.userName_ch;
				userName_en_id.text=user.userName_en;
				email_id.text=user.email;
				qq_msn_id.text=user.qq_msn;
				bakemail_id.text=user.backemail;
				
				pwdlabel_id.visible=false;
				pwdlabel_id.includeInLayout=false;
				compwdlabel_id.visible=false;
				compwdlabel_id.includeInLayout=false;
				compwdlabel2_id.visible=false;
				compwdlabel2_id.includeInLayout=false;
				namelabel_id.visible=true;
				namelabel_id.includeInLayout=true;
				emaillabel_id.visible=true;
				emaillabel_id.includeInLayout=true;
				qmlabel_id.visible=true;
				qmlabel_id.includeInLayout=true;
				be_id.visible=true;
				be_id.includeInLayout=true;
			}else 
				if(currentState=="login"){
					userNameValidator.enabled=true;
					password_idValidator.enabled=true;
					loginButton.label="登录";
					registerbtn.visible=true;
					backbtn.visible=true;
					spacer4.visible=true;
					registerbtn.includeInLayout=true;
					registerbtn.setStyle("color","#000000");
					backbtn.includeInLayout=true;
					backbtn.setStyle("color","#000000");
					spacer4.includeInLayout=true;
					this.title='登陆';
					pwdlabel_id.visible=true;
					pwdlabel_id.includeInLayout=true;
					compwdlabel_id.visible=false;
					compwdlabel_id.includeInLayout=false;
					compwdlabel2_id.visible=false;
					compwdlabel2_id.includeInLayout=false;
					namelabel_id.visible=false;
					namelabel_id.includeInLayout=false;
					emaillabel_id.visible=false;
					emaillabel_id.includeInLayout=false;
					qmlabel_id.visible=false;
					qmlabel_id.includeInLayout=false;
					be_id.visible=false;
					be_id.includeInLayout=false;
				}else 
					if(currentState=="backUser"){
						userNameValidator.enabled=true;
						userNameValidator.requiredFieldError="用户账号不能为空!";
						loginButton.label="找回密码" ;
						loginbtn.visible=true;
						registerbtn.visible=true;
						spacer5.visible=true;
						loginbtn.includeInLayout=true;
						registerbtn.includeInLayout=true;
						loginbtn.setStyle("color","#000000");
						registerbtn.setStyle("color","#000000");
						spacer5.includeInLayout=true;
						this.title='找回密码';
					
						pwdlabel_id.visible=false;
						pwdlabel_id.includeInLayout=false;
						compwdlabel_id.visible=false;
						compwdlabel_id.includeInLayout=false;
						compwdlabel2_id.visible=false;
						compwdlabel2_id.includeInLayout=false;
						namelabel_id.visible=false;
						namelabel_id.includeInLayout=false;
						emaillabel_id.visible=false;
						emaillabel_id.includeInLayout=false;
						qmlabel_id.visible=false;
						qmlabel_id.includeInLayout=false;
						be_id.visible=false;
						be_id.includeInLayout=false;
						userName_en_id.text='';
					}else if(currentState=="modifypwd"){
						password_idValidator.requiredFieldError="原密码不能为空！";
						password_idValidator.enabled=true;
						newpassword_idValidator.enabled=true;
						confirm_idValidator.enabled=true;
						confirm_idValidator.requiredFieldError="新确认密码不能为空！";
						userName_ch_idValidator.enabled=false;
						email_idValidator.enabled=false;
						bakemail_idValidator.enabled=false;
						spacer3.includeInLayout=true;
						spacer3.visible=true;
						updatebtn.includeInLayout=true;
						updatebtn.visible=true;
						updatebtn.text="修改用户信息?";
						updatebtn.setStyle("color","#000000");
						loginButton.label="确定";
						
						pwdlabel_id.label="原密码:";
						compwdlabel_id.label="确认新密码:";
						this.title='修改用户密码';
					
						pwdlabel_id.visible=true;
						pwdlabel_id.includeInLayout=true;
						compwdlabel_id.visible=true;
						compwdlabel_id.includeInLayout=true;
						compwdlabel2_id.visible=true;
						compwdlabel2_id.includeInLayout=true;
						namelabel_id.visible=false;
						namelabel_id.includeInLayout=false;
						emaillabel_id.visible=false;
						emaillabel_id.includeInLayout=false;
						qmlabel_id.visible=false;
						qmlabel_id.includeInLayout=false;
						be_id.visible=false;
						be_id.includeInLayout=false;
						password_id.text='';
						newpassword_id.text='';
						confirm_id.text='';
					}
		}
		
		
		protected function bakemail_id_focusOutHandler(event:FocusEvent):void
		{
			
		}

		private var validatorArray:Array;
		private var sttes:Array;
		private var trans:Array;
		private var loginForm:Form;
		private var userName_en_id:TextInput;
		private var pwdlabel_id:FormItem;
		private var compwdlabel2_id:FormItem;
		private var newpassword_id:TextInput;
		private var password_id:TextInput;
		private var compwdlabel_id:FormItem;
		private var confirm_id:TextInput;
		private var namelabel_id:FormItem;
		private var userName_ch_id:TextInput;
		private var emaillabel_id:FormItem;
		private var email_id:TextInput;
		private var qmlabel_id:FormItem;
		private var qq_msn_id:TextInput;
		private var be_id:FormItem;
		private var bakemail_id:TextInput;
		private var loginButton:Button;
		private var updatebtn:MenuLabel;
		private var spacer2:Spacer;
		private var spacer3:Spacer;
		private var spacer4:Spacer;
		private var spacer5:Spacer;
		private var backbtn:MenuLabel;
		private var registerbtn:MenuLabel;
		private var loginbtn:MenuLabel;
		private var userNameValidator:StringValidator;
		private var password_idValidator:StringValidator;
		private var newpassword_idValidator:StringValidator;
		private var confirm_idValidator:StringValidator;
		private var userName_ch_idValidator:StringValidator;
		private var email_idValidator:EmailValidator;
		private var bakemail_idValidator:EmailValidator;
		override	protected function createChildren():void{
			super.createChildren();
			sttes=new Array();
			var sta:State=new State();
			sta.name="login";
			sttes.push(sta);
			sta=new State();
			sta.name="Register";
			sttes.push(sta);
			sta=new State();
			sta.name="modify";
			sttes.push(sta);
			sta=new State();
			sta.name="modifypwd";
			sttes.push(sta);
			sta=new State();
			sta.name="backUser";
			sttes.push(sta);
			this.states=sttes;
		
			
			loginForm=new Form();
			
			loginForm.percentHeight=100;
			loginForm.percentWidth=100;
			var fi:FormItem=new FormItem();
			fi.setStyle("labelWidth",90);
			fi.setStyle("textAlign","right");
			fi.width=400;
			fi.label="用户名:";
			userName_en_id=new TextInput();
			userName_en_id.text="minn";
			userName_en_id.setStyle("textAlign","left");
			userName_en_id.addEventListener(FocusEvent.FOCUS_OUT,function(evt:FocusEvent):void{
			  if(currentState=="Register"){
				  userName_en_id_mouseOutHandler(evt);
			  }
			});
			fi.addChild(userName_en_id);
			loginForm.addChild(fi);
			pwdlabel_id=new FormItem();
			pwdlabel_id.setStyle("labelWidth",90);
			pwdlabel_id.setStyle("textAlign","right");
			pwdlabel_id.label="密      码:";
//			pwdlabel_id.label.modifypwd="原密码:";
			pwdlabel_id.direction="horizontal";
			password_id=new TextInput();
			password_id.setStyle("textAlign","left");
			password_id.text="1234";
			password_id.displayAsPassword=true;
			pwdlabel_id.addChild(password_id);
			var lab:Label=new Label();
			lab.text="密码由6~~8位的数字,字母或下划线组成";
			pwdlabel_id.addChild(lab);
			loginForm.addChild(pwdlabel_id);
			
			compwdlabel2_id=new FormItem();
			compwdlabel2_id.setStyle("labelWidth",90);
			compwdlabel2_id.setStyle("textAlign","right");
			compwdlabel2_id.label="新密码:";
			newpassword_id=new TextInput();
			newpassword_id.setStyle("textAlign","left");
			newpassword_id.displayAsPassword=true;
			compwdlabel2_id.addChild(newpassword_id);
			loginForm.addChild(compwdlabel2_id);
			
			compwdlabel_id=new FormItem();
			compwdlabel_id.setStyle("labelWidth",90);
			compwdlabel_id.setStyle("textAlign","right");
			compwdlabel_id.label="确认密码:";
			compwdlabel_id.percentWidth=100;
//			compwdlabel_id.label.modifypwd="确认新密码:";
			confirm_id=new TextInput();
			confirm_id.setStyle("textAlign","left");
			confirm_id.displayAsPassword=true;
			compwdlabel_id.addChild(newpassword_id);
			loginForm.addChild(compwdlabel_id);
			
			namelabel_id=new FormItem();
			namelabel_id.setStyle("labelWidth",90);
			namelabel_id.label="昵称";
			namelabel_id.setStyle("textAlign","right");
			namelabel_id.direction="horizontal";
			userName_ch_id=new TextInput();
			userName_ch_id.setStyle("textAlign","left");
			namelabel_id.addChild(userName_ch_id);
			loginForm.addChild(namelabel_id);
			
			emaillabel_id=new FormItem();
			emaillabel_id.setStyle("labelWidth",90);
			emaillabel_id.setStyle("textAlign","right");
			emaillabel_id.visible=false;
			emaillabel_id.includeInLayout=false;
			emaillabel_id.label="邮箱:";
			emaillabel_id.direction="horizontal";
			email_id=new TextInput();
			email_id.setStyle("textAlign","left");
			emaillabel_id.addChild(email_id);
			lab=new Label();
			lab.text="联系时使用";
			emaillabel_id.addChild(lab);
			loginForm.addChild(emaillabel_id);
			
			qmlabel_id=new FormItem();
			qmlabel_id.setStyle("textAlign","right");
			qmlabel_id.setStyle("labelWidth",90);
			qmlabel_id.visible=false;
			qmlabel_id.includeInLayout=false;
			qmlabel_id.label="QQ或MSN:";
			qmlabel_id.direction="horizontal";
			qq_msn_id=new TextInput();
			qq_msn_id.setStyle("textAlign","left");
			qmlabel_id.addChild(qq_msn_id);
			loginForm.addChild(qmlabel_id);
			
			be_id=new FormItem();
			be_id.setStyle("labelWidth",90);
			be_id.visible=false;
			be_id.includeInLayout=false;
			be_id.label="找回密码邮箱:";
			be_id.direction="horizontal";
			bakemail_id=new TextInput();
			bakemail_id.setStyle("textAlign","left");
			bakemail_id.addEventListener(FocusEvent.FOCUS_OUT,function(evt:FocusEvent):void{
			   if(currentState=="Register"){
				   bakemail_id_focusOutHandler(evt);
			   }
			   if(currentState=="modify"){
				   bakemail_id_focusOutHandler(evt)
			   }
			});
			be_id.addChild(bakemail_id);
			loginForm.addChild(be_id);
			
			this.addChild(loginForm);
			
			var hb:HBox=new HBox();
			hb.percentWidth=100;
			hb.setStyle("horizontalGap",0);
			var spacer1:Spacer=new Spacer();
			spacer1.width=100;
			hb.addChild(spacer1);
			spacer2=new Spacer();
			spacer2.width=35;
			spacer2.setStyle("includeIn","Register");
			hb.addChild(spacer2);
			spacer3=new Spacer();
			spacer3.width=60;
			spacer3.setStyle("includeIn","modify");
			hb.addChild(spacer3);
			spacer4=new Spacer();
			spacer4.width=20;
			spacer4.setStyle("includeIn","login");
			hb.addChild(spacer4);
			spacer5=new Spacer();
			spacer5.width=25;
			spacer5.setStyle("includeIn","backUser");
			hb.addChild(spacer5);
			
			backbtn=new MenuLabel();
			backbtn.styleName="lorMenuLabel";
			backbtn.text="找回密码?";
			backbtn.outColor="#000000";
			backbtn.setStyle("color","#000000");
			backbtn.setStyle("includeIn","login,Register");
			backbtn.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
				currentState='backUser';
			});
			hb.addChild(backbtn);
			
			registerbtn=new MenuLabel();
			registerbtn.styleName="lorMenuLabel";
			registerbtn.setStyle("color","#000000");
			registerbtn.text="注册?";
			registerbtn.setStyle("includeIn","login,backUser");
			registerbtn.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
				currentState='Register';
			});
			hb.addChild(registerbtn);
			loginbtn=new MenuLabel();
//			loginbtn.setStyle("color","#000000");
			loginbtn.outColor="#000000";
			loginbtn.text="登录?";
			loginbtn.setStyle("includeIn","Register,backUser");
			loginbtn.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
				currentState='login';
			});
			hb.addChild(loginbtn);
			
			updatebtn=new MenuLabel();
			updatebtn.text="修改密码?";
			updatebtn.outColor="#000000";
			updatebtn.includeInLayout=false;
			updatebtn.visible=false;
//			lr.setStyle("includeIn","modify,modifypwd");
			updatebtn.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
				if(currentState=='modify'){
					currentState='modifypwd' ;
//					evt.target.text="修改密码?";
				}else {
					currentState='modify';
//					evt.target.text="修改用户信息?";
				}
				
			});
			hb.addChild(updatebtn);
			
			loginButton=new Button();
			loginButton.label="登陆";
			
			loginButton.useHandCursor=true;
			loginButton.buttonMode=true;
			loginButton.setStyle("skinClass",skin.ShopCardBtn);
			loginButton.addEventListener(MouseEvent.CLICK,click_Handler)
				hb.addChild(loginButton);;
			this.addChild(hb);
			var sp:Spacer=new Spacer();
			sp.width=0;
				sp.height=20;
				this.addChild(sp);
			
			validatorArray=new Array();
			userNameValidator=new StringValidator();
			userNameValidator.source=userName_en_id;
//			userNameValidator.includeIn="login,Register,modify"
			userNameValidator.requiredFieldError="用户名不能为空！";
			userNameValidator.property = "text" ;
			userNameValidator.required = true;
			validatorArray.push(userNameValidator);
			
			password_idValidator=new StringValidator();
			password_idValidator.source=password_id;
			//			password_idValidator.includeIn="login,Register,modifypwd"
			password_idValidator.requiredFieldError="密码不能为空！";
//			password_idValidator.requiredFieldError.modifypwd="原密码不能为空！"
			password_idValidator.property = "text" ;
			password_idValidator.required = true;
			validatorArray.push(password_idValidator);
			
			newpassword_idValidator=new StringValidator();
			newpassword_idValidator.source=password_id;
			//			password_idValidator.includeIn="login,Register,modifypwd"
			newpassword_idValidator.requiredFieldError="新密码不能为空！";
			newpassword_idValidator.property = "text" ;
			newpassword_idValidator.required = true;
			validatorArray.push(newpassword_idValidator);
			
			confirm_idValidator=new StringValidator();
			confirm_idValidator.source=password_id;
			//			password_idValidator.includeIn="login,Register,modifypwd"
			confirm_idValidator.requiredFieldError="确认密码不能为空！";
//			requiredFieldError.modifypwd="新确认密码不能为空！"
			confirm_idValidator.property = "text" ;
			confirm_idValidator.required = true;
			validatorArray.push(confirm_idValidator);
			
			userName_ch_idValidator=new StringValidator();
			userName_ch_idValidator.source=password_id;
			//			password_idValidator.includeIn="login,Register,modifypwd"
			userName_ch_idValidator.requiredFieldError="昵称不能为空！";
			//			requiredFieldError.modifypwd="新确认密码不能为空！"
			userName_ch_idValidator.property = "text" ;
			userName_ch_idValidator.required = true;
			validatorArray.push(userName_ch_idValidator);
			
			email_idValidator=new EmailValidator();
			email_idValidator.source=email_id;
//			email_idValidator.includeIn="Register,modify"
			email_idValidator.requiredFieldError="email不能为空！";
			email_idValidator.addEventListener(ValidationResultEvent.VALID,emailValidator_valid);
			email_idValidator.addEventListener(ValidationResultEvent.INVALID,emailValidator_invalid);
			email_idValidator.property = "text" ;
			email_idValidator.required = true ;
			validatorArray.push(email_idValidator);
			
			bakemail_idValidator=new EmailValidator();
			bakemail_idValidator.source=email_id;
			//			email_idValidator.includeIn="Register,modify"
			bakemail_idValidator.requiredFieldError="找回密码email不能为空！";
			bakemail_idValidator.addEventListener(ValidationResultEvent.VALID,function(evt:ValidationResultEvent):void{
				if(currentState=="Register")
				emailValidator_valid(evt)
			});
			bakemail_idValidator.addEventListener(ValidationResultEvent.INVALID,function(evt:ValidationResultEvent):void{
				if(currentState=="Register")
					emailValidator_invalid(evt)
			});
			bakemail_idValidator.property = "text" ;
			bakemail_idValidator.required = true ;
			validatorArray.push(bakemail_idValidator);
			
			trans=new Array();
			var tr:Transition=new Transition();
			tr.fromState="*";
			tr.toState="*";
			var f:Fade=new Fade();
			f.duration=800;
			f.alphaFrom=0;
			f.alphaTo=1;
			f.target=loginForm;
			trans.push(tr);
			this.transitions=trans;
		}
	}
}