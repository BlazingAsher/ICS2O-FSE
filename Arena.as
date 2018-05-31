package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	import flash.ui.*;
	import flash.geom.*;
	import flash.display.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	public class Arena extends MovieClip
	{
		var playerPoke,enePoke:Dictionary;
		var isFinished:Boolean;
		var levelOpen:int;
		var messageBox:MessageBox;
		var pointer:YesNo;
		var pokePlayer,pokeEne:Pokemon;
		var onPlayer:Boolean;
		var switchTurns:Boolean;
		var action:String;
		var currPoke:String;
		var vx,vy:int;
		var bulletArray,eneBulletArray:Array;
		var movesLeft:Array;
		var pHealth,eHealth,eDamage:int;

		public function Arena(player:Dictionary)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			
			vx = 0;
			vy = 0;
			
			eHealth = 100; //can change depeneding on boss
			eDamage = 10; //can change depending on boss
			
			bulletArray = new Array();
			eneBulletArray = new Array();
			
			isFinished = false;
			playerPoke = player;
			
			onPlayer = true;
			switchTurns = false;
			
			currPoke = "";
			
			messageBox = new MessageBox();
			messageBox.x = 0;
			messageBox.y = 153;
			messageBox.scaleX = 0.467;
			messageBox.scaleY = 0.467;
			messageBox.setText("Someone%has%challenged%you%to%a%battle");
			messageBox.changeBox("battlenoti");
			messageBox.startReveal();
			TweenMax.delayedCall(5, messageBox.destroyPrompt, []);
			TweenMax.delayedCall(5, messageBox.resetBox, []);
			TweenMax.delayedCall(5, afterPromptSetup, []);
			this.addChild(messageBox);
			
		}//end CONSTRUCTOR
		
		public function afterPromptSetup(){
			
			//this.removeChild(messageBox);
			trace(this.y);
			TweenMax.to(this,1.5,{y:50});
			TweenMax.to(messageBox,1.5,{y:203});
			TweenMax.delayedCall(1.5,removeChild,[messageBox]);
			addPlayer();
			addEne();
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			TweenMax.delayedCall(1, eneAttack, [1]);
		}
		
		public function addPlayer(){
			var firstPoke:String;
			
			for each(var poke in playerPoke){
				trace(poke);
				if(poke[1] == 1)
				{
					trace("triggered");
					firstPoke = poke[0];
					currPoke = poke[0];
				}
			}
			
			pokePlayer = new Pokemon(firstPoke);
			pokePlayer.scaleX = 0.9;
			pokePlayer.x = 185;
			TweenMax.from(pokePlayer,0.75,{x:250});
			pokePlayer.y = 8;
			this.addChild(pokePlayer);
			
			pHealth = playerPoke[currPoke][2];
			trace("phealth: " + pHealth);
		}
		
		public function addEne(){
			var firstPoke:String;
			for each(var poke in playerPoke){
				trace(poke);
				if(poke[1] == 1)
				{
					trace("triggered");
					firstPoke = poke[0];
				}
			}
			
			pokeEne = new Pokemon(firstPoke);
			pokeEne.scaleX = -0.9;
			pokeEne.x = -193;
			TweenMax.from(pokeEne,0.75,{x:-250});
			pokeEne.y = 8;
			this.addChild(pokeEne);
		}
		
		public function handleKeyboardDown(e){
			if(e.keyCode == Keyboard.DOWN){
				vy = 2;
			}
			else if(e.keyCode == Keyboard.UP){
				vy = -2;
			}
			else if(e.keyCode == Keyboard.LEFT){
				vx = -2;
			}
			else if(e.keyCode == Keyboard.RIGHT){
				vx = 2;
			}
		}
		
		public function handleKeyboardUp(e){
			trace("safgf");
			if(e.keyCode == Keyboard.DOWN){
				vy = 0;
			}
			else if(e.keyCode == Keyboard.UP){
				vy = 0;
			}
			else if(e.keyCode == Keyboard.LEFT){
				vx = 0;
			}
			else if(e.keyCode == Keyboard.RIGHT){
				vx = 0;
			}
			if(e.keyCode == 81){
				//Q
				trace("attack 1");
				attack(1);
			}
			if(e.keyCode == 87){
				//W
				trace("attack 2");
				attack(2);
			}
			if(e.keyCode == 69){
				//E
				trace("attack 3");
				attack(3);
			}
			if(e.keyCode == 82){
				//R
				trace("attack 4");
				attack(4);
			}
		}
		
		public function movePlayer(){
			pokePlayer.x+=vx;
			pokePlayer.y+=vy;
		}
		
		public function moveEne(){
			if(pokeEne.x>pokePlayer.x){
				pokeEne.x += -0.3;
			}
			else if(pokeEne.x<pokePlayer.x){
				pokeEne.x += 0.3;
			}
			
			if(pokeEne.y<pokePlayer.y){
				pokeEne.y += 1;
			}
			else if(pokeEne.y>pokePlayer.y){
				pokeEne.y += -1;
			}
		}
		
		public function attack(attackNumber:int){
			var circle:Shape = new Shape();
			
			if(currPoke == "pikachu" || currPoke == "zapdos"){
				circle.graphics.beginFill(0xFFFF00, 1);
			}
			else if(currPoke == "moltres" || currPoke == "charizard"){
				circle.graphics.beginFill(0xFF6600, 1);
			}
			else if(currPoke == "registeel" || currPoke == "skarmory"){
				circle.graphics.beginFill(0x777777, 1);
			}
			else if(currPoke == "arceus" || currPoke == "articuno"){
				circle.graphics.beginFill(0x87ceeb, 1);
			}
			else if(currPoke == "latios" || currPoke == "latias"){
				circle.graphics.beginFill(0xFF00FF, 1);
			}
			
			circle.graphics.drawCircle(pokePlayer.x-5,pokePlayer.y,3);
			circle.graphics.endFill();
			
			this.addChild(circle);
			var damage:int = 0;
			
			switch(attackNumber){
				case 1:
					damage = 4;
					break;
					
				case 2:
					damage = 2;
					break;
					
				case 3:
					damage = 8;
					break;
					
				case 4:
					damage = 10;
					break;
			}
			//store damage along with the bullet
			var bullData:Array = new Array(circle,damage);
			bulletArray.push(bullData);
		}
		
		public function eneAttack(times:int){
			for(var i:int=0;i<times;i++){
				var circle:Shape = new Shape();
				circle.graphics.beginFill(0x990000, 1);
				circle.graphics.drawCircle(pokeEne.x+5,pokeEne.y,3);
				circle.graphics.endFill();
				
				addChild(circle);
				eneBulletArray.push(circle);
			}
			var time:int = Math.random()*2;
			var times:int = Math.random()*10;
			TweenMax.delayedCall(time, eneAttack, [times]);
		}
		
		public function getIsFinished(){
			return isFinished;
		}
		
		public function moveBullets(){
			for(var i:int=0;i<bulletArray.length;i++){
				bulletArray[i][0].x -= 5;
			}
			for(var j:int=0;j<eneBulletArray.length;j++){
				eneBulletArray[j].x += 5;
			}
		}
		
		public function checkCollision(){
			for(var i:int=0;i<bulletArray.length;i++){
				if(bulletArray[i][0].hitTestObject(pokeEne)){
					eHealth -= bulletArray[i][1];
					this.removeChild(bulletArray[i][0]);
					bulletArray.splice(i,1);
				}
			}
			for(var j:int=0;j<eneBulletArray.length;j++){
				if(eneBulletArray[0].hitTestObject(pokePlayer)){
					pHealth -= eDamage;
					this.removeChild(eneBulletArray[j]);
					eneBulletArray.splice(j,1);
				}
			}
		}
		
		public function gameLoop(e:Event)
		{
			moveBullets();
			movePlayer();
			moveEne();
			checkCollision();
			trace("phealth: " + pHealth + " eHealth: " + eHealth);
		}
		
	}//end class
}//end package