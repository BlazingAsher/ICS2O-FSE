package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import com.greensock.*;
	import com.greensock.easing.*;
	public class Level extends MovieClip
	{
		var levelTimer:Timer;
		var vx,vy:int;
		var p:Ash;
		var settings:Dictionary;
		var borderTracker:BorderTracker;
		var assetArray,borderArray,actionItemArray:Array;
		var troubleshooting:Boolean;
		var globalWalking:Boolean;
		var globalDir:int;
		var isFinished:Boolean;
		var walkingDisabled:Boolean;
		var ctrlDown:Boolean;
		var actionItem:ActionItem;
		var messageBox:MessageBox;
		var prompting:Boolean;
		var userResponse:int;
		var inside:Boolean;
		var blocker:Blocker = new Blocker();
		var battling:Boolean;
		var bgMusic:BgMusic;
		var bgMusicChannel:SoundChannel;
		var bgSoundTransform:SoundTransform;
		var arena:Arena;
		var tempBarrierActionArray:Array;
		var boss:NonPlayerCharacter;	
		var inTutorial:Boolean;
		var tut:Tutorial;
		var darknessEffect:DarknessEffect;
		var levelNumber:int;
		
		//w = 1600
		//h = 668
		
		public function Level(levelNumber:int,dataArray:Array)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			prompting = false;
			inside = false;
			inTutorial = false;
			battling = false;
			bgMusic = new BgMusic();
			
			settings = dataArray[0];
			updateSettings(settings);
			p = new Ash();
			p.setInventory(dataArray[1]);
			
			createAssets(levelNumber);
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			
		}//end CONSTRUCTOR
		
		public function getIsFinished(){
			return isFinished;
		}
		
		public function transferData(){
			var dataArray = new Array();
			dataArray[0] = settings;
			dataArray[1] = p.getInventory();
			return dataArray;
		}
		
		public function updateSettings(tempSettings:Dictionary){
			settings = tempSettings;
			if(settings['music']){
				bgMusicChannel = bgMusic.play(0,int.MAX_VALUE);
				bgSoundTransform = bgMusicChannel.soundTransform;
				bgSoundTransform.volume = 0.75;
				bgMusicChannel.soundTransform = bgSoundTransform;
				TweenMax.from(bgMusicChannel,3,{volume:0});
			}else{
				try{
					bgMusicChannel.stop();
				}
				catch(error:Error){
					trace("error!");
				}
				//turn off music
			}
		}
		
		public function exitLevel(){
			try{
				bgMusicChannel.stop();
				this.removeEventListener(Event.ENTER_FRAME,gameLoop);
			}
			catch(error:Error){
				trace("error");
			}
			isFinished = true;
		}
		
		public function createAssets(tempLevelNumber:int){
			//right is increase
			//left is decrease
			
			//down is increase
			//up is decrease
			
			isFinished = false;
			
			assetArray = new Array();
			borderArray = new Array();
			actionItemArray = new Array();
			
			messageBox = new MessageBox();
			messageBox.scaleX = 0.46;
			messageBox.scaleY = 0.46;
			messageBox.x = 0;
			messageBox.y = 150;
			
			levelNumber = tempLevelNumber;
			
			switch(levelNumber){//create borders based on the level
				case 0:
					inTutorial = true;
					walkingDisabled = true;
					p.alpha = 0;
					this.gotoAndStop(1);
					
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
					registerAction(-252,-167,20,20,"sign","There%is%no%handle");
					//house2door
					registerAction(6,181,20,20,"sign","There%is%no%one%home");
					//martdoor
					registerAction(197,179,20,20,"door","shop");
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
					
					//Add boss
					boss = new NonPlayerCharacter();
					boss.x = 459;
					boss.y = -17;
					boss.scaleX = 0.7;
					boss.scaleY = 0.7;
					boss.gotoAndStop(7);
					this.addChild(boss);
					
					//Darkness Effect
					darknessEffect = new DarknessEffect();
					darknessEffect.x = 765
					darknessEffect.y = 210;
					darknessEffect.scaleX = 1.25;
					darknessEffect.scaleY = 1.25;
					this.addChild(darknessEffect);
					
					//Set frame
					this.gotoAndStop(8);
					
					//Set player coordinates
					p.x = 765;
					p.y = 210;
					trace("lol" + this.x);
					break;
					
				case 8:
					
					break;
			}
			
			vx = 0;
			vy = 0;
			
			p.gotoAndStop(1);
			p.scaleX=0.7;
			p.scaleY=0.7;
			this.addChild(p);
			trace(p.x);
		}
		
		public function createPrompt(type:String,promptText:String,yesno:Boolean){
			var myPoint:Point = this.globalToLocal(new Point(275,350));
			
			trace ("x: " + myPoint.x); // output: -100 
			trace ("y: " + myPoint.y); // output: -100
			
			
			messageBox.x = myPoint.x;
			messageBox.y = myPoint.y;
			
			this.addChild(messageBox);
			messageBox.setText(promptText);
			messageBox.changeBox(type);
			messageBox.startReveal();
			if(yesno){
				messageBox.createPrompt();
			}
			prompting = true;
		}
		
		public function checkPrompt(){
			if(prompting){
				var userData = messageBox.getResponse();
				//trace(userData);
				if(userData != -1){
					trace("destroying");
					messageBox.destroyPrompt()
					messageBox.resetBox();
					this.removeChild(messageBox);
					prompting = false;
					userResponse = userData;
				}
			}
		}
		
		public function createBorders(startX:int,startY:int,len:int,wid:int){
			//ADAPT
			//len: length of border (in pixels)
			//wid: width of border (in pixles)
			//startx: starting x of border
			//starty: starting y of border
			
			borderTracker = new BorderTracker();
			borderTracker.scaleX=len/20;
			borderTracker.scaleY=wid/20;
			borderTracker.x = startX;
			borderTracker.y = startY;
			borderTracker.alpha = 0.5;
			//borderTracker.alpha = 0;
			borderArray.push(borderTracker);
			this.addChild(borderTracker);
			
		}//end function
		
		public function registerAction(startX:int,startY:int,len:int,wid:int,type:String,mess:String){
			actionItem = new ActionItem(type,mess);
			actionItem.scaleX=len/20;
			actionItem.scaleY=wid/20;
			actionItem.x = startX;
			actionItem.y = startY;
			actionItem.alpha = 0.5;
			//actionItem.alpha = 0;
			actionItemArray.push(actionItem);
			this.addChild(actionItem);
		}
		
		public function startBattle(gym:String){
			if(!battling){
				if(prompting){
					messageBox.destroyPrompt()
					messageBox.resetBox();
					this.removeChild(messageBox);
					prompting = false;
				}
				arena = new Arena(p.getInventory(),gym);
				var myPoint:Point = this.globalToLocal(new Point(275,200));
				arena.x = myPoint.x;
				arena.y = myPoint.y;
				this.addChild(arena);
				battling = true;
				globalWalking = false;
			}
		}
		
		public function handleKeyboardDown(e:KeyboardEvent){
			if(prompting){
				//trace("prompting");
				messageBox.handleKeyboardDown(e);
			}
			else if(battling){
				arena.handleKeyboardDown(e);
			}
			else if(!walkingDisabled){
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
				if(e.keyCode == Keyboard.CONTROL){
					ctrlDown = true;
					if(vx>0){
						vx+=10;
					}
					else if(vy>0){
						vy+=10;
					}
				}
			}
			if(e.keyCode == Keyboard.SHIFT){
					exitLevel();
					//trace("done level1");
			}
			/*if(e.keyCode == Keyboard.INSERT){
				trace(p.getInventory());
				trace(p.getInventory()[0]['blatie']);
				trace(p.getInventory()[1]);
			}*/
			}
		
		public function handleKeyboardUp(e:KeyboardEvent){
			if(battling){
				arena.handleKeyboardUp(e);
			}
			else if(!walkingDisabled){
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
				if(e.keyCode == Keyboard.CONTROL){
					ctrlDown = false;
					if(vx>0){
						vx-=10;
					}
					else if(vy>0){
						vy-=10;
					}
				}
			}
			
		}
		
		public function doWalkingAnimation(walking:Boolean,dir:int){
			globalWalking=walking;
			globalDir=dir;
			
		}
		
		public function movePlayer(){
			//trace(outOfBounds);
			//map dimensions: 1600 x 668
		
			var pt:Point = new Point(0,0);
			pt = p.localToGlobal(pt);
			
			
			//trace(pt);
			if(troubleshooting){
				trace("global x:" + pt.x);
				trace("global y:" + pt.y);
				trace("local x:" + p.x);
				trace("local y:" + p.y);
				trace("map x:" + this.x);
				trace("map y:" + this.y);
				trace("vx:" + vx);
				trace("vy:" + vy);
				trace(this.x > 800+vx);
				trace(this.x <-250+vx);
			}
			
			//managing x
			if(pt.x < 50 && vx<0 && !(this.x > 800+vx)){//player has exceeded non-moving area, start moving map (left)
				this.x += -vx;
				p.x += vx;
				if(levelNumber == 7){
					darknessEffect.x += vx;
				}
			}
			else if(pt.x > 500 && vx>0 && !(this.x <-250+vx)){//player has exceeded non-moving area, start moving map (right)
				this.x += -vx;
				p.x += vx;
				if(levelNumber == 7){
					darknessEffect.x += vx;
				}
			}
			else{//if within moving area, just move the player
				if((pt.x > 0 && pt.x < 550) || (pt.x == 550 && vx<0) || (pt.x == 0 && vx>0)){//allow player to move only if within boundary OR is straddling boundary and is moving in the opposite direction of the boundary
					p.x += vx;
					if(levelNumber == 7){
						darknessEffect.x += vx;
					}
				}
			}
			
			//managing y
			if(pt.y < 50 && vy<0 && !(this.y > 330+vy)){
				//trace("hi");
				//trace(vy);
				//trace(pt.y);
				this.y += -vy;
				p.y += vy;
				if(levelNumber == 7){
					darknessEffect.y += vy;
				}
			}
			else if(pt.y > 350 && vy>0 && !(this.y < 70+vy)){
				//trace("bye");
				this.y += -vy;
				p.y += vy;
				if(levelNumber == 7){
					darknessEffect.y += vy;
				}
			}
			else{
				if((pt.y > 0 && pt.y < 400) || (pt.y == 0 && vy>0) || (pt.y == 400 && vy<0)){
					p.y += vy;
					if(levelNumber == 7){
						darknessEffect.y += vy;
					}	
				}
				
			}
		}
		
		
		public function walk(){
			//Codes:
			//0 left, 1 right, 2 up, 3 down
			
			//Frames:
			//for 1-12
			//back 13-24
			//LEFT/RIGHT 25-36
			
			if(globalWalking){
				if(globalDir == 0){
					p.scaleX=0.7;
					p.scaleY=0.7;
					//left
					if(p.currentFrame>36 || p.currentFrame < 25){
						//trace("r" + p.currentFrame);
						p.gotoAndStop(25);
					}
					else if(p.currentFrame == 36){
						//trace("last"+ p.currentFrame);
						p.gotoAndStop(25);
					}
					else{
						//trace("going"+ p.currentFrame);
						p.gotoAndStop(p.currentFrame+1);
					}
				}
				if(globalDir == 1){
					//right
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
				if(globalDir == 2){
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
				if(globalDir == 3){
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
			else {//If this 
				globalWalking = false;
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
		
		public function checkCollision(){
			for(var i:int=0;i<borderArray.length;i++){
				if(p.hitTestObject(borderArray[i])){
					p.x-=vx;
					p.y-=vy;
					if(levelNumber == 7){
						darknessEffect.x -= vx;
						darknessEffect.y -= vy;
					}	
				}
			}
			for(var j:int=0;j<actionItemArray.length;j++){
				
				if(ctrlDown && actionItemArray[j].hitTestObject(p)){
					ctrlDown = false;
					trace("blabhlah");
					var tempType = actionItemArray[j].returnProperties()[0];
					var tempMess = actionItemArray[j].returnProperties()[1];
					
					trace("interacted with: " + tempType + " with message " + tempMess);
					if(tempType == "sign"){
						createPrompt("message",tempMess,false);
					}
					
					else if(tempType == "door"){
						trace("Door going to: " + tempMess);
						var tempMessArray:Array = tempMess.split(",");
						if(tempMessArray[0] == "gym" || tempMessArray[0] == "house"){//check if going indoors
							inside = true;
							
							tempBarrierActionArray = null;
							tempBarrierActionArray = new Array();
							
							tempBarrierActionArray[0] = borderArray;
							borderArray = null;
							borderArray = new Array();
							
							tempBarrierActionArray[1] = actionItemArray;
							actionItemArray = null;
							actionItemArray = new Array();
							
							//inside specific area
							//create borders
							if(tempMessArray[0] == "gym"){
								if(parseInt(tempMessArray[1]) % 3 == 0){
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
									registerAction(-84,3,20,20,"sign","A%mysterious%stone%is%inside");
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
									
									p.x = 0;
									p.y = 205;
									this.x = 275;
									this.y = 180;
									
								}
								else if(parseInt(tempMessArray[1]) % 3 == 1){
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
									
									p.x = 0;
									p.y = 205;
									this.x = 275;
									this.y = 180;
									
								}
								else if(parseInt(tempMessArray[1]) % 3 == 2){
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
									
									p.x = 0;
									p.y = 205;
									this.x = 275;
									this.y = 180;
									
								}
								
							}
							else if(tempMessArray[0] == "house"){
								if(parseInt(tempMessArray[1]) % 3 == 0){
									
								}
								else if(parseInt(tempMessArray[1]) % 3 == 1){
									
								}
								else if(parseInt(tempMessArray[1]) % 3 == 2){
									
								}
							}
							this.addChild(blocker);
							this.setChildIndex(blocker,2);
							this.setChildIndex(p, this.numChildren - 1);//set player to be on top
						}
						else if(tempMessArray[0] == "pc"){
							trace("pc");
							for each(var pokemon in p.getInventory()[0]){
								trace(pokemon);
								pokemon[2] = 100;
							}
								
							createPrompt("message","Your%pokemon%have%been%%%%%healed",false);
								
						}
						else if(tempMessArray[0] == "shop"){
							trace("shop");
							if(p.getInventory()[1]['money'] > 99){
								p.changeItem("money","dec",100);
								p.changeItem("potion","inc");
								createPrompt("message","Bought%one%potion%for%100%%coins%" + p.getInventory()[1]['money'] + "%coins%left",false);
							}
							else{
								createPrompt("message","You%do%not%have%enough%coins",false);
							}
						}
					}
					else if(tempType == "trainer"){
						p.x -= vx;
						p.y -= vy;
						trace("going in with: " + p.getInventory()[1]['money']);
						if(!isNaN(parseInt(tempMess))){
							var tempMessInt:int = parseInt(tempMess);
							var trainerName:String
							
							if(tempMessInt == 0){
								createPrompt("message","You%will%never%defeat%me",false);
								trainerName = "Gov%Zari";
							}
							else if(tempMessInt == 1){
								createPrompt("message","Long%live%Kedenia",false);
								trainerName = "Gov%Asan";
							}
							else if(tempMessInt == 2){
								createPrompt("message","Five%plus%five%equals%eleven",false);
								trainerName = "Gov%Nardo";
							}
							else if(tempMessInt == 3){
								createPrompt("message","Math%is%life",false);
								trainerName = "Gov%Noen";
							}
							else if(tempMessInt == 4){
								createPrompt("message","You%will%not%take%over%Kedenia",false);
								trainerName = "Gov%Dao";
							}
							else if(tempMessInt == 5){
								createPrompt("message","Qudratics%rule",false);
								trainerName = "King%Wici";
							}
							TweenMax.delayedCall(3,startBattle,[trainerName]);
						}
						else {
							startBattle(tempMess);
						}
						
					}
					
				}//end ctrldown if
				
				try{
					if(p.hitTestObject(actionItemArray[j])){
						p.x-=vx;
						p.y-=vy;
						if(levelNumber == 7){
							darknessEffect.x -= vx;
							darknessEffect.y -= vy;
						}	
					}
				}
				catch(error:Error){
					//went inside, actionitemarray cleared
					//safe to pass
					trace("no probs");
				}
			}
		}
		
		public function printMouse(e:MouseEvent){
			trace("X: " + mouseX + " Y: " + mouseY);
		}
		
		public function checkFinished(){
			if(battling){
				if(arena.getIsFinished()){
					battling = false;
					p.setInventory(arena.getData());
					
					var tempFinal:Array = arena.getFinalMessage();
					
					if(tempFinal[0] != "-1"){
						createPrompt("message",tempFinal[0],false);
					}
					
					if(tempFinal[1]){//player won
						p.changeItem("money","inc",100);
					}
					else{//player lost
						p.changeItem("money","dec",100);
						trace("loser");
					}
					
					//if need to switch levels
					if(tempFinal[2]){
						TweenMax.delayedCall(3,exitLevel,[]);
					}
					this.removeChild(arena);
					arena = null;
					trace("money: " + p.getInventory()[1]['money']);
				}
			}
		}
		
		public function checkTutFinished(){
			if(inTutorial){
				isFinished = tut.getIsFinished();
			}
		}		
		
		public function gameLoop(e:Event)
		{
			movePlayer();
			checkCollision();
			walk();
			checkPrompt();
			checkFinished();
			checkTutFinished();
		}
	}//end class
}//end package