package
{
	import flash.display.MovieClip;
	import flash.events.*;
	public class Ash extends MovieClip
	{
		var inventory:Array;
		
		public function Ash()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			
			inventory = new Array();
			
		}//end CONSTRUCTOR
		
		public function getInventory(){
			return inventory;
		}
		
		public function setInventory(tempInv:Array){
			inventory = tempInv;
		}
		
	}//end class
}//end package