package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	public class Level extends MovieClip
	{

		var levelTimer:Timer;
		var vx,vy:int;
		var p:Ash;
		var borderTracker:BorderTracker;
		var assetArray,borderArray,actionItemArray:Array;
		var troubleshooting:Boolean;
		var globalWalking:Boolean;
		var globalDir:int;
		var isFinished:Boolean;
		var walkingDisabled:Boolean;
		var ctrlDown:Boolean;
		var actionItem:ActionItem;
		
		//w = 1600
		//h = 668
		
		public function Level(levelNumber:int)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			createAssets(levelNumber);
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			
		}//end CONSTRUCTOR
		
		public function getIsFinished(){
			return isFinished;
		}
		
		public function createAssets(levelNumber:int){
			//right is increase
			//left is decrease
			
			//down is increase
			//up is decrease
			
			isFinished = false;
			
			assetArray = new Array();
			borderArray = new Array();
			actionItemArray = new Array();
			
			p = new Ash();
			
			switch(levelNumber){//create borders based on the level
				case 0:
					walkingDisabled = true;
					p.alpha = 0;
					this.gotoAndStop(1);
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
					registerAction(-505,200,115,95,"sign","CHANGEME");
					
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
					registerAction(-92,-49,20,20,"sign","CHANGEME");
					//HouseDoor1
					registerAction(69,12,20,20,"door","CHANGEME");
					//HouseDoor2
					registerAction(69,-216,20,20,"door","CHANGEME");
					//Gym Sign
					registerAction(290,-255,20,20,"sign","CHANGEME");
					//Gym Door
					registerAction(417,-247,20,20,"door","CHANGEME");
					//PCDoor
					registerAction(101,268,20,20,"door","CHANGEME");
					//ShopDoor
					registerAction(423,45,20,20,"door","CHANGEME");
					
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
					registerAction(-252,182,20,20,"door","CHANGEME");
					//gymsign
					registerAction(-380,171,20,20,"sign","CHANGEME");
					//martdoor
					registerAction(163,247,20,20,"door","CHANGEME");
					//sign
					registerAction(516,279,20,20,"sign","CHANGEME");
					//housedoor
					registerAction(323,19,20,20,"door","CHANGEME");
					//museamdoor
					registerAction(-208,-124,20,20,"door","CHANGEME");
					//museamsidedoor
					registerAction(69,-204,20,20,"door","CHANGEME");
					//muesaemsign
					registerAction(-123,-103,20,20,"sign","CHANGEME");
					//pcdoor
					registerAction(356,-139,20,20,"door","CHANGEME");
					
					//Set frame
					this.gotoAndStop(4);
					//Set player coordinates
					
					break;
				case 4:
					//Create barriers
					
					//Create ActionItem handlers
					
					//Set frame
					this.gotoAndStop(5);
					//Set player coordinates
					
					break;
				case 5:
					//Create barriers
					
					//Create ActionItem handlers
					
					//Set frame
					this.gotoAndStop(6);
					//Set player coordinates
					
					break;
				case 6:
					//Create barriers
					
					//Create ActionItem handlers
					
					//Set frame
					this.gotoAndStop(7);
					//Set player coordinates
					
					break;
			}
			
			vx = 0;
			vy = 0;
			
			p.gotoAndStop(1);
			p.scaleX=0.7;
			p.scaleY=0.7;
			this.addChild(p);
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
			actionItemArray.push(actionItem);
			this.addChild(actionItem);
		}
		
		public function handleKeyboardDown(e:KeyboardEvent){
			if(!walkingDisabled){
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
					isFinished = true;
					trace("done level1");
			}
		}
		
		public function handleKeyboardUp(e:KeyboardEvent){
			if(!walkingDisabled){
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
			}
			else if(pt.x > 500 && vx>0 && !(this.x <-250+vx)){//player has exceeded non-moving area, start moving map (right)
				this.x += -vx;
				p.x += vx;
			}
			else{//if within moving area, just move the player
				if((pt.x > 0 && pt.x < 550) || (pt.x == 550 && vx<0) || (pt.x == 0 && vx>0)){//allow player to move only if within boundary OR is straddling boundary and is moving in the opposite direction of the boundary
					p.x += vx;
				}
			}
			
			//managing y
			if(pt.y < 50 && vy<0 && !(this.y > 330+vy)){
				//trace("hi");
				//trace(vy);
				//trace(pt.y);
				this.y += -vy;
				p.y += vy;
			}
			else if(pt.y > 350 && vy>0 && !(this.y < 70+vy)){
				//trace("bye");
				this.y += -vy;
				p.y += vy;
			}
			else{
				if((pt.y > 0 && pt.y < 400) || (pt.y == 0 && vy>0) || (pt.y == 400 && vy<0)){
					p.y += vy;
				}
				
			}
		}
		
		
		function walk(){
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
				}
			}
						for(var j:int=0;j<actionItemArray.length;j++){
				if(p.hitTestObject(actionItemArray[j]) && ctrlDown){
					p.x-=vx;
					p.y-=vy;
					trace("blabhlah");
					var tempType = actionItemArray[j].returnProperties()[0];
					var tempMess = actionItemArray[j].returnProperties()[1];
					
					trace("interacted with: " + tempType + " with message " + tempMess);
					if(tempType == "sign"){
						trace("Sign says: " + tempMess);
					}
					else if(tempType == "door"){
						trace("Door going to: " + tempMess);
					}
				}
			}
		}
		
		public function printMouse(e:MouseEvent){
			trace("X: " + mouseX + " Y: " + mouseY);
		}
		
		public function gameLoop(e:Event)
		{
			movePlayer();
			checkCollision();
			walk();
			//p.x = mouseX;
			//p.y = mouseY;
		 	//trace("hi");
		}
	}//end class
}//end package