package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	public class Arena extends MovieClip
	{
		var playerPoke,enePoke:Dictionary;
		var isFinished:Boolean;
		var levelOpen:int;

		public function Arena(player:Dictionary)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			isFinished = false;
			playerPoke = player;
	
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			
		}//end CONSTRUCTOR
		
		public function handleKeyboardDown(e){
		
		}
		
		public function handleKeyboardUp(e){
			
		}
		
		public function getIsFinished(){
			return isFinished;
		}
		
		public function levelOnOpen(){
			return levelOpen;
		}
		
		public function setLevelOnOpen(level:int){
			levelOpen = level;
		}
		
		public function gameLoop(e:Event)
		{
			
		}
		
	}//end class
}//end package