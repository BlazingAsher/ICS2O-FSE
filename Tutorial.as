package
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.MovieClip;
	import flash.events.*;
	public class Tutorial extends MovieClip
	{
		var messageBox:MessageBox;
		var isFinished:Boolean;//whether the tutorial is finished
		var blocker:Blocker;//black background (fade in/out)
		var detector:BorderTracker;//small square that will detect if the mouse collides with anything
		var startButton:StartButton;//start button
		var splashScreen:SplashScreen;//pikachu background
		var mouseOverButton:Boolean;//whether the mouse is hovering over the start button
		var prompting:Boolean;//whether the user is being prompted

		public function Tutorial()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			
			//set variables default value
			isFinished = false;
			
			prompting = false;
			
			blocker = new Blocker();
			
			splashScreen = new SplashScreen();
			this.addChild(splashScreen);
			
			//create start button
			startButton = new StartButton();
			startButton.x = -141;
			startButton.y = 97;
			this.addChild(startButton);
			
			//create the detector
			detector = new BorderTracker();
			detector.alpha = 0;
			detector.scaleX = 0.05;
			detector.scaleY = 0.05;
			this.addChild(detector);
			
			this.addEventListener(MouseEvent.CLICK,startGame);
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			
		}//end CONSTRUCTOR
		
		public function checkButtonHover(){//check if the button is hovering over the start button
			//set detector x to mousex
			detector.x = mouseX;
			detector.y = mouseY;
			if(detector.hitTestObject(startButton)){//if it hits, set larger scale
				startButton.scaleX = 1.25;
				startButton.scaleY = 1.25;
				mouseOverButton = true;
			}
			else{//if not, set the scale to regular
				startButton.scaleX = 1;
				startButton.scaleY = 1;
				mouseOverButton = false;
			}
		}
		
		public function startGame(e:MouseEvent){//starts the game
			if(mouseOverButton){//if the mouse is currently over the button
				prompting = true;
				//fade in/out effect
				this.addChild(blocker);
				//slowly fade blocker (black screen) in
				TweenMax.from(blocker,0.5,{alpha:0});
				TweenMax.delayedCall(0.5, fadeIn, []);
			}
			
		}
		
		public function fadeIn(){
			//slowly fade blocker (black screen) out
			//fade prof. mac in
			TweenMax.to(blocker,0.5,{alpha:0});
			TweenMax.delayedCall(0.5, showMessage, [0]);
			this.removeChild(detector);
			this.removeChild(startButton);
			this.removeChild(splashScreen);
		}
		
		public function showMessage(messageNumber:int){//displays the messages
			var msgText:String;//store message text
			var msgDelay:Number;//how long to leave the messagebox open
			
			//either intialize the messagebox, or change the one already created
			if(messageNumber == 0){
				messageBox = new MessageBox();
				messageBox.x = 0;
				messageBox.y = 153;
				messageBox.scaleX = 0.467;
				messageBox.scaleY = 0.467;
				this.addChild(messageBox);
			}
			else{
				messageBox.destroyPrompt();
				messageBox.resetBox();
			}
			
			//set the text and delay
			switch(messageNumber){
				case 0:
					msgText = "Hello,my%name%is%professor%mac";
					//msgText = "done";
					msgDelay = 1.5;
					break;
				case 1:
					msgText = "You%are%here%to%help%us%%%%defeat%the%math%syndicate";
					msgDelay = 5;
					break;
				case 2:
					msgText = "They%have%come%and%taken%%%over%the%kingdom";
					msgDelay = 4;
					break;
				case 3:
					msgText = "To%move,use%the%arrow%keys";
					msgDelay = 1.5;
					break;
				case 4:
					msgText = "To%talk%to%someone,read%a%%sign,or%open%a%door";
					msgDelay = 1.5;
					break;
				case 5:
					msgText = "Press%ctrl%while%running%%%into%it";
					msgDelay = 3.5;
					break;
				case 6:
					msgText = "Use%q,w,e,r%to%attack";
					msgDelay = 3;
					break;
				case 7:
					msgText = "You%can%only%use%a%move%so%many%times";
					msgDelay = 5;
					break;
				case 8:
					msgText = "Check%the%sidebar%for%the%%number%of%times%left";
					msgDelay = 5;
					break;
				case 9:
					msgText = "If%your%health%is%low,pressINSERT%to%heal%up";
					msgDelay = 5;
					break;
				case 10:
					msgText = "After%a%battle,you%can%alsogo%to%a%poke%centre";
					msgDelay = 5;
					break;
				case 11:
					msgText = "To%view%your%inventory,%%%%press%and%hold%TAB";
					msgDelay = 4.9;
					break;
				case 12:
					msgText = "You%can%buy%more%potions%atthe%shops%for%100%each";
					msgDelay = 5;
					break;
				case 13:
					msgText = "If%you%beat%a%boss,%you%get100%dollars";
					msgDelay = 4.7;
					break;
				case 14:
					msgText = "Head%to%Mallet%Town%and%%%%find%Jeff%in%his%house";
					msgDelay = 4.5;
					break;
				case 15:
					msgText = "He%will%give%you%some%%%%%%Pokemon%to%start";
					msgDelay = 4;
					break;
				case 16:
					msgText = "There%is%also%a%hidden%%%%%portal";
					msgDelay = 4;
					break;
				case 17:
					msgText = "It%will%take%you%into%the%%ruling%regions";
					msgDelay = 4.5;
					break;
				case 18:
					msgText = "Oh,and%press%enter%to%%%%%%dismiss%a%message";
					msgDelay = 4.5;
					break;
				case 19:
					msgText = "Good%luck";
					msgDelay = 2;
					break;
				case 20:
					msgText = "done";
					break;
			}
			
			//recursive back into this function, unless it is the last one
			if(msgText != "done"){
				//show message
				messageBox.setText(msgText);
				messageBox.startReveal();
				TweenMax.delayedCall(5, showMessage, [messageNumber+1]);
			}
			else{
				TweenMax.delayedCall(1.5, setFinished, []);
				blocker.alpha = 1;
				this.addChild(blocker);
				TweenMax.from(blocker,1.5,{alpha:0});
			}
			
		}
		
		public function setFinished(){//sets that the tutorial is finished
			isFinished = true;
			trace("finished");
		}
		
		public function getIsFinished(){//returns whether the tutorial has finished playing
			return isFinished;
		}
		
		public function gameLoop(e:Event)
		{
			if(!prompting){//if a message box is not active (on title screen), check if the mouse is hovering over the button
				checkButtonHover();
			}
		}
	}//end class
}//end package