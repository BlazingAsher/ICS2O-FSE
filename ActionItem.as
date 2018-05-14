package
{
	import flash.display.MovieClip;
	import flash.events.*;
	public class ActionItem extends MovieClip
	{
		var type:String;
		var mess:String;
		public function ActionItem(itemType:String,itemMess:String=null)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			type = itemType;
			mess = itemMess;
			trace("created new " + type + " with message " + mess);
			
		}//end CONSTRUCTOR
		
		public function returnProperties(){
			var tempArray = new Array();
			tempArray.push(type);
			tempArray.push(mess);
			return tempArray;
		}
	}//end class
}//end package