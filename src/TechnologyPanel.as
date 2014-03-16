/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package
{
	import mx.containers.Canvas;
	import mx.controls.Text;
	
	public class TechnologyPanel extends Canvas
	{
		public function TechnologyPanel()
		{
			super();
			this.width=230;
			this.height=136;
			this.setStyle("backgroundColor","#1C0808");
			this.horizontalScrollPolicy="off";
			this.verticalScrollPolicy="off";
			var txt:Text=new Text();
			txt.setStyle("fontSize",16);
			txt.setStyle("color","#8E7878");
			txt.text="minn工作室";
			txt.x=63;
			txt.y=1;
			this.addChild(txt);
			
			txt=new Text();
			txt.setStyle("color","#7B7878");
			txt.text="QQ:394286006";
			txt.x=11;
			txt.y=27;
			this.addChild(txt);
			
			txt=new Text();
			txt.setStyle("color","#737171");
			txt.text="email:freemanfreelift@gmail.com";
			txt.x=11;
			txt.y=51;
			this.addChild(txt);
			
			txt=new Text();
			txt.setStyle("color","#8A8686");
			txt.text="手机号码:13430281045";
			txt.x=11;
			txt.y=78;
			this.addChild(txt);
			
			txt=new Text();
			txt.setStyle("color","#8A8686");
			txt.text="测试版本:2011-8-6";
			txt.x=11;
			txt.y=103;
			this.addChild(txt);
		}
		
	}
}