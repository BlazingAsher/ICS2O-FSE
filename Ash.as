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
			//inventory is an array of two dictionaries
			//0 is dictionary of pokemon
			//1 is dictionary of itmems
			
		}//end CONSTRUCTOR
		
		public function getInventory(){//returns contents of the player inventory as an array
			return inventory;
		}
		
		public function setInventory(tempInv:Array){//using input, sets the player inventory
			inventory = tempInv;
		}

		public function addInvItem(itemName:String,amount:int=1){//adds an item to the player's inventory
			if(inventory[1][itemName] == null){
				inventory[1][itemName] = amount;
			}
			else{//item already exists
				changeItem(itemName,"inc");
				trace("warning! wrong call to increment!");
			}
		}
		
		public function changeItem(itemName:String,action:String,amount:int=1){//modifies the amount of an item in an inventory
			if(action == "inc"){
				inventory[1][itemName] += amount;//increase amount
			}
			else{//decrease amount
				inventory[1][itemName] -= amount;
			}
		}
		
	}//end class
}//end package