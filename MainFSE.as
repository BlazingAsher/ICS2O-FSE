package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	public class MainFSE extends MovieClip
	{
		var levelTut,levelOne,levelTwo,levelThree,levelFour,levelFive:Level;
		var battleArena:Arena;
		var sideMenu:SideMenu;
		var keyboardCapture:String;
		var level:int;
		
		public function MainFSE()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			//menu has level number -1
			level = 0;
			
			levelTutInit();
			sideMenuInit();
			arenaInit();
			
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,movePlayer);
			stage.addEventListener(KeyboardEvent.KEY_UP,unMovePlayer);
			
		}//end CONSTRUCTOR
		
		public function arenaInit(){
			battleArena = new Arena();
			battleArena.x = 275;
			battleArena.y = 200;
		}
		
		public function sideMenuInit(){
			sideMenu = new SideMenu("sidebar");
			sideMenu.x = 575;
			sideMenu.y = 200;
		}
		
		public function levelTutInit(){
			levelTut = new Level(0);
			levelTut.x = 275;
			levelTut.y = 200;
			trace("added tut");
			stage.addChild(levelTut);
		}
		
		public function levelOneInit(){
			levelOne = new Level(1);
			levelOne.x = 275;
			levelOne.y = 200;
			stage.addChild(levelOne);
			
		}
		
		public function levelTwoInit(){
			levelTwo = new Level(2);
			levelTwo.x = 275;
			levelTwo.y = 200;
			stage.addChild(levelTwo);
		}
		
		public function movePlayer(e:KeyboardEvent){
			
			if((e.keyCode == Keyboard.TAB || e.keyCode == Keyboard.ESCAPE) && level != -1 && level != 0){
				trace("capture")
				trace("level is: " + level);
				sideMenu.setLevelOnOpen(level);
				level = -1;
				sideMenu.resetTimer();
				stage.addChild(sideMenu);
				trace('added');
			}
			
			//battle is -2, menu is -1, tutorial is 0, level one is 1
			
			switch(level){
				case -2:
					battleArena.handleKeyboardDown(e);
					break;
				case -1:
					sideMenu.handleKeyboardDown(e);
					break;
				case 0:
					levelTut.handleKeyboardDown(e);
					break;
				case 1:
					levelOne.handleKeyboardDown(e);
					break;
				case 2:
					levelTwo.handleKeyboardDown(e);
					break;
				default:
					trace("other level");
			}
			
		}
		
		public function unMovePlayer(e:KeyboardEvent){
			switch(level){
				case -2:
					battleArena.handleKeyboardUp(e);
					break;
				case -1:
					sideMenu.handleKeyboardUp(e);
					break;
				case 0:
					levelTut.handleKeyboardUp(e);
					break;
				case 1:
					levelOne.handleKeyboardUp(e);
					break;
				case 2:
					levelTwo.handleKeyboardUp(e);
					break;
				default:
					trace("other level");
			}
		}
		
		public function checkLevelDone(){
			switch(level){
				case -2:
					if(battleArena.getIsFinished()){
						level = battleArena.levelOnOpen();
						trace(level);
						trace("bnewlvl" + level);
						trace("bnewkey" + keyboardCapture);
						stage.removeChild(battleArena);
						trace('bdeleted');
					}
					break;
				case -1:
					if(sideMenu.getIsFinished()){
						level = sideMenu.levelOnOpen();
						trace(level);
						trace("newlvl" + level);
						trace("newkey" + keyboardCapture);
						stage.removeChild(sideMenu);
						trace('deleted');
					}
					break;
				case 0:
					if(levelTut.getIsFinished()){
						stage.removeChild(levelTut);
						level = 1;
						levelTut = null;
						levelOneInit();
					}
					break;
				case 1:
					if(levelOne.getIsFinished()){
						trace("received level1 done");
						stage.removeChild(levelOne);
						level = 2;
						levelOne = null;
						levelTwoInit();
					}
					break;
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