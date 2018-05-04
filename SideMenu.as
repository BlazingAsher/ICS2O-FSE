package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.*;
	import flash.utils.Timer;
	public class SideMenu extends MovieClip
	{
		var isFinished:Boolean;
		var lastLevel:int;
		var myTimer:Timer;
		var canExit:Boolean;

		public function SideMenu(type:String)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			canExit = false;
			myTimer = new Timer(100,1);
			myTimer.addEventListener(TimerEvent.TIMER,allowExit);
			isFinished = false;
			lastLevel = -2;
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
		
		public function getIsFinished(){
			return isFinished;
		}
		
		public function levelOnOpen(){
			trace("returned" + lastLevel);
			return lastLevel;
		}
		
		public function setLevelOnOpen(level:int){
			lastLevel = level;
			trace("called from" + lastLevel);
		}
		
		public function resetTimer(){
			myTimer.reset();
			canExit = false;
			isFinished = false;
			myTimer.start();
			trace(canExit);
		}
		
		public function allowExit(e:TimerEvent){
			trace("calling");
			canExit = true;
		}
		
		public function handleKeyboardDown(e:KeyboardEvent){
			trace("hi");
			if(e.keyCode == Keyboard.TAB && canExit){
				isFinished = true;
			}
		}
		
		public function handleKeyboardUp(e:KeyboardEvent){
			
		}
	}//end class
}//end package