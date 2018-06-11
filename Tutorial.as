package
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.MovieClip;
	import flash.events.*;
	public class Tutorial extends MovieClip
	{
		var messageBox:MessageBox;
		var isFinished:Boolean;
		var blocker:Blocker;
		var detector:BorderTracker;
		var startButton:StartButton;
		var splashScreen:SplashScreen;
		var mouseOverButton:Boolean;
		var prompting:Boolean;

		public function Tutorial()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			
			isFinished = true;
			
			prompting = false;
			
			blocker = new Blocker();
			
			splashScreen = new SplashScreen();
			this.addChild(splashScreen);
			
			startButton = new StartButton();
			startButton.x = -141;
			startButton.y = 97;
			this.addChild(startButton);
			
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
			//fade oak in
			TweenMax.to(blocker,0.5,{alpha:0});
			TweenMax.delayedCall(0.5, firstMessage, []);
			this.removeChild(detector);
			this.removeChild(startButton);
			this.removeChild(splashScreen);
		}
		
		//starting the string of messages
		
		public function firstMessage(){
			messageBox = new MessageBox();
			messageBox.x = 0;
			messageBox.y = 153;
			messageBox.scaleX = 0.467;
			messageBox.scaleY = 0.467;
			messageBox.setText("hello");
			messageBox.startReveal();
			TweenMax.delayedCall(2, secondMessage, []);//delay for the next message to pop up
			this.addChild(messageBox);
		}
		
		public function secondMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("my%name%is%professor%mac");
			messageBox.startReveal();
			TweenMax.delayedCall(3, thirdMessage, []);
		}
		public function thirdMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("you%have%been%chosen%as%theone");
			messageBox.startReveal();
			TweenMax.delayedCall(4, fourthMessage, []);
		}
		public function fourthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("to%save%the%land%from%the%%invaders");
			messageBox.startReveal();
			TweenMax.delayedCall(4, fifthMessage, []);
		}
		public function fifthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("i%will%teach%you%how%to%%%%combat%them");
			messageBox.startReveal();
			TweenMax.delayedCall(4, sixthMessage, []);
		}
		public function sixthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("you%will%receive%a%pikachu%to%start%off");
			messageBox.startReveal();
			TweenMax.delayedCall(4, seventhMessage, []);
		}
		public function seventhMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("he%will%protect%you%on%yourjourney");
			messageBox.startReveal();
			TweenMax.delayedCall(4, eighthMessage, []);
		}
		public function eighthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("alongside%him%you%must%%%%%collect%others%as%well");
			messageBox.startReveal();
			TweenMax.delayedCall(5, ninthMessage, []);
		}
		public function ninthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("defeat%bosses%to%get%closerto%the%final%boss");
			messageBox.startReveal();
			TweenMax.delayedCall(5, tenthMessage, []);
		}
		public function tenthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("you%will%move%using%the%%%%arrow%keys");
			messageBox.startReveal();
			TweenMax.delayedCall(4, twelfthMessage, []);
		}
		public function twelfthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("attacks%are%q%w%e%r");
			messageBox.startReveal();
			TweenMax.delayedCall(3, thirteenthMessage, []);
		}
		public function thirteenthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("pokemon%and%their%stats%%%%will%be%shown%in%the%menu");
			messageBox.startReveal();
			TweenMax.delayedCall(5, fourteenthMessage, []);
		}
		public function fourteenthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("menu%can%be%accessed%using%tab");
			messageBox.startReveal();
			TweenMax.delayedCall(4, fifteenthMessage, []);
		}
		public function fifteenthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("every%time%you%will%engage%in%a%fight");
			messageBox.startReveal();
			TweenMax.delayedCall(4, sixteenthMessage, []);
		}
		public function sixteenthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("you%will%be%able%to%choose%the%pokemon%you%use");
			messageBox.startReveal();
			TweenMax.delayedCall(5, seventeenthMessage, []);
		}
		public function seventeenthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("use%arrow%keys%to%select%%%pokemon");
			messageBox.startReveal();
			TweenMax.delayedCall(4, eighteenthMessage, []);
		}
		public function eighteenthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("after%a%battle%head%to%a%%%pokecentre%to%heal");
			messageBox.startReveal();
			TweenMax.delayedCall(5, ninteenthMessage, []);
		}
		public function ninteenthMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("wait");
			messageBox.startReveal();
			TweenMax.delayedCall(2, twentiethMessage, []);
		}
		public function twentiethMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("oh%no");
			messageBox.startReveal();
			TweenMax.delayedCall(2, twentyfirstMessage, []);
		}
		public function twentyfirstMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("i%am%out%of%time");
			messageBox.startReveal();
			TweenMax.delayedCall(3, twentysecondMessage, []);
		}
		public function twentysecondMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			messageBox.setText("good%luck%on%your%journey");
			messageBox.startReveal();
			TweenMax.delayedCall(4, twentythirdMessage, []);
		}
		public function twentythirdMessage(){
			messageBox.destroyPrompt();
			messageBox.resetBox();
			TweenMax.delayedCall(1.5, setFinished, []);
			blocker.alpha = 1;
			this.addChild(blocker);
			TweenMax.from(blocker,1.5,{alpha:0});
		}
		
		public function setFinished(){//sets that the tutorial is finished
			isFinished = true;
		}
		
		public function getIsFinished(){
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