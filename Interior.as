package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.*;
	import flash.geom.*;
	public class Interior extends MovieClip
	{
		var loc:String;
		var p:Ash;
		var globalWalking,ctrlDown,isFinished,walkingDisabled,troubleshooting,prompting:Boolean;
		var globalDir,vx,vy:int;
		var messageBox:MessageBox;
		public function Interior(tempLoc:String)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			loc = tempLoc;
			p = new Ash();
			globalWalking = false;
			ctrlDown = false;
			isFinished = false;
			walkingDisabled = false;
			troubleshooting = false;
			prompting = false;
			globalDir = 0;
			vx = 0;
			vy = 0;
			messageBox = new MessageBox();
			this.addChild(p);
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			
		}//end CONSTRUCTOR
		
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
		
		public function handleKeyboardDown(e:KeyboardEvent){
			if(prompting){
				//trace("prompting");
				messageBox.handleKeyboardDown(e);
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
					isFinished = true;
					//trace("done level1");
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
		
		public function getIsFinished(){
			return isFinished;
		}
		
		public function gameLoop(e:Event){
			walk();
		}
		
	}//end class
}//end package