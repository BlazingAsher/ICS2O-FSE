package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	import flash.ui.*;
	import flash.geom.*;
	import flash.display.*;
	import flash.text.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	public class Arena extends MovieClip
	{
		var playerPoke,enePoke,playerInv:Dictionary;
		var isFinished:Boolean;
		var messageBox:MessageBox;
		var pokePlayer,pokeEne:Pokemon;
		var currPoke:String;
		var vx,vy:int;
		var bulletArray,eneBulletArray,assetArray:Array;
		var movesLeft:Array;
		var pHealth,eHealth,eDamage:int;
		var pHealthBar,eHealthBar:Shape;
		var blocker:Blocker;
		var gymName:String;
		var txtChoosePokemon:TextField;
		var txtChoosePokemonFormat:TextFormat;

		public function Arena(player:Array,gym:String)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			
			gymName = gym;
			
			vx = 0;
			vy = 0;
			
			movesLeft = new Array();
			movesLeft[0] = 10;
			movesLeft[1] = 15;
			movesLeft[2] = 20;
			movesLeft[3] = Number.POSITIVE_INFINITY;
			
			eHealth = 100; //can change depeneding on boss
			eDamage = 4; //can change depending on boss
			
			bulletArray = new Array();
			eneBulletArray = new Array();
			assetArray = new Array();
			
			isFinished = false;
			playerPoke = player[0];
			playerInv = player[1];
			
			currPoke = "";
			
			blocker = new Blocker();
			this.addChild(blocker);
			
			//circle through pokemon
			
			txtChoosePokemon = new TextField();
			txtChoosePokemonFormat = new TextFormat();
			
			txtChoosePokemon.x = -176.5;
			txtChoosePokemon.y = -11.5;
			txtChoosePokemon.y = -121.5;
			this.addChild(txtChoosePokemon);
			txtChoosePokemon.text = "Choose a battle Pokemon";
			txtChoosePokemonFormat.color = 0xFFFFFF;
			txtChoosePokemonFormat.size = 26;
			txtChoosePokemonFormat.font = "Tekton Pro Ext";
			txtChoosePokemon.autoSize = TextFieldAutoSize.LEFT;
			txtChoosePokemon.setTextFormat(txtChoosePokemonFormat);
			
			var i:int = 0;
			for each(var poke in playerPoke){
				var pokeImage:Pokemon = new Pokemon(poke[0]);
				pokeImage.x = -131 + 135*i;
				pokeImage.y = -40;
				if(i>2){
					pokeImage.x = -131 + 135*(i-3);
					pokeImage.y = 65;
				}
				assetArray.push(pokeImage);
				this.addChild(pokeImage);
				i++;
			}
			
			trace("w: " + txtChoosePokemon.width + "l: " + txtChoosePokemon.length);
		}//end CONSTRUCTOR
		
		public function afterChosen(player:Array,gym:String){
			messageBox = new MessageBox();
			messageBox.x = 0;
			messageBox.y = 153;
			messageBox.scaleX = 0.467;
			messageBox.scaleY = 0.467;
			messageBox.setText(gymName + "%has%challenged%you%to%a%battle");
			messageBox.changeBox("battlenoti");
			messageBox.startReveal();
			TweenMax.delayedCall(5, messageBox.destroyPrompt, []);
			TweenMax.delayedCall(5, messageBox.resetBox, []);
			TweenMax.delayedCall(5, afterPromptSetup, []);
			this.addChild(messageBox);
		}
		
		public function afterPromptSetup(){
			
			//this.removeChild(messageBox);
			trace(this.y);
			TweenMax.to(this,1.5,{y:this.y+49.5});
			TweenMax.to(messageBox,1.5,{y:203});
			TweenMax.delayedCall(1.5,removeChild,[messageBox]);
			addPlayer();
			addEne();
			createAssets();
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
			
			if(playerPoke[currPoke].length < 4){
				var returnedDataArray:Array = generateMoves(playerPoke[currPoke][0]);
				playerPoke[currPoke][3] = returnedDataArray[0];
				playerPoke[currPoke][4] = returnedDataArray[1];
				playerPoke[currPoke][5] = returnedDataArray[2];
				playerPoke[currPoke][6] = returnedDataArray[3];
				trace(playerPoke[currPoke]);
			}
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
		
		public function generateMoves(pokeName:String){
			var availableMoves:Array = new Array();
			var tempMoves:Array = new Array();
			var pMove:int = 0;
			var lightningArr,fireArr,metalArr,airArr,ghostArr,darkraiArr,gyaradosArr,mewArr,mewtwoArr,onixArr,rapidashArr;
			
			lightningArr = new Array('shock','zap','bolt','electro','charge','discharge','ion','strike','impulse','volt');
			fireArr = new Array('inferno','magma','lava','flare','flame','incinerate','heat','eruption','fire','overheat');
			metalArr = new Array('fissure','earthquake','magnitude','blades','rage','waves','sharpen','wrath','rush','bulldoze');
			airArr = new Array('aerial','ascent','oblivion','skystrike','tailwind','hurricane','aeroblast','slash','gust','peck');
			ghostArr = new Array('eclipse','pulse','fury','haunt','payback','punch','void','claws','spook','torment');
			
			if(pokeName == "pikachu" || pokeName == "zapdos"){
				availableMoves = lightningArr;
			}
			else if(pokeName == "moltres" || pokeName == "charizard"){
				availableMoves = fireArr;
			}
			else if(pokeName == "registeel" || pokeName == "skarmory"){
				availableMoves = metalArr;
			}
			else if(pokeName == "arceus" || pokeName == "articuno"){
				availableMoves = airArr;
			}
			else if(pokeName == "latios" || pokeName == "latias"){
				availableMoves = ghostArr;
			}
			
			for(var i:int=0;i<4;i++){
				pMove = Math.random()*10-i;
				tempMoves.push(availableMoves[pMove]);
				availableMoves.splice(i,0);
				trace(i + " left: " + availableMoves);
			}
			
			return tempMoves;
		}
		
		public function createAssets(){
			pHealthBar = new Shape();
			pHealthBar.graphics.beginFill(0x00FF00); // choosing the colour for the fill, here it is red
			pHealthBar.graphics.drawRect(0, 0, 100,10); // (x spacing, y spacing, width, height)
			pHealthBar.graphics.endFill(); // not always needed but I like to put it in to end the fill
			pHealthBar.x = 175;
			pHealthBar.y = -250;
			if(pHealth<100){
				pHealthBar.x -= 100-pHealth;
			}
			this.addChild(pHealthBar);
			
			eHealthBar = new Shape();
			eHealthBar.graphics.beginFill(0xFF0000); // choosing the colour for the fill, here it is red
			eHealthBar.graphics.drawRect(0, 0, 100,10); // (x spacing, y spacing, width, height)
			eHealthBar.graphics.endFill(); // not always needed but I like to put it in to end the fill
			eHealthBar.x = -275;
			eHealthBar.y = -250;
			this.addChild(eHealthBar);
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
				attack(0);
			}
			if(e.keyCode == 87){
				//W
				trace("attack 2");
				attack(1);
			}
			if(e.keyCode == 69){
				//E
				trace("attack 3");
				attack(2);
			}
			if(e.keyCode == 82){
				//R
				trace("attack 4");
				attack(3);
			}
			if(e.keyCode == Keyboard.INSERT){
				if(playerInv['potion'] != null && playerInv['potion'] > 0){
					trace("heal pokemon");
					playerInv['potion']--;
					pHealth += 50;
					if(pHealth > 100){
						pHealth = 100;
					}
				}
				else if(playerInv['potion'] == null || playerInv['potion'] < 1){
					trace("nsf");
				}
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
			if(movesLeft[attackNumber] > 0){
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
				else{
					circle.graphics.beginFill(0x000000, 1);
				}
				circle.graphics.drawCircle(pokePlayer.x-5,pokePlayer.y,3);
				circle.graphics.endFill();
				
				this.addChild(circle);
				var damage:int = 0;
				
				switch(attackNumber){
					case 0:
						damage = 4;
						break;
						
					case 1:
						damage = 2;
						break;
						
					case 2:
						damage = 8;
						break;
						
					case 3:
						damage = 10;
						break;
				}
				//store damage along with the bullet
				var bullData:Array = new Array(circle,damage);
				bulletArray.push(bullData);
				movesLeft[attackNumber]--;
			}//end if
			
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
			var time:int = Math.random()*5;
			var times:int = Math.random()*5;
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
					trace("phealth: " + pHealth + " eHealth: " + eHealth);
					this.removeChild(bulletArray[i][0]);
					bulletArray.splice(i,1);
				}
				else if(bulletArray[i][0].x < -450){
					this.removeChild(bulletArray[i][0]);
					bulletArray.splice(i,1);
				}
				//trace("agfsgas: " + bulletArray[i][0].x); 
			}
			for(var j:int=0;j<eneBulletArray.length;j++){
				if(eneBulletArray[0].hitTestObject(pokePlayer)){
					pHealth -= eDamage;
					trace("phealth: " + pHealth + " eHealth: " + eHealth);
					this.removeChild(eneBulletArray[j]);
					eneBulletArray.splice(j,1);
				}
				else if(eneBulletArray[j].x > 450){
					this.removeChild(eneBulletArray[j]);
					eneBulletArray.splice(j,1);
				}
			}
		}
		
		public function checkFinished(){
			if(pHealth < 0){
				trace("enemy won!");
				playerPoke[currPoke][2] = 0;
				isFinished = true;
				this.removeEventListener(Event.ENTER_FRAME,gameLoop);
			}
			else if(eHealth < 0){
				trace("player won!");
				playerPoke[currPoke][2] = pHealth;
				isFinished = true;
				this.removeEventListener(Event.ENTER_FRAME,gameLoop);
			}
		}
		
		public function getData(){
			var dataPack:Array;
			dataPack = new Array();
			dataPack[0] = playerPoke;
			dataPack[1] = playerInv;
			return dataPack;
		}
		
		public function getFinalMessage(){
			var dataPack:Array = new Array();
			dataPack[0] = "message";
			if(eHealth < 0){
				dataPack[1] = true; //player won
			}
			else{
				dataPack[1] = false; //ai won
			}
			return dataPack;
		}
		
		public function updateHealth(){
			pHealthBar.x = 175 + (100 - pHealth);
			eHealthBar.x = -275 - (100 - eHealth);
		}
		
		public function gameLoop(e:Event)
		{
			moveBullets();
			movePlayer();
			moveEne();
			checkCollision();
			checkFinished();
			updateHealth();
			//trace("phealth: " + pHealth + " eHealth: " + eHealth);
		}
		
	}//end class
}//end package