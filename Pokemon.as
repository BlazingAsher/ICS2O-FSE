package
{
	import flash.display.MovieClip;
	import flash.events.*;
	public class Pokemon extends MovieClip
	{
		var pokeType:String;
		
		public function Pokemon(tempType:String)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			pokeType = tempType;
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);
			
			//sprite notes
			
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
			
		}//end CONSTRUCTOR
		
		public function gameLoop(e:Event)
		{
			if(pokeType = "arceus"){
				if (this.currentFrame>=1 && this.currentFrame<=71){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==72)){
					this.gotoAndStop(1);				
				}
			}
			if(pokeType = "articuno"){
				if (this.currentFrame>=73 && this.currentFrame<=95){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==96)){
					this.gotoAndStop(73);	
				}
			}
			if(pokeType = "charizard"){
				if (this.currentFrame>=97 && this.currentFrame<=158){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==159)){
					this.gotoAndStop(97);					
				}
			}
			if(pokeType = "latias"){
				if (this.currentFrame>=160 && this.currentFrame<=206){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==207)){
					this.gotoAndStop(159);					
				}
			}
			if(pokeType = "latios"){
				if (this.currentFrame>=208 && this.currentFrame<=239){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==240)){
					this.gotoAndStop(208);				
				}
			}
			if(pokeType = "moltres"){
				if (this.currentFrame>=241 && this.currentFrame<=262){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==263)){
					this.gotoAndStop(241);
				}
			}
			if(pokeType = "pikachu"){
				if (this.currentFrame>=264 && this.currentFrame<=290){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==291)){
					this.gotoAndStop(264);	
				}
			}
			if(pokeType = "registeel"){
				if (this.currentFrame>=292 && this.currentFrame<=316){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==317)){
					this.gotoAndStop(292);	
				}
			}
			if(pokeType = "skarmory"){
				if (this.currentFrame>=318 && this.currentFrame<=358){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if(this.currentFrame==359)){
					this.gotoAndStop(318);				
				}
			}
			if(pokeType = "zapdos"){
				if (this.currentFrame>=360 && this.currentFrame<=386){
					this.gotoAndStop(this.currentFrame+1);
					//trace("next");
				}
				else if (this.currentFrame==387){
					this.gotoAndStop(360);
				}
			}
			
		}//gameloop
	}//end class
}//end package