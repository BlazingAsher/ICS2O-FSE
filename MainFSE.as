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
			//menu has level number -1
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
			
			if((e.keyCode == Keyboard.TAB || e.keyCode == Keyboard.ESCAPE) && keyboardCapture != "menu"){
				trace("capture")
				keyboardCapture = "menu";
				sideMenu.setLevelOnOpen(level);
				level = -1;
				sideMenu.resetTimer();
				stage.addChild(sideMenu);
				trace('added');
			}
			
			if(keyboardCapture == "menu"){
				sideMenu.handleKeyboardDown(e);
			}
			else if(keyboardCapture == "1"){
				levelOne.handleKeyboardDown(e);
			}
			else{
				trace("other level");
			}
			
		}
		
		public function unMovePlayer(e:KeyboardEvent){
			if(keyboardCapture == "menu"){
				sideMenu.handleKeyboardUp(e);
			}
			else if(keyboardCapture == "1"){
				levelOne.handleKeyboardUp(e);
			}
			else{
				trace("other level");
			}
		}
		
		public function checkLevelDone(){
			if(level == -1){
				if(sideMenu.getIsFinished()){
					level = sideMenu.levelOnOpen();
					keyboardCapture = level.toString();
					trace("newlvl" + level);
					trace("newkey" + keyboardCapture);
					stage.removeChild(sideMenu);
					trace('deleted');
				}
			}
		}
		
		public function gameLoop(e:Event)
		{
			checkLevelDone();
			//levelOne.x = mouseX;
			//levelOne.y = mouseY;
		}
	}//end class
}//end package