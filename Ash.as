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
		
		public function addInvItem(itemName:String,amount:int=1){
			if(inventory[1][itemName] == null){
				inventory[1][itemName] = amount;
			}
			else{//item already exists
				changeItem(itemName,"inc");
				trace("warning! wrong call to increment!");
			}
		}
		
		public function changeItem(itemName:String,action:String,amount:int=1){
			if(action == "inc"){
				inventory[1][itemName] += amount;
			}
			else{
				inventory[1][itemName] -= amount;
			}
		}
		
	}//end class
}//end package