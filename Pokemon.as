package
{
	import flash.display.MovieClip;
	import flash.events.*;
	public class Pokemon extends MovieClip
	{
		var pokeType:String;//name of the pokemon
		var movingEnabled:Boolean;//whether the pokemon should be animation
		var initialized:Boolean;//whether the pokemon is initialized (prevents permature stop of frame)
		
		public function Pokemon(tempType:String)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			//initalizes the variables
			pokeType = tempType;
			movingEnabled = true;
			initialized = false;
			pokeType = pokeType.toLowerCase();
		    this.addEventListener(Event.ENTER_FRAME,gameLoop);
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
			//Shock
			//Zap
			//Bolt
			//Electro
			//Charge
			//Discharge
			//Ion
			//Strike
			//Impulse
			//Volt
			
			
			//FIRE Type ============ Moltres, Charizard
			//Inferno
			//Magma
			//Lava
			//Flare
			//Flame
			//Incinerate
			//Heat
			//Eruption
			//Fire
			//Overheat
			
			
			//METAL Type ======= Registeel, Skarmory
			//Fissure
			//Earthquake
			//Magnitude
			//Blades
			//Rage
			//Waves
			//Sharpen
			//Wrath
			//Rush
			//Bulldoze
			
			
			//AIR Type ========= Arceus, Articuno
			//Aerial
			//Ascent
			//Oblivion
			//Skystrike
			//Tailwind
			//Hurricane
			//Aeroblast
			//Slash
			//Gust
			//Peck
			
			
			//GHOST Type ======== Latios, Latias
			//Eclipse
			//Pulse
			//Fury
			//Haunt
			//Payback
			//Punch
			//Void
			//Claws
			//Spook
			//Torment

			
//-----------------------------------------------
			
			
		}//end CONSTRUCTOR
		
		public function startMoving(){//start the animation
			movingEnabled = true;
		}
		public function stopMoving(){//stop the animation
			movingEnabled = false;
		}

		public function getProperties(){
			var tempArray:Array = new Array();
			tempArray[0] = pokeType;
			return tempArray;
		}
		
		public function gameLoop(e:Event)
		{
			if(movingEnabled || !initialized){//if moving enabled, or the frame has never been changed from the default
				if(pokeType == "arceus"){
					if (this.currentFrame>=1 && this.currentFrame<=71){
						this.gotoAndStop(this.currentFrame+1);
					}
					else if(this.currentFrame==72){
						trace("laoglfg");
						this.gotoAndStop(1);				
					}
				}
				if(pokeType == "articuno"){
					if (this.currentFrame>=73 && this.currentFrame<=95){
						this.gotoAndStop(this.currentFrame+1);
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
					if (this.currentFrame>=319 && this.currentFrame<=359){
						this.gotoAndStop(this.currentFrame+1);
						//trace("next");
					}
					else if(this.currentFrame==360){
						this.gotoAndStop(319);				
					}
					else{
						this.gotoAndStop(319);	
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
				if(pokeType == "darkrai"){
					if (this.currentFrame>=388 && this.currentFrame<=449){
						this.gotoAndStop(this.currentFrame+1);
						//trace("next");
					}
					else if(this.currentFrame==450){
						this.gotoAndStop(388);					
					}
					else{
						this.gotoAndStop(388);	
					}
				}
				if(pokeType == "gyarados"){
					if (this.currentFrame>=451 && this.currentFrame<=488){
						this.gotoAndStop(this.currentFrame+1);
						//trace("next");
					}
					else if(this.currentFrame==489){
						this.gotoAndStop(451);					
					}
					else{
						this.gotoAndStop(451);	
					}
				}
				if(pokeType == "mew"){
					if (this.currentFrame>=490 && this.currentFrame<=539){
						this.gotoAndStop(this.currentFrame+1);
						//trace("next");
					}
					else if(this.currentFrame==540){
						this.gotoAndStop(490);					
					}
					else{
						this.gotoAndStop(490);	
					}
				}
				if(pokeType == "mewtwo"){
					if (this.currentFrame>=541 && this.currentFrame<=593){
						this.gotoAndStop(this.currentFrame+1);
						//trace("next");
					}
					else if(this.currentFrame==594){
						this.gotoAndStop(541);					
					}
					else{
						this.gotoAndStop(541);	
					}
				}
				if(pokeType == "onix"){
					if (this.currentFrame>=595 && this.currentFrame<=638){
						this.gotoAndStop(this.currentFrame+1);
						//trace("next");
					}
					else if(this.currentFrame==639){
						this.gotoAndStop(595);
					}
					else{
						this.gotoAndStop(595);	
					}
				}
				if(pokeType == "rapidash"){
					if (this.currentFrame>=640 && this.currentFrame<=659){
						this.gotoAndStop(this.currentFrame+1);
						//trace("next");
					}
					else if(this.currentFrame==660){
						this.gotoAndStop(640);					
					}
					else{
						this.gotoAndStop(640);	
					}
				}
			
				initialized = true;//the pokemon has gone through at least one cycle
			}//end movingenabled if
			
		}//gameloop
	}//end class
}//end package