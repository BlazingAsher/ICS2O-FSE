package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	public class MainFSE extends MovieClip
	{
		var levelOne:LevelOne;
		var sideMenu:SideMenu;
		var keyboardCapture:String;
		var level:int;
		
		public function MainFSE()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			//menu has level number Infinity
			keyboardCapture = "stage";
			level = 1;
			
			levelOneInit();
			sideMenu = new SideMenu("sidebar");
			sideMenu.x = 575;
			sideMenu.y = 200;
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
			
			keyboardCapture = "1";
		}
		
		public function movePlayer(e:KeyboardEvent){
			if(e.keyCode == Keyboard.TAB || e.keyCode == Keyboard.ESCAPE){
				keyboardCapture = "menu";
			}
			
			if(e.keyCode == Keyboard.TAB && !stage.contains(sideMenu)){
				trace("bye")
				stage.addChild(sideMenu);
			}
			else if((e.keyCode == Keyboard.ESCAPE || e.keyCode == Keyboard.TAB) && stage.contains(sideMenu)){
				trace("hi")
				stage.removeChild(sideMenu);
			}
			if(keyboardCapture == "menu"){
				
			}
			
			else{
				levelOne.handleKeyboardDown(e);
			}
			
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