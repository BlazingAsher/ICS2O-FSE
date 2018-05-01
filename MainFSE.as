package
{
	import flash.display.MovieClip;
	import flash.events.*;
	public class MainFSE extends MovieClip
	{
		var levelOne:LevelOne;
		
		public function MainFSE()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			levelOneInit();
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,movePlayer);
			stage.addEventListener(KeyboardEvent.KEY_UP,unMovePlayer);
			
		}//end CONSTRUCTOR
		
		public function levelOneInit(){
			levelOne = new LevelOne();
			levelOne.x = 275;
			levelOne.y = 200;
			levelOne.scaleX = 1;
			levelOne.scaleY = 1;
			stage.addChild(levelOne);
			
		}
		
		public function movePlayer(e:KeyboardEvent){
			levelOne.handleKeyboardDown(e);
		}
		
		public function unMovePlayer(e:KeyboardEvent){
			levelOne.handleKeyboardUp(e);
		}
		
		public function gameLoop(e:Event)
		{
			//levelOne.x = mouseX;
			//levelOne.y = mouseY;
		}
	}//end class
}//end package