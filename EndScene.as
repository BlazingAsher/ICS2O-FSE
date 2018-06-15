package{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.*;
	
	public class EndScene extends MovieClip{

		var isFinished:Boolean;
		var messageBox:MessageBox;
		var prompting:Boolean;
		
		public function EndScene(){
			// constructor code
			
			//initialize variables
			isFinished = false;
			prompting = false;
			
			//start messages
			TweenMax.delayedCall(0.5, firstMessage, []);
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
		}
		
		public function firstMessage(){//displays message
			
			//creates the message box
			messageBox = new MessageBox();
			messageBox.x = 0;
			messageBox.y = 153;
			messageBox.scaleX = 0.467;
			messageBox.scaleY = 0.467;
			messageBox.setText("Congratulations");
			messageBox.startReveal();
			TweenMax.delayedCall(2, secondMessage, []);//delay for the next message to pop up
			this.addChild(messageBox);
		}
		
		public function secondMessage(){//displays message
			
			//destroy the previous message box
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("You%have%defeated%the%math%syndicate");//setup a new box
			messageBox.startReveal();
			TweenMax.delayedCall(3.5, thirdMessage, []);
		}
		
		public function thirdMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("The%kingdom%is%now%free");
			messageBox.startReveal();
			TweenMax.delayedCall(3.5, fourthMessage, []);
		}
		
		public function fourthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("Thank%you");
			messageBox.startReveal();
			TweenMax.delayedCall(3, playAgainMessage, []);
		}
		
		public function playAgainMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("Would%you%like%to%play%%%%%again");
			messageBox.createPrompt();
			prompting = true;
			messageBox.startReveal();
		}
		
		public function getResponse(){//returns if the player wants to play again
			if(prompting){
				var response:int = messageBox.getResponse();
				if(response == 1){//yes
					//clean exit
					exitLevel();
				}
				else if(response == 0){//no
					//sass the player, plus no good way to terminate anyway
					TweenMax.delayedCall(0.1,showTooBad,[]);
				}
			}
		}
		
		public function showTooBad(){//sasses the player
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("Too%bad");
			messageBox.createPrompt();
			messageBox.startReveal();
			TweenMax.delayedCall(2,exitLevel,[]);//exit the level, delay to make sure player can read the message
		}
		
		public function exitLevel(){//exit the level
			isFinished = true;
		}
		
		public function handleKeyboardDown(e){//handles keyboard down
			if(prompting){//passes keystrokes to messagebox
				messageBox.handleKeyboardDown(e);
			}
		}
		
		public function handleKeyboardUp(e){//handles keyboardup
			//empty on purpose@
		}
		
		public function getIsFinished(){//returns whether the end scene is finished
			return isFinished;
		}
		
		public function gameLoop(e:Event){
			getResponse();
		}
	}
	
}
