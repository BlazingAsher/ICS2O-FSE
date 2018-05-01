package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	public class LevelOne extends MovieClip
	{

		var levelTimer:Timer;
		var vx,vy:int;
		var p:Ash;
		var borderTracker:BorderTracker;
		var assetArray:Array;
		var troubleshooting:Boolean;
		var globalWalking:Boolean;
		var globalDir:int;
		
		//w = 1600
		//h = 668
		
		public function LevelOne()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			createAssets();
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			
		}//end CONSTRUCTOR
		
		public function getLevelStatus(){
			return "test";
		}
		
		public function createAssets(){
			
			assetArray = new Array();
			
			for(var j:int=0;j<7;j++){
				borderTracker = new BorderTracker();
				borderTracker.x = -570; //increase to right
				borderTracker.y = -210; //increase up, decrease down
				this.addChild(borderTracker)
			}
			
			vx = 0;
			vy = 0;
			
			p = new Ash();
			p.gotoAndStop(1);
			p.scaleX=0.7;
			p.scaleY=0.7;
			this.addChild(p);
			
			for(var i:int=0;i<4;i++){ //check whether to move player or background
				borderTracker = new BorderTracker();
				if(i == 0){
					borderTracker.x = -800;
					borderTracker.y = 334;
				}
				else if(i == 1){
					borderTracker.x = -800;
					borderTracker.y = -334;
				}
				else if(i == 2){
					borderTracker.x = 800;
					borderTracker.y = 334;
				}
				else{
					borderTracker.x = 800;
					borderTracker.y = -334;
				}
				
				this.addChild(borderTracker);
				assetArray.push(borderTracker);
			}
			
		}
		
		public function handleKeyboardDown(e:KeyboardEvent){
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
		}
		
		public function handleKeyboardUp(e:KeyboardEvent){
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
		}
		
		public function doWalkingAnimation(walking:Boolean,dir:int){
			globalWalking=walking;
			globalDir=dir;
			
		}
		
		public function movePlayer(){
			var outOfBounds:Boolean = false;
			
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
			if(pt.x < 50 && vx<0 && !outOfBounds && !(this.x > 800+vx)){//player has exceeded non-moving area, start moving map (left)
				
				this.x += -vx;
				p.x += vx;
			}
			else if(pt.x > 500 && vx>0 && !outOfBounds && !(this.x <-250+vx)){//player has exceeded non-moving area, start moving map (right)
				this.x += -vx;
				p.x += vx;
			}
			else{//if within moving area, just move the player
				if((pt.x > 0 && pt.x < 550) || (pt.x == 550 && vx<0) || (pt.x == 0 && vx>0)){//allow player to move only if within boundary OR is straddling boundary and is moving in the opposite direction of the boundary
					p.x += vx;
				}
			}
			
			//managing y
			if(pt.y < 50 && vy<0 && !outOfBounds && !(this.y > 330+vy)){
				//trace("hi");
				trace(vy);
				trace(pt.y);
				this.y += -vy;
				p.y += vy;
			}
			else if(pt.y > 350 && vy>0 && !outOfBounds && !(this.y < 70+vy)){
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
			//0 left, 1 right, 2 up, 3 down
			
			//for 1-12
//back 13-24
//LEFT/RIGHT 25-36
			if(globalWalking){
				if(globalDir == 0){
					p.scaleX=0.7;
					p.scaleY=0.7;
					//left
					if(p.currentFrame>36 || p.currentFrame < 25){
						trace("r" + p.currentFrame);
						p.gotoAndStop(25);
					}
					else if(p.currentFrame == 36){
						trace("last"+ p.currentFrame);
						p.gotoAndStop(25);
					}
					else{
						trace("going"+ p.currentFrame);
						p.gotoAndStop(p.currentFrame+1);
					}
				}
				else if(globalDir == 1){
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
				else if(globalDir == 2){
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
				else if(globalDir == 3){
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
			else {
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
		
		public function gameLoop(e:Event)
		{
			movePlayer();
			walk();
			//p.x = mouseX;
			//p.y = mouseY;
		 	//trace("hi");
		}
	}//end class
}//end package