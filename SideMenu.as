package
{
	import flash.display.MovieClip;
	import flash.events.*;
	public class SideMenu extends MovieClip
	{

		public function SideMenu(type:String)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			if(type == "sidebar"){
				trace("sidebar!");
			}
			else if(type == "fightrun"){
				trace("fight or run?");
			}
			else if(type == "chooseattack"){
				trace("choose an attack!");
			}
			
		}//end CONSTRUCTOR
		
	}//end class
}//end package