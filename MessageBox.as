package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*; 
	import flash.utils.Timer;
	import flash.ui.Keyboard;
	public class MessageBox extends MovieClip
	{
		var letterArray:Array;
		var myTimer:Timer;
		var currIndex:int = 0;
		var setup:Boolean;
		var returnValue:int;
		var boxType:String;
		var userResponse:int;
		var promptActive,textDone:Boolean;
		var yesNo,pointer:YesNo;
		
		public function MessageBox()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			setup = false;
			
			boxType = "message";
			
			promptActive = false;
			textDone = false;

			userResponse = -1;
			
			myTimer = new Timer(50);
			myTimer.addEventListener(TimerEvent.TIMER,revealLetter);
			this.gotoAndStop(1);
			
		}//end CONSTRUCTOR
		
		public function setText(mess:String){
			//store the message's letters into an array
			//27-36 are numbers!
			var tempArray:Array = new Array();
			tempArray = mess.toLowerCase().split("");
			
			//array to store the letters
			letterArray = new Array();
			
			var startx:int = -495;
			var starty:int = -40;
			
			for(var i:int=0;i<tempArray.length;i++){
				
				if(tempArray[i] == "%"){//% is the space symbol, since the split takes out spaces
					startx += 38;
					//trace(frameNumber + "," + startx);
					if(startx == 531){
						starty = 20;
						startx = -495;
					}
				}
				else{
					var frameNumber = tempArray[i].charCodeAt(0)-96;//convert the letter to its position in the alphabet
					if(!isNaN(Number(tempArray[i]))){
						trace("is a number");
						frameNumber = tempArray[i].charCodeAt(0)-21;
						trace("frame is: "+tempArray[i].charCodeAt(0)); 
					}
					var letter:Letter = new Letter(frameNumber);
					
					letter.scaleX = 0.2;
					letter.scaleY = 0.2;
					letter.x = startx;
					letter.y = starty;
					//increase the position and check if about to go over the box
					startx += 38;
					trace(frameNumber + "," + startx);
					if(startx == 531){
						starty = 20;
						startx = -495;
					}
					letter.alpha = 0;
					letterArray.push(letter);
					this.addChild(letter);
				}
			}
			
			setup = true;
		}//setText
		
		public function startReveal(){
			if(setup == true){
				myTimer.start();
			}
			else{
				trace("messagebox not setup!");
			}
		}
		
		public function resetBox(){
			for(var i:int=0;i<letterArray.length;i++){
				this.removeChild(letterArray[i]);
				letterArray.splice(i,0);
			}
			trace(letterArray.length);
			letterArray = null;
			letterArray = new Array();
			currIndex = 0;
			setup = false;
			userResponse = -1;
			textDone = false;
		}
		
		public function changeBox(type:String){
			switch(type){
				case "message":
					boxType = type;
					this.gotoAndStop(1);
					break;
				case "battlenoti":
					boxType = type;
					this.gotoAndStop(2);
					break;
				case "battleprompt":
					boxType = type;
					this.gotoAndStop(3);
					break;
			}
		}
		
		
		
		public function getResponse(){
			return userResponse;
		}
		
		public function createPrompt(){
			if(!promptActive){
							
				yesNo = new YesNo();
				yesNo.x = 310;
				yesNo.y = -320;
				yesNo.scaleX=1.5;
				yesNo.scaleY=1.5;
				yesNo.gotoAndStop(1);
				this.addChild(yesNo);
				
				pointer = new YesNo();
				pointer.x = 350;
				pointer.y = -245;
				pointer.scaleX=1.5;
				pointer.scaleY=1.5;
				pointer.gotoAndStop(2);
				this.addChild(pointer);
				
				promptActive = true;
			}
		}
		
		public function destroyPrompt(){
			if(promptActive){
				this.removeChild(yesNo);
				this.removeChild(pointer);
				yesNo = null;
				pointer = null;
				promptActive = false;
			}
		}
		
		public function handleKeyboardDown(e:KeyboardEvent){
			if(promptActive){
				if(e.keyCode == Keyboard.DOWN){
					if(pointer.y == -183){
						pointer.y -= 62;
					}else{
						pointer.y += 62;
					}
					
					trace(pointer.y);
				}
				else if(e.keyCode == Keyboard.UP){
					if(pointer.y == -245){
						pointer.y += 62;
					}
					else{
						pointer.y -= 62;
					}
				}
			}
			else if(boxType == "battleprompt"){
				
			}
			
			if(e.keyCode == Keyboard.ENTER && textDone){
				if(promptActive){
					userResponse = (pointer.y+183)/-62;
					trace(userResponse);
				}
				else{
					userResponse = -2;
				}
			}
		}
		
		public function handleKeyboardUp(e:KeyboardEvent){
			
		}
		
		private function revealLetter(e:TimerEvent){
			if(setup){
				if(boxType == "battlenoti" || boxType == "battleprompt"){
					var ct1:ColorTransform = new ColorTransform(-1,-1,-1,1,255,255,255,0); 
					letterArray[currIndex].transform.colorTransform = ct1;
				}
				letterArray[currIndex].alpha = 1;
				currIndex++;
				if(currIndex == letterArray.length){
					myTimer.stop();
					textDone = true;
					//reset();
				}
			}
		}
	}//end class
}//end package