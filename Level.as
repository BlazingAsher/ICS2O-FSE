package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	import flash.ui.Keyboard;
	import flash.display.*;
	import flash.geom.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.text.*;
	import com.adobe.tvsdk.mediacore.TextFormat;

	public class Level extends MovieClip
	{
		var vx,vy:int;//velocity of the player
		var p:Ash;//the player
		
		var levelNumber:int;//keep track of the current level
		var settings:Dictionary;//settings of the game (music on/off)
		
		var arena:Arena;//self explanatory
		var tut:Tutorial;//self explanatory (tutorial runs itself)
		
		var messageBox:MessageBox;//self explanatory
		var blocker:Blocker;//black background, used to fade in/out and hide stuff
		var sideMenu:SideMenu;//menu that shows the player's inventory and status
		
		var boss:NonPlayerCharacter;//the boss of the level
		var occupant:NonPlayerCharacter;//occupants of the houses
		
		var borderTracker:BorderTracker;//objects that the player cannot touch (borders, houses, etc)
		var actionItem:ActionItem;//objects that the player can interact with (doors, signs, characters)
		var borderArray,actionItemArray:Array;//arrays to store borderTrackers and ActionItems, respectively
		var darknessEffect:DarknessEffect;//darkness effect for last level
		
		var globalWalking:Boolean;//whether the player is walking
		var globalDir:int;//the direction the player is walking
		
		var isFinished:Boolean;//if the level is complete
		var walkingDisabled:Boolean;//if the player should be frozen
		var ctrlDown:Boolean;//whether the ctrl key is down or not
		var prompting:Boolean;//whether the player is currently being prompted for something
		var battling:Boolean;//whether the player is battling
		var inMenu:Boolean;//whether the player has the menu open
		var inTutorial:Boolean;//whether the player is in the tutorial
		var generatedTeam:Boolean;//whether the player has generated a team
		
		//music stuff
		var bgMusic:BgMusic;
		var bgMusicChannel:SoundChannel;
		var bgSoundTransform:SoundTransform;
		
		var tempBorderActionArray:Array;//array to store the borders and action items of the outside while the player is inside
		var beforeInsideInfo:Array;//array to store the location of the player and map before going inside
		var menuArray:Array;//array that stores all assets created when the player opens the menu
		
		var txtPotionNumber:TextField;//number of potions (menu)
		var txtMoneyNumber:TextField;//amount of money (menu)
		var txtMenuFormat:TextFormat;//white text, Tekton Pro Ext
		
		//w = 1600
		//h = 668
		
		public function Level(levelNumber:int,dataArray:Array)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			//set the default values for all variables
			prompting = false;
			inTutorial = false;
			inMenu = false;
			battling = false;
			generatedTeam = false;
			isFinished = false;
			
			//creates the background music
			bgMusic = new BgMusic();
			
			//loads the settings passed from the main class
			settings = dataArray[0];
			updateSettings(settings);
			
			//creates the player and loads its inventory that was passed from the main class
			p = new Ash();
			p.setInventory(dataArray[1]);
			
			fadeIn(); //cool fade in
			
			createAssets(levelNumber);//start creating the assets for each level
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			
		}//end CONSTRUCTOR
		
		public function fadeIn(){
			//slowly sets alpha of blocker to 0
			blocker = new Blocker();
			this.addChild(blocker);
			blocker.alpha = 0;
			TweenMax.from(blocker,0.5,{alpha:1});
		}
		
		public function fadeOut(){
			//slowly sets alpha of blocker to 1
			blocker = new Blocker();
			this.addChild(blocker);
			blocker.alpha = 0;
			TweenMax.to(blocker,0.5,{alpha:1});
		}
		
		public function manageMenu(state:String){
			if(state == "open" && !inMenu){//if the menu is being called to open and there is not one already opened
				inMenu = true;
				
				//initialize the assets of the menu
				menuArray = new Array();
				sideMenu = new SideMenu();
				
				//convert the global center to local coordinates
				var myPoint:Point = this.globalToLocal(new Point(275,200));
				sideMenu.x = myPoint.x;
				sideMenu.y = myPoint.y;
				
				//loops through the player's pokemon and draws them in two rows
				var i:int = 0;
				for each(var poke in p.getInventory()[0]){					
					var pokeImage:Pokemon = new Pokemon(poke[0]);//draw the pokemon placeholder
					
					//coordinates of the placeholder
					pokeImage.x = -131 + 135*i;
					pokeImage.y = -60;
					if(i>2){//next row
						pokeImage.x = -131 + 135*(i-3);
						pokeImage.y = 45;
					}
					
					//tints the pokemon based on its health
					if(poke[2]<1){//red = <1 hp
						pokeImage.transform.colorTransform = new ColorTransform(1.25,0,0,1,0,0,0,0);
					}
					else if(poke[2]<51){//yellow = <51 hp
						pokeImage.transform.colorTransform = new ColorTransform(1.25,1.25,0,1,0,0,0,0);
					}
					else{//green = >50 hp
						pokeImage.transform.colorTransform = new ColorTransform(0,1.25,0,1,0,0,0,0);
					}
					
					//add into an array
					menuArray.push(pokeImage);
					sideMenu.addChild(pokeImage);
					i++;
				}
				
				//initialize the text
				txtMenuFormat = new TextFormat();
				txtPotionNumber = new TextField();
				txtMoneyNumber = new TextField();
				
				//change the text to white and Tekton Pro Ext
				txtMenuFormat.color = 0xFFFFFF;
				txtMenuFormat.size = 20;
				txtMenuFormat.font = "Tekton Pro Ext";
				
				//Update the default text format
				txtPotionNumber.defaultTextFormat = txtMenuFormat;
				txtMoneyNumber.defaultTextFormat = txtMenuFormat;
				
				//set the number of potions
				txtPotionNumber.text = p.getInventory()[1]['potion'].toString();
				txtPotionNumber.x = -166;
				txtPotionNumber.y = 131;
				txtPotionNumber.autoSize = TextFieldAutoSize.LEFT;
				menuArray.push(txtPotionNumber);
				sideMenu.addChild(txtPotionNumber);
				
				//set the amount of money
				txtMoneyNumber.text = p.getInventory()[1]['money'].toString();
				txtMoneyNumber.x = -178;
				txtMoneyNumber.y = 158;
				txtMoneyNumber.autoSize = TextFieldAutoSize.LEFT;
				menuArray.push(txtMoneyNumber);
				sideMenu.addChild(txtMoneyNumber);
				
				//add to stage
				this.addChild(sideMenu);
				
			}//end open if
			else if(state == "close" && inMenu){//if the menu is being called to close and there is a menu open
				for(var j:int=0;j<menuArray.length;j++){//delete all menu stuff from the stage
					sideMenu.removeChild(menuArray[j]);
					menuArray[j] = undefined;
				}
				
				//unset variables
				menuArray = undefined;
				this.removeChild(sideMenu);
				sideMenu = undefined;
				inMenu = false;
			}
		}
		
		public function getIsFinished(){//returns whether the level is complete
			return isFinished;
		}
		
		public function transferData(){//returns the current settings and the updated player inventory
			var dataArray = new Array();
			dataArray[0] = settings;
			dataArray[1] = p.getInventory();
			return dataArray;
		}
		
		public function updateSettings(tempSettings:Dictionary){//changes the settings to new one passed
			settings = tempSettings;
			if(settings['music']){//if music is enabled, start it
				trace("playing music");
				bgMusicChannel = bgMusic.play(0,int.MAX_VALUE);
				bgSoundTransform = bgMusicChannel.soundTransform;
				bgSoundTransform.volume = 0.75;
				bgMusicChannel.soundTransform = bgSoundTransform;
				TweenMax.from(bgMusicChannel,3,{volume:0});
			}else{//if not, stop it
				try{//in case there is already no music playing
					bgMusicChannel.stop();
				}
				catch(error:Error){
					trace("no music was playing");
				}
			}
		}
		
		public function exitLevel(){//clean everything up before closing the level
			try{
				this.removeEventListener(Event.ENTER_FRAME,gameLoop);
				fadeOut();//fades out
				TweenMax.delayedCall(0.5,setFinished,[]);//delay to set isFinished to true (everything is blocked by the blocker)
				bgMusicChannel.stop();//stop music			
			}
			catch(error:Error){//there was no music playing
				trace("no music was playing");
			}
		}
		
		public function setFinished(){//sets isFinished to true
			isFinished = true;
		}
		
		public function createAssets(tempLevelNumber:int){//creates assets based on the level

			//cretes all the storage arrays
			borderArray = new Array();
			actionItemArray = new Array();
			
			//creates the message box
			messageBox = new MessageBox();
			messageBox.scaleX = 0.46;
			messageBox.scaleY = 0.46;
			messageBox.x = 0;
			messageBox.y = 150;
			
			//set the level number
			levelNumber = tempLevelNumber;
			
			//set player velocity to 0
			vx = 0;
			vy = 0;
			
			/*
			The functions createBorders and registerAction create borders and action items, respectively
			
			Syntax is:
			
			createBorders(startx,starty,lengthx,lengthy)
			registerAction(startx,starty,lengthx,lengthy,type,message/destination)
			*/
			
			//0 is tutorial, rest of levels follow suit
			switch(levelNumber){
				case 0://tutorial
					inTutorial = true;//starts checking if the tutorial is finished
					walkingDisabled = true;//disables walking
					p.alpha = 0;//hides player
				
					//change to right frame
					this.gotoAndStop(1);
					
					//creates the tutorial
					tut = new Tutorial();
					this.addChild(tut);
					break;
				case 1:
					
					//Create barriers
					
					//createBorders(x,y,sizex,sizey)
					//4 houses
					createBorders(-571,-217,150,130);//1st house
					createBorders(-283,-217,150,130);//2nd house
					createBorders(5,-217,150,130);//3rd house
					createBorders(293,-217,150,130);//4th house
					
					//large house
					createBorders(-315,-25,370,127);
					
					//trees
					createBorders(-800,-334,125,668);//right
					createBorders(550,-334,250,668);//left
					createBorders(-675,-334,325,60);//up
					createBorders(-300,-334,850,60);//up, left of path
					createBorders(-675,280,125,55);//bottom, two trees
					
					//bottm fence
					createBorders(-550,310,400,25);
					
					//bottom trees
					createBorders(-150,250,700,84);
					
					//pond
					createBorders(-505,215,115,95);
					
					//Create ActionItem handlers
					//registerAction(-505,200,115,95,"sign","Citizens%that%oppose%math%are%subject%to%interrogation");
					
					registerAction(37,-104,20,20,"portal","portal");
					registerAction(-252,-104,20,20,"genPoke","genPoke");
					
					 //Set frame
					this.gotoAndStop(2);
					
					//Set player coordinates
					p.x = 0;
					p.y = 120;
					
					break;
				case 2:
					//Create barriers
					
					//createBorders(x,y,sizex,sizey)
					//PC Center
					createBorders(43,164,132,114);
					
					//Mart
					createBorders(364,-45,100,100);
					
					//Gym
					createBorders(323,-334,179,90);
					
					//Houses
					createBorders(38,-62,142,101);
					createBorders(38,-289,142,88);
					
					//Upper Rock
					createBorders(-800,-334,311,261);
					
					//Lower Rock
					createBorders(-777,84,235,238);
					
					//Tree Clusters
					createBorders(-506,149,108,73);
					createBorders(-345,182,41,70);
					createBorders(-435,-332,297,280);
					
					//Pond
					createBorders(-370,272,164,57);
					
					//Ledge
					createBorders(203,-163,391,3);
					
					//Fence
					createBorders(203,-73,391,3);
					
					//Left Border Trees
					createBorders(616,-334,184,668);
					
					//Create ActionItem handlers
					
					//Sign1
					registerAction(-92,-49,20,20,"sign","Final%math%assessment%next%week");
					
					//HouseDoor1
					
					registerAction(69,23,20,20,"sign","The%door%is%locked");
					//HouseDoor2
					registerAction(69,-216,20,20,"door","house,0");
					//Gym Sign
					registerAction(290,-255,20,20,"sign","Governor%of%Zarid");
					//Gym Door
					registerAction(417,-247,20,20,"door","gym,0");
					//PCDoor
					registerAction(101,268,20,20,"door","pc");
					//ShopDoor
					registerAction(423,45,20,20,"door","shop");
					
					
					//Set frame
					this.gotoAndStop(3);
					
					//Set player coordinates
					
					break;
				case 3:
					//Create barriers
					
					//MuseamMain
					createBorders(-343,-309,331,217);
					//MueamSide
					createBorders(2,-291,145,106);
					//gym
					createBorders(-441,59,394,133);
					//mart
					createBorders(107,158,101,103);
					//house
					createBorders(295,-54,142,91);
					//pc
					createBorders(298,-242,136,118);
					//marttree
					createBorders(232,193,44,66);
					//righttree
					createBorders(547,-288,253,580);
					//righttreejut
					createBorders(489,-282,53,131);
					//lefttree
					createBorders(-797,-283,187,610);
					//lefttreejut
					createBorders(-602,-31,47,365);
					//pcflowers
					createBorders(183,-269,99,76);
					//gymfence
					createBorders(-540,322,488,3);
					//gymfencevert
					createBorders(-42,221,3,94);
					//fenceledge
					createBorders(-605,-133,83,43);
					//museamledge
					createBorders(-444,-89,722,3);
					//toptrees
					createBorders(-800,-334,1600,55);

					//Create ActionItem handlers
					
					//gymdoor
					registerAction(-252,182,20,20,"door","gym,1");
					//gymsign
					registerAction(-380,171,20,20,"sign","Governor%of%Asani");
					//martdoor
					registerAction(163,247,20,20,"door","shop");
					//sign
					registerAction(516,279,20,20,"sign","All%citizens%must%love%math");
					//housedoor
					registerAction(323,23,20,20,"door","house,1");
					//museamdoor
					registerAction(-208,-124,20,20,"sign","It%is%locked");
					//museamsidedoor
					registerAction(69,-204,20,20,"sign","It%is%locked");
					//muesaemsign
					registerAction(-123,-103,20,20,"sign","The%national%math%museum%is%closed");
					//pcdoor
					registerAction(356,-139,20,20,"door","pc");
					
					//Set frame
					this.gotoAndStop(4);
					
					//Set player coordinates
					
					break;
				case 4:
					//Create barriers
					
					//house1
					createBorders(-312,-244,220,95);
					//gym
					createBorders(168,-164,205,122);
					//marthouse
					createBorders(-61,97,469,101);
					//pc
					createBorders(-84,-213,138,115);
					//bikeshop
					createBorders(-345,39,110,163);
					//bikes
					createBorders(-385,91,27,81);
					//houseledge1
					createBorders(-376,-185,51,3);
					//pcgymledge1
					createBorders(67,-117,87,3);
					//topleft
					createBorders(-800,-334,310,233);
					//bottomleft
					createBorders(-800,31,275,303);
					//bottomstrip
					createBorders(-505,317,1002,3);
					//topright
					createBorders(593,-334,207,171);
					//bottomright
					createBorders(588,-61,212,395);
					//fencevert
					createBorders(503,-65,497,376);

					
					//Create ActionItem handlers
					
					//house1door
					registerAction(-252,-164,20,20,"sign","There%is%no%handle");
					//house2door
					registerAction(6,181,20,20,"sign","There%is%no%one%home");
					//martdoor
					registerAction(197,182,20,20,"door","shop");
					//pcdoor
					registerAction(-28,-105,20,20,"door","pc");
					//sign
					registerAction(-91,87,20,20,"sign","The%region%of%Nardolin");
					//bikesign
					registerAction(-379,184,20,20,"sign","Bikes%are%for%senior%officials%only");
					//gymdoor
					registerAction(261,-44,20,20,"door","gym,2");
					//gymsign
					registerAction(137,-47,20,20,"sign","The%governor%of%Nardolin");
					//bottomsign
					registerAction(-121,314,20,20,"sign","Math%is%number%one");
					
					//Set frame
					this.gotoAndStop(5);
					
					//Set player coordinates
					
					break;
				case 5:
					//Create barriers
					
					//topmountains
					createBorders(-800,-334,1079,50);
					//pcandmountains
					createBorders(-468,-282,766,126);
					//treeslump
					createBorders(-468,-155,167,231);
					//mountainslump
					createBorders(-84,-172,132,109);
					//bottommountainstrip
					createBorders(-800,277,1161,57);
					//bottommountainlump
					createBorders(-89,60,141,209);
					//house1
					createBorders(298,-56,136,93);
					//house2and3
					createBorders(133,106,306,91);
					//tower
					createBorders(457,-334,338,208);
					//mart
					createBorders(620,64,103,100);
					//sidewall
					createBorders(750,-117,50,390);
					//bottomright
					createBorders(471,289,329,45);

					//Create ActionItem handlers
					
					//pcdoor
					registerAction(228,-171,20,20,"door","pc");
					//housedoor1
					registerAction(356,22,20,20,"door","house,2");
					//housedoor2
					registerAction(193,182,20,20,"sign","Barred%from%public%entry");
					//housedoor3
					registerAction(359,184,20,20,"sign","The%door%is%barricaded");
					//routesign
					registerAction(423,-199,20,20,"sign","To%the%region%of%Nardolin");
					//house1sign
					registerAction(262,26,20,20,"sign","I%love%math");
					//sign
					registerAction(518,25,20,20,"sign","All%people%of%Noewyn%must%know%calculus");
					//gymdoor
					registerAction(617,-137,20,20,"door","gym,3");
					
					//Set frame
					this.gotoAndStop(6);
					
					//Set player coordinates
					
					break;
				case 6:
					//Create barriers
					
					//water1
					createBorders(-800,-334,300,668);
					//water2
					createBorders(-485,-278,177,134);
					//water3
					createBorders(-288,-217,173,74);
					//water4
					createBorders(-81,141,95,135);
					//water5
					createBorders(-82,289,45,45);
					//water6
					createBorders(27,238,226,40);
					//water7
					createBorders(270,76,64,200);
					//water8
					createBorders(350,201,25,73);
					//water9
					createBorders(481,201,82,123);
					//water10
					createBorders(527,74,270,115);
					//water11
					createBorders(-493,323,400,3);
					//trees
					createBorders(589,-334,205,288);
					//bush
					createBorders(266,-56,298,3);
					//pc
					createBorders(110,-167,134,114);
					//house1
					createBorders(133,82,112,91);
					//house2
					createBorders(-380,-143,150,91);
					//house3
					createBorders(-151,-141,108,92);
					//gym
					createBorders(-374,74,202,117);
					//gymfence
					createBorders(-471,169,323,-3);
					
					//Create ActionItem handlers
					
					//pcdoor
					registerAction(165,-61,20,20,"door","pc");
					//house1door
					registerAction(165,159,20,20,"sign","No%soliciting");
					//house2door
					registerAction(-122,-64,20,20,"sign","The%house%is%empty");
					//house3door
					registerAction(-346,-64,20,20,"sign","The%door%is%jammed");
					//gymdoor
					registerAction(-285,194,20,20,"door","gym,4");
					//gymsign
					registerAction(-410,155,20,20,"sign","The%governor%of%Daot");
					//pokeclubsign
					registerAction(-410,-60,20,20,"sign","National%math%club%headquarters");
					//sign
					registerAction(358,-27,20,20,"sign","Welcome%to%Daot");
					
					//Set frame
					this.gotoAndStop(7);
					
					//Set player coordinates
					
					break;
				
				case 7:
					//Create barriers
					
					//trees
					createBorders(-800,-334,1600,283);
					//treesquare
					createBorders(365,21,113,130);
					//treesrect
					createBorders(505,95,295,63);
					//water
					createBorders(439,265,361,61);
					//fence1
					createBorders(-798,303,389,3);
					//fence2
					createBorders(-358,303,773,3);
					//fence3
					createBorders(-792,232,487,3);
					//fence4
					createBorders(-35,235,374,3);
					//fence5
					createBorders(-800,159,168,3);
					//fence6
					createBorders(-541,162,482,3);
					//fence7
					createBorders(179,161,92,3);
					//fence8
					createBorders(-800,86,25,3);
					//fence9
					createBorders(-646,87,225,3);
					//fence10
					createBorders(-320,87,588,3);
					//fence11
					createBorders(-800,19,133,3);
					//fence12
					createBorders(-429,18,304,3);
					//fence13
					createBorders(120,17,198,3);
					//fencev1
					createBorders(-422,242,3,49);
					//fencev2
					createBorders(-133,173,3,52);
					//fencev3
					createBorders(81,101,3,58);
					//fencev4
					createBorders(-424,30,3,46);
					//fencev5
					createBorders(10,-22,3,36);
					
					//Create ActionItem handlers
					//brownsignbottomleft
					registerAction(-466,296,20,20,"sign","Math%will%reign%supreme");
					//brownsign2
					registerAction(108,8,20,17,"sign","All%hail%supreme%leader%quadratic");
					//sign
					registerAction(250,225,20,20,"sign","The%region%of%Wiciveth");
					//finalboss
					registerAction(452,-25,20,20,"trainer","5");
					
					//Set frame
					this.gotoAndStop(8);					
					
					//Add boss
					boss = new NonPlayerCharacter();
					boss.x = 459;
					boss.y = -17;
					boss.scaleX = 0.7;
					boss.scaleY = 0.7;
					boss.gotoAndStop(7);
					this.addChild(boss);
					
					//Add the darkness effect (make the maze harder)
					darknessEffect = new DarknessEffect();
					darknessEffect.x = 765
					darknessEffect.y = 210;
					darknessEffect.scaleX = 1.25;
					darknessEffect.scaleY = 1.25;
					this.addChild(darknessEffect);
					
					//Set player coordinates
					p.x = 765;
					p.y = 210;
					break;
			}
			
			//setup the player
			p.gotoAndStop(1);
			p.scaleX=0.7;
			p.scaleY=0.7;
			this.addChild(p);
		}
		
		public function createPrompt(type:String,promptText:String,yesno:Boolean){//creates a messagebox
			//convert global center to local coordinates
			var myPoint:Point = this.globalToLocal(new Point(275,350));
			
			messageBox.x = myPoint.x;
			messageBox.y = myPoint.y;
			
			this.addChild(messageBox);
			
			//setup the messagebox
			messageBox.setText(promptText);//set the text
			messageBox.changeBox(type);//change the message box type (battlenoti, battleprompt, message)
			messageBox.startReveal();//start revealing the letters
			
			if(yesno){//create a yes/no prompt
				messageBox.createPrompt();
			}
			prompting = true;//redirect keyboard to messagebox
		}
		
		public function checkPrompt(){//gets the messagebox response and acts accordinly
			if(prompting){
				var userData = messageBox.getResponse();
				//valid responses are -2, -1, 0, 1
				//-2 means there was no yes/no prompt but the user has pressed enter (close prompt)
				//-1 means the user has not interacted at all
				//0 means no
				//1 means yes
				
				if(userData != -1){//if the user has interacted
					messageBox.destroyPrompt();//remove the yes/no prompt
					messageBox.resetBox();//reset the messagebox
					this.removeChild(messageBox);
					prompting = false;//stop redirecting keystrokes to the messagebox
				}
			}
		}
		
		public function createBorders(startX:int,startY:int,len:int,wid:int){//creates zones that are inaccessible to the player
			//startx: starting x of border
			//starty: starting y of border
			//len: length of border (in pixels)
			//wid: width of border (in pixles)
			
			borderTracker = new BorderTracker();
			//grows or shrinks border based on the length and width provided
			borderTracker.scaleX=len/20;
			borderTracker.scaleY=wid/20;
			borderTracker.x = startX;
			borderTracker.y = startY;
			//borderTracker.alpha = 0.5;
			borderTracker.alpha = 0;//make it invisible
			borderArray.push(borderTracker);
			this.addChild(borderTracker);
			
		}//end function
		
		public function registerAction(startX:int,startY:int,len:int,wid:int,type:String,mess:String){
			actionItem = new ActionItem(type,mess);
			actionItem.scaleX=len/20;
			actionItem.scaleY=wid/20;
			actionItem.x = startX;
			actionItem.y = startY;
			//actionItem.alpha = 0.5;
			actionItem.alpha = 0;//make it invisible
			actionItemArray.push(actionItem);
			this.addChild(actionItem);
		}
		
		public function generatePokemon(){//generates a player's pokemon party
			var pokeArray:Array;//all avaiable pokemon
			pokeArray = ['pikachu','zapdos','moltres','charizard','registeel','skarmory','arceus','articuno','latios','latias'];
			
			//generate all the pokemon
			var tempPlayerInv:Array = p.getInventory();//gets the player inventory
			tempPlayerInv[0] = undefined;//clear all pokemon
			tempPlayerInv[0] = new Dictionary();//reinitialize the pokemon dictionary
			
			//generate 6 pokemon
			for(var i:int=0;i<6;i++){
				var pokeNumber:int = Math.random()*(10-i);
				trace(pokeArray[pokeNumber]);
				tempPlayerInv[0][pokeArray[pokeNumber]] = [pokeArray[pokeNumber],-10,100];//create a pokemon with priority -10 and health 100
				//since the player cannot have duplicate pokemon, we need to remove from it array
				pokeArray.splice(pokeNumber,1);
			}
			p.setInventory(tempPlayerInv);//update the player inventory
		}
		
		public function startBattle(gym:String){//start a battle
			if(!battling){//make sure the player is not battling already
				if(prompting){//if a pre-battle message was shown, close it
					messageBox.destroyPrompt()
					messageBox.resetBox();
					this.removeChild(messageBox);
					prompting = false;
				}
				//initialize the arena
				arena = new Arena(p.getInventory(),gym);//pass the player inventory and the gym name into the arena
				
				//convert global center to local
				var myPoint:Point = this.globalToLocal(new Point(275,200));
				arena.x = myPoint.x;
				arena.y = myPoint.y;
				this.addChild(arena);
				battling = true;//redirect keystrokes to the arena
				globalWalking = false;//disable walking
			}
		}
		
		public function handleKeyboardDown(e:KeyboardEvent){//handles keyboard down
			if(prompting){//if prompting, redirect to prompt
				messageBox.handleKeyboardDown(e);
			}
			else if(battling){//if battling, redirect to arena
				arena.handleKeyboardDown(e);
			}
			else if(!walkingDisabled){//if walking is not disabled
				if(e.keyCode == Keyboard.UP){
					doWalkingAnimation(true,2);
					vx = 0;
					vy = -5;
				}
				if(e.keyCode == Keyboard.DOWN){
					doWalkingAnimation(true,3);
					vx = 0;
					vy = 5;
				}
				if(e.keyCode == Keyboard.LEFT){
					doWalkingAnimation(true,0);
					vy = 0;
					vx = -5;
				}
				if(e.keyCode == Keyboard.RIGHT){
					doWalkingAnimation(true,1);
					vy = 0;
					vx = 5;
				}
				if(e.keyCode == Keyboard.CONTROL){//if the player is pressing control, update the boolean
					ctrlDown = true;
				}
				if(e.keyCode == Keyboard.TAB){//open the menu
					manageMenu("open");
				}
				
			}
		}
		
		public function handleKeyboardUp(e:KeyboardEvent){//handles keyboard up
			if(battling){//if battling, redirect to arena
				arena.handleKeyboardUp(e);
			}
			else if(!walkingDisabled){//if walking is not disabled
				if(e.keyCode == Keyboard.UP){
					vy = 0;
					doWalkingAnimation(false,2);
				}
				if(e.keyCode == Keyboard.DOWN){
					vy = 0;
					doWalkingAnimation(false,3);
				}
				if(e.keyCode == Keyboard.LEFT){
					vx = 0;
					doWalkingAnimation(false,0);
				}
				if(e.keyCode == Keyboard.RIGHT){
					vx = 0;
					doWalkingAnimation(false,1);
				}
				if(e.keyCode == Keyboard.HOME){
					trace("NEXT");
				}
				if(e.keyCode == Keyboard.END){
					trace("px: " + p.x + " py: " + p.y);
					trace("mx: " + this.x + " my: " + this.y);
				}
				if(e.keyCode == Keyboard.CONTROL){//ctrl is released, update the boolean
					ctrlDown = false;
				}
				if(e.keyCode == Keyboard.TAB){//close the menu
					manageMenu("close");
				}
			}
			
		}
		
		public function doWalkingAnimation(walking:Boolean,dir:int){//sets the variables to start the animation
			globalWalking=walking;//if the player is walking
			globalDir=dir;//the direction the player is walking
			
		}
		
		public function movePlayer(){
			//map dimensions: 1600 x 668
		
			//convert player current coordinates to global, to see if the map needs to start moving
			var pt:Point = new Point(0,0);
			pt = p.localToGlobal(pt);
			
			//managing x
			if((pt.x < 50 && vx<0 && !(this.x > 800+vx)) || (pt.x > 500 && vx>0 && !(this.x <-250+vx))){//player has exceeded non-moving area, start moving the map
				//move the map* and the player
				this.x += -vx;
				p.x += vx;
				
				if(levelNumber == 7){//move the darkness
					darknessEffect.x += vx;
				}
			}
			else if((pt.x > 0 && pt.x < 550) || (pt.x == 550 && vx<0) || (pt.x == 0 && vx>0)){//allow player to move only if within boundary OR is straddling boundary and is moving in the opposite direction of the boundary
				//move the player only
				p.x += vx;
				
				if(levelNumber == 7){//move the darkness
					darknessEffect.x += vx;
				}
			}
			
			//managing y
			if((pt.y < 50 && vy<0 && !(this.y > 330+vy)) || (pt.y > 350 && vy>0 && !(this.y < 70+vy))){//player has exceeded non-moving area, start moving the map
				//move the player and the map
				this.y += -vy;
				p.y += vy;
				
				if(levelNumber == 7){//move the darkness
					darknessEffect.y += vy;
				}
			}
			else if((pt.y > 0 && pt.y < 400) || (pt.y == 0 && vy>0) || (pt.y == 400 && vy<0)){//allow the player to move only if within the boundaries OR is straddling boundary and is moving in the opposite direction of the boundary
				//move the player only
				p.y += vy;
				
				if(levelNumber == 7){//move the darkness
					darknessEffect.y += vy;
				}	
				
			}
		}
		
		
		public function walk(){//animates the player
			//Codes:
			//0 left, 1 right, 2 up, 3 down
			
			//Frames:
			//for 1-12
			//back 13-24
			//LEFT/RIGHT 25-36
			
			if(globalWalking){//if the player is walking
				if(globalDir == 0){//left
					p.scaleX=0.7;
					p.scaleY=0.7;
					//left
					if(p.currentFrame>36 || p.currentFrame < 25){
						//trace("r" + p.currentFrame);
						p.gotoAndStop(25);
					}
					else if(p.currentFrame == 36){
						p.gotoAndStop(25);
					}
					else{
						p.gotoAndStop(p.currentFrame+1);
					}
				}
				if(globalDir == 1){//right
					p.scaleX=-0.7;
					p.scaleY=0.7;
					if(p.currentFrame>36 || p.currentFrame < 25){
						p.gotoAndStop(25);
					}
					if(p.currentFrame == 36){
						p.gotoAndStop(25);
					}
					else{
						p.gotoAndStop(p.currentFrame+1);
					}
				}
				if(globalDir == 2){//up
					p.scaleX=0.7;
					p.scaleY=0.7;
					if(p.currentFrame >= 13 && p.currentFrame < 24){
						p.gotoAndStop(p.currentFrame+1);
					}
					else if(p.currentFrame == 24){
						p.gotoAndStop(13);
					}
					else{
						p.gotoAndStop(13);
					}
				}
				if(globalDir == 3){//down
					p.scaleX=0.7;
					p.scaleY=0.7;
					if(p.currentFrame >= 1 && p.currentFrame < 12){
						p.gotoAndStop(p.currentFrame+1);
					}
					else if(p.currentFrame == 12){
						p.gotoAndStop(4);
					}
					else{
						p.gotoAndStop(4);
					}
				}
				
			}
			else {//player has stopped moving
				globalWalking = false;//disable walking
				
				//set the player to the resting position of the respective direction
				if(globalDir == 0){
					p.gotoAndStop(25);
				}
				else if(globalDir == 1){
					p.gotoAndStop(25);
				}
				else if(globalDir == 2){
					p.gotoAndStop(13);
				}
				else if(globalDir == 3){
					p.gotoAndStop(1);
				}
			}
		}
		
		public function checkCollision(){//checks collisions
			for(var i:int=0;i<borderArray.length;i++){
				if(p.hitTestObject(borderArray[i])){//is player touching border, move him/her backwards
					p.x-=vx;
					p.y-=vy;
					if(levelNumber == 7){//if there is darkness, that must be moved too
						darknessEffect.x -= vx;
						darknessEffect.y -= vy;
					}	
				}
			}
			
			for(var j:int=0;j<actionItemArray.length;j++){
				
				if(ctrlDown && actionItemArray[j].hitTestObject(p)){//player touching action item, and ctrl is held
					ctrlDown = false;//prevents double activation
					
					//gets the properties of the action item the player has touched
					var tempType = actionItemArray[j].returnProperties()[0];
					var tempMess = actionItemArray[j].returnProperties()[1];
					
					if(tempType == "sign"){//if it is a sign, just create a message box
						createPrompt("message",tempMess,false);
					}
					
					else if(tempType == "door"){//if it is a door, prepare to go inside!
						
						//get information about where the door is going
						var tempMessArray:Array = tempMess.split(",");
						
						if(tempMessArray[0] == "gym" || tempMessArray[0] == "house"){//check if going indoors
							
							//setup the backup array of the level's stuff
							tempBorderActionArray = undefined;
							tempBorderActionArray = new Array();
							
							//backup the border array and clear it
							tempBorderActionArray[0] = borderArray;
							borderArray = null;
							borderArray = new Array();
							
							//backup the action item array and clear it
							tempBorderActionArray[1] = actionItemArray;
							actionItemArray = null;
							actionItemArray = new Array();
							
							if(tempMessArray[0] == "gym"){//if it is a gym
								if(parseInt(tempMessArray[1]) % 3 == 0){//1st type
									
									//Set frame
									this.gotoAndStop(11);
									
									//Create borders
									
									//bottom
									createBorders(-220,230,450,3);
									//left wall
									createBorders(-215,-161,0,400);
									//right wall
									createBorders(215,-161,0,400);
									
									//leftbuldge
									createBorders(-222,-189,135,97);
									//rightbuldge
									createBorders(84,-189,123,97);
									//upleft
									createBorders(-190,-330,3,164);
									//upright
									createBorders(190,-330,3,164);
									//rightstat
									createBorders(-89,110,20,20);
									//leftstat
									createBorders(64,115,20,20);
									
									//Register Action Items
									
									//trash1
									registerAction(-160,3,20,20,"sign","There%is%only%trash");
									//trash2
									registerAction(-84,3,20,20,"sign","A%mysterious%stone%is%%%%%%inside");
									//trash3
									registerAction(68,3,20,20,"sign","There%is%only%trash");
									//trash4
									registerAction(146,3,20,20,"sign","It%is%empty");
									//boss
									registerAction(-3,-306,20,20,"trainer",tempMessArray[1]);
									
									//Add boss
									boss = new NonPlayerCharacter();
									boss.x = 0;
									boss.y = -304;
									boss.scaleX = 0.7;
									boss.scaleY = 0.7;
									boss.gotoAndStop(parseInt(tempMessArray[1])+1);
									this.addChild(boss);									
									
									//Set the player position
									p.x = 0;
									p.y = 205;
									this.x = 275;
									this.y = 180;
									
								}
								else if(parseInt(tempMessArray[1]) % 3 == 1){//2nd type
									
									//Set frame
									this.gotoAndStop(12);
									
									//Create borders
									
									//trees1
									createBorders(-131,-28,58,67);
									//trees2
									createBorders(66,-26,66,56);
									//trees3
									createBorders(-127,-225,58,58);
									//trees4
									createBorders(77,-227,51,58);
									//trees5
									createBorders(-136,-307,25,64);
									//trees6
									createBorders(107,-269,20,24);
									//trees7
									createBorders(-131,-427,254,20);
									//trees8
									createBorders(-134,-388,21,23);
									//trees9
									createBorders(107,-388,22,61);
									//trees10
									createBorders(-213,-385,24,21);
									//trees11
									createBorders(190,-386,18,26);
									//trees12
									createBorders(188,-144,19,24);
									//trees13
									createBorders(-211,-108,13,30);
									//leftstat
									createBorders(-96,85,26,34);
									//rightstat
									createBorders(69,86,22,38);
									//bottom
									createBorders(-220,230,450,3);
									//left
									createBorders(-234,-524,3,735);
									//right
									createBorders(234,-524,3,735);
									
									//Register Action Items
									//Boss
									registerAction(-3,-249,20,20,"trainer",tempMessArray[1]);
									
									//Add boss
									boss = new NonPlayerCharacter();
									boss.x = 0;
									boss.y = -247;
									boss.scaleX = 0.7;
									boss.scaleY = 0.7;
									boss.gotoAndStop(parseInt(tempMessArray[1])+1);
									this.addChild(boss);
									
									//Set player coordinates
									p.x = 0;
									p.y = 205;
									this.x = 275;
									this.y = 180;
									
								}
								else if(parseInt(tempMessArray[1]) % 3 == 2){//3rd type
									
									//Set frame
									this.gotoAndStop(13);
									
									//Create borders
									
									//bottom
									createBorders(-220,230,450,3);
									//water1
									createBorders(58,-24,145,150);
									//water2
									createBorders(56,137,147,47);
									//water3
									createBorders(-108,-23,112,46);
									//water4
									createBorders(-199,75,207,44);
									//water5
									createBorders(-199,136,141,48);
									//water6
									createBorders(-202,-119,145,41);
									//water7
									createBorders(56,-118,49,36);
									//water8
									createBorders(-41,-91,77,13);
									//water9
									createBorders(-202,-211,146,38);
									//water10
									createBorders(54,-209,147,38);
									//water11
									createBorders(-44,-242,84,39);
									//water12
									createBorders(-204,-66,44,127);
									//water13
									createBorders(155,-161,45,124);
									//water14
									createBorders(-158,-168,3,38);
									
									//Register action items
									//Boss
									registerAction(-10,-181,20,20,"trainer",tempMessArray[1]);
									
									//Add boss
									boss = new NonPlayerCharacter();
									boss.x = 0;
									boss.y = -184;
									boss.scaleX = 0.7;
									boss.scaleY = 0.7;
									boss.gotoAndStop(parseInt(tempMessArray[1])+1);
									this.addChild(boss);
									
									//Set player coordinates
									p.x = 0;
									p.y = 205;
									this.x = 275;
									this.y = 180;
									
								}
								
							}
							
							else if(tempMessArray[0] == "house"){//it is a house
								
								beforeInsideInfo = new Array(); //store player info before going in since he/she will be returning outside
								beforeInsideInfo[0] = this.x;
								beforeInsideInfo[1] = this.y;
								beforeInsideInfo[2] = p.x;
								beforeInsideInfo[3] = p.y;
								
								//Set frame
								this.gotoAndStop(9);
								
								//Set position of player and map
								this.x = 275;
								this.y = 210;
								p.x = -35;
								p.y = 130;
								
								//create borders
								
								//leftwall
								createBorders(-214,-187,-3,361);
								//rightwall
								createBorders(209,-187,-2,361);
								//topwall
								createBorders(211,-95,-438,3);
								//bottom
								createBorders(211,164,-438,3);
								//leftplant
								createBorders(-208,89,26,48);
								//rightplant
								createBorders(180,92,26,55);
								
								//add exit
								registerAction(-69,153,60,10,"exitHouse","exitHouse");
								
								//add occupant
								if(parseInt(tempMessArray[1]) % 3 == 0){//1st type
									registerAction(-170,-7,20,20,"sign","I%will%always%do%math");
									occupant = new NonPlayerCharacter();
									occupant.scaleX = 0.7;
									occupant.scaleY = 0.7;
									occupant.gotoAndStop(8);
									occupant.x = -164;
									occupant.y = 2;
									this.addChild(occupant);
								}
								else if(parseInt(tempMessArray[1]) % 3 == 1){//2nd type
									registerAction(134,-81,20,20,"sign","Do%not%tell%anyone%that%I%%prefer%science");
									occupant = new NonPlayerCharacter();
									occupant.scaleX = 0.7;
									occupant.scaleY = 0.7;
									occupant.gotoAndStop(8);
									occupant.x = 142;
									occupant.y = -72;
									this.addChild(occupant);
								}
								else if(parseInt(tempMessArray[1]) % 3 == 2){//3rd type
									registerAction(148,5,20,20,"sign","All%hail%King%Wici");
									occupant = new NonPlayerCharacter();
									occupant.scaleX = 0.7;
									occupant.scaleY = 0.7;
									occupant.gotoAndStop(8);
									occupant.x = 154;
									occupant.y = 14;
									this.addChild(occupant);
								}
							}
							
							//set the black background
							blocker = new Blocker();
							this.addChild(blocker);
							this.setChildIndex(blocker,2);
							this.setChildIndex(p, this.numChildren - 1);//set player to be on top
						}
						else if(tempMessArray[0] == "pc"){//pc center
							
							//loop through the player's pokemon and set health to 100
							for each(var pokemon in p.getInventory()[0]){
								trace(pokemon);
								pokemon[2] = 100;
							}
							
							//tell the player about it
							createPrompt("message","Your%pokemon%have%been%%%%%healed",false);
								
						}
						else if(tempMessArray[0] == "shop"){//shop
							
							if(p.getInventory()[1]['money'] > 99){//check if the player has enough money (100)
								p.changeItem("money","dec",100);//decrease money
								p.changeItem("potion","inc");//increase potion
								
								//tell the player about it
								createPrompt("message","Bought%one%potion%for%100%%coins.%" + p.getInventory()[1]['money'] + "%coins%left",false);
							}
							else{//player does not have sufficient funds
								createPrompt("message","Yoqqu%do%not%have%enough%coins",false);
							}
						}
					}
					else if(tempType == "trainer"){//it is a boss
						p.x -= vx;
						p.y -= vy;
						if(!isNaN(parseInt(tempMess))){//check if there is a valid boss #
							
							var tempMessInt:int = parseInt(tempMess);//store boss #
							var trainerName:String;//store boss name
							
							//display the bosses message and it's name
							
							if(tempMessInt == 0){//1st boss
								createPrompt("message","You%will%never%defeat%me",false);
								trainerName = "Gov%Zari";
							}
							else if(tempMessInt == 1){//2nd boss
								createPrompt("message","Long%live%Kedenia",false);
								trainerName = "Gov%Asan";
							}
							else if(tempMessInt == 2){//3rd boss
								createPrompt("message","Five%plus%five%equals%%%%%%eleven",false);
								trainerName = "Gov%Nardo";
							}
							else if(tempMessInt == 3){//4th boss
								createPrompt("message","Math%is%life",false);
								trainerName = "Gov%Noen";
							}
							else if(tempMessInt == 4){//5th boss
								createPrompt("message","You%will%not%take%over%%%%%Kedenia",false);
								trainerName = "Gov%Dao";
							}
							else if(tempMessInt == 5){//final boss
								createPrompt("message","Qudratics%rule",false);
								trainerName = "King%Wici";
							}
							TweenMax.delayedCall(3,startBattle,[trainerName]);//delay so that the player can read the message
						}
						else {//if no message, just start the battle
							startBattle(tempMess);
						}
						
					}
					
					else if(tempType == "portal"){//transport to 2nd level
						if(generatedTeam){//check that the player has a team
							createPrompt("message","You%hear%a%strange%sound%%%and%are%whisked%away",false);
							TweenMax.delayedCall(3,exitLevel,[]);
						}
						else{
							createPrompt("message","You%cannot%fight%alone",false);
						}
					}
					
					else if(tempType == "genPoke"){//generate pokemon
						if(!generatedTeam){//check that the player has not already generated a team
							createPrompt("message","I%can%only%spare%6%pokemon.Good%luck.",false);
							generatePokemon();
							generatedTeam = true;
						}
						else{
							createPrompt("message","Sorry,but%I%can%spare%no%%%more",false);
						}
						
					}
					
					else if(tempType == "exitHouse"){//exits a house
						
						//go back to the proper frame
						this.gotoAndStop(levelNumber+1);
						
						//restore old border and action item array
						borderArray = tempBorderActionArray[0];
						actionItemArray = tempBorderActionArray[1];
						
						//clear backup
						tempBorderActionArray = undefined;
						
						//stop the player from walking
						globalWalking = false;
						vx = -vx;
						vy = -vy;
						
						//delete occupant
						this.removeChild(occupant);
						occupant = undefined;
						
						//delete blocker
						this.removeChild(blocker);
						
						//restore player location
						this.x = beforeInsideInfo[0];
						this.y = beforeInsideInfo[1];
						p.x = beforeInsideInfo[2];
						p.y = beforeInsideInfo[3];
					}
				}//end ctrldown if
				
				try{//try to push the player back, but the actionitemarray may have already been cleared by a house/gym
					if(p.hitTestObject(actionItemArray[j])){
						p.x-=vx;
						p.y-=vy;
						if(levelNumber == 7){//move the darkness aswell
							darknessEffect.x -= vx;
							darknessEffect.y -= vy;
						}	
					}
				}
				catch(error:Error){
					trace("action item array was already cleared");
				}
			}
		}
		
		//delete before shipping!
		public function printMouse(e:MouseEvent){
			trace("X: " + mouseX + " Y: " + mouseY);
		}
		
		public function checkFinished(){//check if an overlaying level is finished
			if(battling){//the arena is open
				if(arena.getIsFinished()){//the battle is finished
					battling = false;
					
					//update the player inventory (pokemon health, # of potions left)
					p.setInventory(arena.getData());
					
					//process any messages the arena set back
					var tempFinal:Array = arena.getFinalMessage();
					//contents of array:
					//0 - the message
					//1 - whether the player won
					//2 - whether the trainer has a message
					
					if(tempFinal[0] != "-1" && tempFinal[1]){//the player won and there is a message, show the message
						createPrompt("message",tempFinal[0],false);
					}
					else if(tempFinal[0] != "-1"){//the player lost
						createPrompt("message","You%have%been%defeated",false);
					}
					
					if(tempFinal[1]){//player won
						p.changeItem("money","inc",100);//add 100 dollars
					}
					else{//player lost
						p.changeItem("money","dec",100);//remove 100 dollars
						trace("loser");
					}
					
					//if need to switch levels (boss)
					if(tempFinal[2] && tempFinal[1]){
						TweenMax.delayedCall(3,exitLevel,[]);
					}
					
					//clear the arena
					this.removeChild(arena);
					arena = null;
					trace("money: " + p.getInventory()[1]['money']);
				}
			}
			if(inTutorial){//the tutorial is open
				if(tut.getIsFinished()){//tutorial is finished, so exit the level
					exitLevel();
				}
			}
		}
		
		public function gameLoop(e:Event)
		{
			movePlayer();
			checkCollision();
			walk();
			checkPrompt();
			checkFinished();
		}
	}//end class
}//end package