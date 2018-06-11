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
			type = itemType;//whether it is a door, trainer, or sign
			mess = itemMess;//location of door/sign message
			trace("created new " + type + " with message " + mess);
			
		}//end CONSTRUCTOR
		
		public function returnProperties(){//returns the item properties
			var tempArray = new Array();//store response into an array
			tempArray.push(type);
			tempArray.push(mess);
			return tempArray;
		}
	}//end class
}//end package