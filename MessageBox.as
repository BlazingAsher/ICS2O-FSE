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
			setup = false;//keeps track of whether the text is set
			
			boxType = "message"; //set the type of the box (message,yesno)
			
			promptActive = false;//is the yesno prompt active?
			textDone = false;//is the text done being revealed

			userResponse = -1;//the response of the user (0 is no, 1 is yes, -1 and -2 is null)
			
			myTimer = new Timer(50);
			myTimer.addEventListener(TimerEvent.TIMER,revealLetter);
			this.gotoAndStop(1);
			
		}//end CONSTRUCTOR
		
		public function setText(mess:String){//sets the messagebox type
			//store the message's letters into an array
			//27-36 are numbers!
			var tempArray:Array = new Array();
			tempArray = mess.toLowerCase().split("");
			
			//array to store the letters (symbols)
			letterArray = new Array();
			
			//set location of first letter
			var startx:int = -495;
			var starty:int = -40;
			
			for(var i:int=0;i<tempArray.length;i++){//convert the text into the symbols
				
				if(tempArray[i] == "%"){//% is the space symbol, since the split takes out spaces
					startx += 38;//add 38 pixels to the current location (makes a space)
					if(startx == 531){//if at the end, go to next line
						starty = 20;
						startx = -495;
					}
				}
				
				else{//not a space
					var frameNumber = tempArray[i].charCodeAt(0)-96;//convert the letter to its position in the alphabet
					
					if(!isNaN(Number(tempArray[i]))){//check if it is a number
						trace("is a number");
						frameNumber = tempArray[i].charCodeAt(0)-21;//convert the number into the proper frame
						trace("frame is: "+tempArray[i].charCodeAt(0)); 
					}
					else if(tempArray[i] == "."){//check if it is a period
						frameNumber = 37;
					}
					else if(tempArray[i] == ","){//check if it is a comma
						frameNumber = 38;
					}
					
					//create the letter
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
					
					//hide the letter; it will be revealed later
					letter.alpha = 0;
					letterArray.push(letter);
					this.addChild(letter);
				}
			}
			
			setup = true;//message has been set!
		}//setText
		
		public function startReveal(){//start displaying the letters
			if(setup == true){
				myTimer.start();
			}
			else{
				trace("messagebox not setup!");
			}
		}
		
		public function resetBox(){//remove EVERYTHING!
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
		
		public function changeBox(type:String){//change the box type (background)
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
		
		public function getResponse(){//returns the user's response
			return userResponse;
		}
		
		public function createPrompt(){//creates the yes/no prompt
			if(!promptActive){//check there is not already a prompt
							
				//create yesno box
				yesNo = new YesNo();
				yesNo.x = 310;
				yesNo.y = -320;
				yesNo.scaleX=1.5;
				yesNo.scaleY=1.5;
				yesNo.gotoAndStop(1);
				this.addChild(yesNo);
				
				//create the pointer
				pointer = new YesNo();
				pointer.x = 350;
				pointer.y = -245;
				pointer.scaleX=1.5;
				pointer.scaleY=1.5;
				pointer.gotoAndStop(2);
				this.addChild(pointer);
				
				promptActive = true;//notify that there is a prompt now, cannot create another!
			}
		}
		
		public function destroyPrompt(){//deletes the yes/no prompt
			if(promptActive){//if there is a yesno
				//destroy EVERYTHING
				this.removeChild(yesNo);
				this.removeChild(pointer);
				yesNo = null;
				pointer = null;
				promptActive = false;
			}
		}
		
		public function handleKeyboardDown(e:KeyboardEvent){//handles keyboard down
			if(promptActive){//if there is a prompt
				if(e.keyCode == Keyboard.DOWN){//move pointer down, or loop it back around
					//moves the pointer
					if(pointer.y == -183){
						pointer.y -= 62;
					}else{
						pointer.y += 62;
					}
					
					trace(pointer.y);
				}
				else if(e.keyCode == Keyboard.UP){//move pointer down, or loop it back around
					if(pointer.y == -245){
						pointer.y += 62;
					}
					else{
						pointer.y -= 62;
					}
				}
			}
			
			if(e.keyCode == Keyboard.ENTER && textDone){//if the text is finished displaying and user presses enter
				if(promptActive){//there was a prompt, so return the value (0 = no, 1 = yes)
					userResponse = (pointer.y+183)/-62;
					trace(userResponse);
				}
				else{//no prompt, but the user has interacted
					userResponse = -2;
				}
			}
		}
		
		public function handleKeyboardUp(e:KeyboardEvent){//handles keyboard up (no use)
			//empty on purpose!
		}
		
		private function revealLetter(e:TimerEvent){//start revealing the letters (alpha to 1)
			if(setup){//make sure a message is set!
				if(boxType == "battlenoti" || boxType == "battleprompt"){//if is type with blue background, make text white
					var ct1:ColorTransform = new ColorTransform(-1,-1,-1,1,255,255,255,0); 
					letterArray[currIndex].transform.colorTransform = ct1;
				}
				letterArray[currIndex].alpha = 1;
				currIndex++;
				if(currIndex == letterArray.length){//at the end, stop
					myTimer.stop();
					textDone = true;//finished reveal
					//reset();
				}
			}
		}
	}//end class
}//end package