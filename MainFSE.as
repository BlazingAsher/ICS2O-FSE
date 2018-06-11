package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	import flash.ui.Keyboard;
	public class MainFSE extends MovieClip
	{
		var levelTut,levelOne,levelTwo,levelThree,levelFour,levelFive,levelSix,levelSeven:Level;
		var battleArena:Arena;
		var sideMenu:SideMenu;
		var keyboardCapture:String;
		var level:int;
		var settings:Dictionary;
		var inv:Array;
		var finale:EndScene;
		
		public function MainFSE()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			initAll();
			
		}//end CONSTRUCTOR
		
		public function initAll(){
			//menu has level number -1
			
			settings = new Dictionary();
			settings['music'] = true;
			
			var pokemon:Dictionary = new Dictionary();
			//name, order, hp, move1, move2, move3, move4 (MOVES ARE EMPTY BEFORE FIRST BATTLE)
			pokemon['latios'] = new Array("latios",1,0);
			pokemon['pikachu'] = new Array("pikachu",1,100);
			pokemon['skarmory'] = new Array("skarmory",1,48);
			pokemon['moltres'] = new Array("moltres",1,100);
			pokemon['charizard'] = new Array("charizard",1,100);
			pokemon['latias'] = new Array("latias",1,100);
			var items:Dictionary = new Dictionary();
			items['testtest'] = 1;
			items['potion'] = 15;
			items['money'] = 1000;
			inv = new Array(pokemon,items);
			
			level = 0;
			
			levelTutInit();
			
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,movePlayer);
			stage.addEventListener(KeyboardEvent.KEY_UP,unMovePlayer);
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
		public function levelSevenInit(){
			var dataArray = new Array();
			dataArray[0] = settings;
			dataArray[1] = inv;
			
			levelSeven = new Level(7,dataArray);
			levelSeven.x = -250;
			levelSeven.y = 140;
			stage.addChild(levelSeven);
		}
		
		public function finaleInit(){
			finale = new EndScene();
			finale.x = 257;
			finale.y = 200;
			stage.addChild(finale);
		}
		
		public function movePlayer(e:KeyboardEvent){
			
/*			if((e.keyCode == Keyboard.TAB || e.keyCode == Keyboard.ESCAPE) && level != -1 && level != 0){
				trace("capture")
				trace("level is: " + level);
				sideMenu.setLevelOnOpen(level);
				level = -1;
				sideMenu.resetTimer();
				stage.addChild(sideMenu);
				trace('added');
			}
			*/
			//tutorial is 0, levels are 1-6, maze + final is 7
			
			switch(level){
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
					levelSeven.handleKeyboardDown(e);
					break;
				case 8:
					finale.handleKeyboardDown(e);
					break;
				default:
					trace("other level");
			}
			
		}
		
		public function unMovePlayer(e:KeyboardEvent){
			switch(level){
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
					levelSeven.handleKeyboardUp(e);
					break;
				case 8:
					finale.handleKeyboardUp(e);
					break;
				default:
					trace("other level");
			}
		}
		
		public function checkLevelDone(){
			var tempArray:Array = new Array();
			switch(level){
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
						levelSix = null;
						levelSevenInit();
					}
					break;
					
				case 7:
					if(levelSeven.getIsFinished()){
						trace("received level1 done");
						stage.removeChild(levelSeven);
						
						tempArray = levelSeven.transferData();
						inv = tempArray[1];
						
						level = 8;
						levelSeven = null;
						finaleInit();
					}
					break;
				case 8:
					if(finale.getIsFinished()){
						trace("finale");
						stage.removeChild(finale);
						
						//destroy everything

						finale = undefined;
						battleArena = undefined;
						keyboardCapture = undefined;
						level = undefined;
						settings = undefined;
						inv = undefined;
						
						//keep going
						initAll();
						
						//exit
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