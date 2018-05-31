package
{
	import flash.display.MovieClip;
	import flash.events.*;
	public class Pokemon extends MovieClip
	{
		var pokeType:String;
		var lightningArr,fireArr,metalArr,airArr,ghostArr,bossArr,movesArr:Array;
		var pMove:int;
		
		public function Pokemon(tempType:String)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			pokeType = tempType;
		    this.addEventListener(Event.ENTER_FRAME,gameLoop);
			trace("created");
			this.gotoAndStop(1);
			
			
//--------------------------------------------------------
			
			//SPRITE NOTES
			
			//arceus      1-72
			//articuno    73-96
			//charizard   97-159
			//latias      160-207
			//latios      208-240
			//moltres     241-263
			//pikachu     264-291
			//registeel   292-317
			//skarmory    318-359
			//zapdos      360-386
			//darkrai     
			//gyarados    
			//mew         
			//mewtwo      
			//onix        
			//rapidash    
			
//----------------------------------------------------------
			
			
			//POKEMON MOVES LIST
			
			
			//LIGHTNING Type ====== Pikachu, Zapdos
			//Shock Wave
			//Zap Cannon
			//Thunderbolt
			//Electroweb
			//Charge Beam
			//Discharge
			//Ion Deluge
			//Bolt Strike
			//Eerie impulse
			//Volt Switch
			
			
			//FIRE Type ============ Moltres, Charizard
			//Inferno Overdrive
			//Magma Storm
			//Lava Plume
			//Blue Flare
			//Flamethrower
			//Incinerate
			//Heat Wave
			//Eruption
			//Fire Blast
			//Overheat
			
			
			//METAL Type ======= Registeel, Skarmory
			//Fissure
			//Earthquake
			//Magnitude
			//Precipice Blades
			//Tectonic Rage
			//Thousand Waves
			//Mud Shot
			//Land's Wrath
			//Bone Rush
			//Bulldoze
			
			
			//AIR Type ========= Arceus, Articuno
			//Aerial Ace
			//Dragon Ascent
			//Oblivion Wing
			//Supersonic Skystrike
			//Tailwind
			//Hurricane
			//Aeroblast
			//Air Slash
			//Gust
			//Beak Blast
			
			
			//GHOST Type ======== Latios, Latias
			//Black Hole Eclipse
			//Dark Pulse
			//Hyperspace Fury
			//Night Slash
			//Payback
			//Sucker Punch
			//Dark Void
			//Hone Claws
			//Knock off
			//Torment
			
			
			//Darkrai
			//
			//
			//
			//
			
			
			//Gyarados
			//
			//
			//
			//
			
			
			//Mew
			//
			//
			//
			//
			
			
			//Mewtwo
			//
			//
			//
			//
			
			
			//Onix
			//
			//
			//
			//
			
			
			//Rapidash
			//
			//
			//
			//
			
//-----------------------------------------------

			pMove = 0;
			movesArr = new Array();
			
			lightningArr = new Array('Shock Wave','Zap Cannon','Thunderbolt','Electroweb','Charge Beam','Discharge','Ion Deluge','Bolt Strike','Eerie Impulse','Volt Switch');
			for(var i:int=0;i<4;i++){
				pMove = Math.random()*10-i;
				movesArr.push(lightningArr[pMove]);
				lightningArr.splice(i,1);
				
				
			}
			
			trace(movesArr);
			/*fireArr = new Array();
			for(var i:int = 0;i<fireArr.length;i++){
				pMove = Math.random()*10;
				//trace(pMove);
				trace(fireArr[pMove]);
				
				var dup:Boolean = false;
				
				for(var j:int=0;j<movesArr.length;j++){
					if(movesArr[j] == fireArr[i]){
						dup = true;
					}
				}
				
				if(!dup){
					movesArr.push(fireArr[pMove]);
				}
			}*/
			
			
		}//end CONSTRUCTOR
		
		public function gameLoop(e:Event)
		{
			//trace(this.currentFrame);
			
			if(pokeType == "arceus"){
				trace("jay is smart");
				if (this.currentFrame>=1 && this.currentFrame<=71){
					trace("looooooool");
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==72){
					trace("laoglfg");
					this.gotoAndStop(1);				
				}
			}
			if(pokeType == "articuno"){
				trace("artiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
				if (this.currentFrame>=73 && this.currentFrame<=95){
					this.gotoAndStop(this.currentFrame+1);
				   trace("next");
				}
				else if(this.currentFrame==96){
					this.gotoAndStop(73);	
				}
				else{
					this.gotoAndStop(73);	
				}
			}
			if(pokeType == "charizard"){
				if (this.currentFrame>=97 && this.currentFrame<=158){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==159){
					this.gotoAndStop(97);					
				}
				else{
					this.gotoAndStop(97);	
				}
			}
			if(pokeType == "latias"){
				if (this.currentFrame>=160 && this.currentFrame<=206){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==207){
					this.gotoAndStop(160);					
				}
				else{
					this.gotoAndStop(160);	
				}
			}
			if(pokeType == "latios"){
				if (this.currentFrame>=208 && this.currentFrame<=239){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==240){
					this.gotoAndStop(208);				
				}
				else{
					this.gotoAndStop(208);	
				}
			}
			if(pokeType == "moltres"){
				if (this.currentFrame>=241 && this.currentFrame<=263){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==264){
					this.gotoAndStop(241);
				}
				else{
					this.gotoAndStop(241);	
				}
			}
			if(pokeType == "pikachu"){
				if (this.currentFrame>=265 && this.currentFrame<=290){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==291){
					this.gotoAndStop(265);	
				}
				else{
					this.gotoAndStop(265);	
				}
			}
			if(pokeType == "registeel"){
				if (this.currentFrame>=292 && this.currentFrame<=316){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==317){
					this.gotoAndStop(292);	
				}
				else{
					this.gotoAndStop(292);	
				}
			}
			if(pokeType == "skarmory"){
				if (this.currentFrame>=318 && this.currentFrame<=359){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==360){
					this.gotoAndStop(318);				
				}
				else{
					this.gotoAndStop(318);	
				}
			}
			if(pokeType == "zapdos"){
				if (this.currentFrame>=361 && this.currentFrame<=386){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if (this.currentFrame==387){
					this.gotoAndStop(361);
				}
				else{
					this.gotoAndStop(361);	
				}
			}
			
		}//gameloop
	}//end class
}//end package