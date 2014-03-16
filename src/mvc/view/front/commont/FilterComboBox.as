/**
 * @author minn
 * @QQ 394286006
 * @email freemanfreelift@gmail.com
 */
package mvc.view.front.commont
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.ComboBox;
	
	public class FilterComboBox extends ComboBox
	{
		public function FilterComboBox()
		{
			super();
			this.editable=true;
		}
		
		override protected function textInput_changeHandler(event:Event):void{ 
			super.textInput_changeHandler(event); 
			FilterByKey(event); 
		} 
		
		//过滤数据 
		private function FilterByKey(event:Event):void{ 
			var tempDataProvider:ArrayCollection = this.dataProvider as ArrayCollection;
			if (tempDataProvider == null) return;
			this.dataProvider.filterFunction = filterFunction; 
			var tempstr:String = this.text; 
			if(tempDataProvider.refresh()){ 
				this.dropdown.selectedIndex = -1; 
				this.dropdown.verticalScrollPosition = 0; 
				this.text = tempstr; 
				this.open(); 
				this.textInput.setFocus(); 
//				this.textInput.setSelection(tempstr.length,tempstr.length);
				
			}
		} 
		private function filterFunction(item:Object):Boolean{ 
			return item['label'].toString().indexOf(this.text)!=-1; 
		} 
	}
}