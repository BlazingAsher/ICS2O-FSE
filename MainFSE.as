package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	import flash.ui.Keyboard;
	public class MainFSE extends MovieClip
	{
		var levelTut,levelOne,levelTwo,levelThree,levelFour,levelFive,levelSix:Level;
		var battleArena:Arena;
		var sideMenu:SideMenu;
		var keyboardCapture:String;
		var level:int;
		var settings:Dictionary;
		var inv:Array;
		
		public function MainFSE()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			//menu has level number -1
			
			settings = new Dictionary();
			settings['music'] = true;
			
			var pokemon:Dictionary = new Dictionary();
			pokemon['blatie'] = new Array(1,"lol","lol");
			var items:Dictionary = new Dictionary();
			items['testtest'] = 1;
			inv = new Array(pokemon,items);
			
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
			sideMenu = new SideMenu("sidebar",settings);
			sideMenu.x = 575;
			sideMenu.y = 200;
		}
		
		public function levelTutInit(){
			var dataArray = new Array();
			dataArray[0] = settings;
			dataArray[1] = inv;
			
			levelTut = new Level(0,dataArray);
			levelTut.x = 275;
			levelTut.y = 200;
			trace("added tut");
			stage.addChild(levelTut);
		}
		
		public function levelOneInit(){
			var dataArray = new Array();
			dataArray[0] = settings;
			dataArray[1] = inv;
			trace(dataArray[1]);
			
			levelOne = new Level(1,dataArray);
			levelOne.x = 275;
			levelOne.y = 200;
			stage.addChild(levelOne);
			
		}
		
		public function levelTwoInit(){
			var dataArray = new Array();
			dataArray[0] = settings;
			dataArray[1] = inv;
			
			levelTwo = new Level(2,dataArray);
			levelTwo.x = 275;
			levelTwo.y = 200;
			stage.addChild(levelTwo);
			levelTwo.addEventListener(MouseEvent.CLICK,levelTwo.printMouse);
		}
		
		public function levelThreeInit(){
			var dataArray = new Array();
			dataArray[0] = settings;
			dataArray[1] = inv;
			
			levelThree = new Level(3,dataArray);
			levelThree.x = 275;
			levelThree.y = 200;
			stage.addChild(levelThree);
		}
		
		public function levelFourInit(){
			var dataArray = new Array();
			dataArray[0] = settings;
			dataArray[1] = inv;
			
			levelFour = new Level(4,dataArray);
			levelFour.x = 275;
			levelFour.y = 200;
			stage.addChild(levelFour);
			levelFour.addEventListener(MouseEvent.CLICK,levelFour.printMouse);
		}
		
		public function levelFiveInit(){
			var dataArray = new Array();
			dataArray[0] = settings;
			dataArray[1] = inv;
			
			levelFive = new Level(5,dataArray);
			levelFive.x = 275;
			levelFive.y = 200;
			stage.addChild(levelFive);
		}
		
		public function levelSixInit(){
			var dataArray = new Array();
			dataArray[0] = settings;
			dataArray[1] = inv;
			
			levelSix = new Level(6,dataArray);
			levelSix.x = 275;
			levelSix.y = 200;
			stage.addChild(levelSix);
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
			
			//gyms are -3, battle is -2, menu is -1, tutorial is 0, levels are 1-6, maze is 7, outside of final battle is 8
			
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
				case 3:
					levelThree.handleKeyboardDown(e);
					break;
				case 4:
					levelFour.handleKeyboardDown(e);
					break;
				case 5:
					levelFive.handleKeyboardDown(e);
					break;
				case 6:
					levelSix.handleKeyboardDown(e);
					break;
				case 7:
				
					break;
				case 8:
				
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
				case 3:
					levelThree.handleKeyboardUp(e);
					break;
				case 4:
					levelFour.handleKeyboardUp(e);
					break;
				case 5:
					levelFive.handleKeyboardUp(e);
					break;
				case 6:
					levelSix.handleKeyboardUp(e);
					break;
				case 7:
				
					break;
				case 8:
				
					break;
				default:
					trace("other level");
			}
		}
		
		public function checkLevelDone(){
			var tempArray:Array = new Array();
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
						settings = sideMenu.getSettings();
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
						
						tempArray= levelOne.transferData();
						inv = tempArray[1];
						
						level = 2;
						levelOne = null;
						levelTwoInit();
					}
					break;
				case 2:
					if(levelTwo.getIsFinished()){
						trace("received level2 done");
						stage.removeChild(levelTwo);
						
						tempArray = levelTwo.transferData();
						inv = tempArray[1];
						
						level = 3;
						levelTwo = null;
						levelThreeInit();
					}
					break;
				case 3:
					if(levelThree.getIsFinished()){
						trace("received level3 done");
						stage.removeChild(levelThree);
						
						tempArray = levelThree.transferData();
						inv = tempArray[1];
						
						level = 4;
						levelThree = null;
						levelFourInit();
					}
					break;
				case 4:
					if(levelFour.getIsFinished()){
						trace("received level1 done");
						stage.removeChild(levelFour);
						
						tempArray = levelFour.transferData();
						inv = tempArray[1];
						
						level = 5;
						levelFour = null;
						levelFiveInit();
					}
					break;
				case 5:
					if(levelFive.getIsFinished()){
						trace("received level1 done");
						stage.removeChild(levelFive);
						
						tempArray = levelFive.transferData();
						inv = tempArray[1];
						
						level = 6;
						levelFive = null;
						levelSixInit();
					}
					break;
				case 6:
					if(levelSix.getIsFinished()){
						trace("received level1 done");
						stage.removeChild(levelSix);
						
						tempArray = levelSix.transferData();
						inv = tempArray[1];
						
						level = 7;
						levelOne = null;
						//levelTwoInit();
					}
					break;
					
				case 7:
				
					break;
				case 8:
				
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