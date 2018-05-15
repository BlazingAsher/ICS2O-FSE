package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	public class MainPoke extends MovieClip
	{
		var poke:Pokemon;
		var showArc,showArt,showChar,showIas,showIos,showMt,showPik,showReg,showSk,showZap:Boolean;

		public function MainPoke()//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			
			showArc = false;
			showArt = false;
			showChar = false;
			showIas = false;
			showIos = false;
			showMt = false;
			pokemon = new Pokemon("pikachu")
			var tempType = "pikachu"
			showPik = false;
			showReg = false;
			showSk = false;
			showZap = false;
			
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
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyP);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyU);
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);
		}//end CONSTRUCTOR
		
		function keyP(e:KeyboardEvent){
			if(e.keyCode == 49){
				showArc=true;
				trace("arc");
				poke = new Pokemon("poke");
				poke.x = 275;
				poke.y = 200;
				stage.addChild(poke);
				showArc = false;
			}
			if(e.keyCode == 50){
				showArt=true;
				trace("art");
				poke = new Pokemon("poke");
				poke.x = 275;
				poke.y = 200;
				stage.addChild(poke);
				showArt = false;
			}
			if(e.keyCode == 51){
				showChar=true;
				trace("char");
				poke = new Pokemon("poke");
				poke.x = 275;
				poke.y = 200;
				stage.addChild(poke);
				showChar = false;
			}
			if(e.keyCode == 52){
				showIas=true;
				trace("ias");
				poke = new Pokemon("poke");
				poke.x = 275;
				poke.y = 200;
				stage.addChild(poke);
				showIas = false;
			}
			if(e.keyCode == 53){
				showIos=true;
				trace("ios");
				poke = new Pokemon("poke");
				poke.x = 275;
				poke.y = 200;
				stage.addChild(poke);
				showIos = false;
			}
			if(e.keyCode == 54){
				showMt=true;
				trace("mt");
				poke = new Pokemon("poke");
				poke.x = 275;
				poke.y = 200;
				stage.addChild(poke);
				showMt = false;
			}
			if(e.keyCode == 55){
				showPik=true;
				trace("pik");
				poke = new Pokemon("poke");
				poke.x = 275;
				poke.y = 200;
				stage.addChild(poke);
				showPik = false;
			}
			if(e.keyCode == 56){
				showReg=true;
				trace("reg");
				poke = new Pokemon("poke");
				poke.x = 275;
				poke.y = 200;
				stage.addChild(poke);
				showReg = false;
			}
			if(e.keyCode == 57){
				showSk=true;
				trace("sk");
				poke = new Pokemon("poke");
				poke.x = 275;
				poke.y = 200;
				stage.addChild(poke);
				showSk = false;
			}
			if(e.keyCode == 48){
				showZap=true;
				trace("zap");
				poke = new Pokemon("poke");
				poke.x = 275;
				poke.y = 200;
				stage.addChild(poke);
				showZap = false;
			}
		}
		function keyU(e:KeyboardEvent){
		}
		
		
		public function gameLoop(e:Event){
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
			//trace(showArc)
			if(showArc){
				//trace(poke.currentFrame)
				if (stage.contains(poke) && poke.currentFrame==72){
					//poke.gotoAndStop(72);
					stage.removeChild(poke);
				}
				else if (stage.contains(poke) && poke.currentFrame>=1 && poke.currentFrame<=71){
					poke.gotoAndStop(poke.currentFrame+1);
					trace("next");
				}
				else if(stage.contains(poke)){
					poke.gotoAndStop(1);				
				}
			}
			if(showArt){
				if (stage.contains(poke) && poke.currentFrame==96){
					stage.removeChild(poke);
				}
				if (stage.contains(poke) && poke.currentFrame>=73 && poke.currentFrame<=95){
					poke.gotoAndStop(poke.currentFrame+1);
					trace("next");
				}
				else if(stage.contains(poke)){
					poke.gotoAndStop(73);	
				}
			}
			if(showChar){
				if (stage.contains(poke) && poke.currentFrame==159){
					stage.removeChild(poke);
				}
				if (stage.contains(poke) && poke.currentFrame>=97 && poke.currentFrame<=158){
					poke.gotoAndStop(poke.currentFrame+1);
					trace("next");
				}
				else if(stage.contains(poke)){
					poke.gotoAndStop(97);					
				}
			}
			if(showIas){
				if (stage.contains(poke) && poke.currentFrame==207){
					stage.removeChild(poke);
				}
				if (stage.contains(poke) && poke.currentFrame>=160 && poke.currentFrame<=206){
					poke.gotoAndStop(poke.currentFrame+1);
					trace("next");
				}
				else if(stage.contains(poke)){
					poke.gotoAndStop(159);					
				}
			}
			if(showIos){
				if (stage.contains(poke) && poke.currentFrame==240){
					stage.removeChild(poke);
				}
				if (stage.contains(poke) && poke.currentFrame>=208 && poke.currentFrame<=239){
					poke.gotoAndStop(poke.currentFrame+1);
					trace("next");
				}
				else if(stage.contains(poke)){
					poke.gotoAndStop(208);				
				}
			}
			if(showMt){
				if (stage.contains(poke) && poke.currentFrame==263){
					stage.removeChild(poke);
				}
				if (stage.contains(poke) && poke.currentFrame>=241 && poke.currentFrame<=262){
					poke.gotoAndStop(poke.currentFrame+1);
					trace("next");
				}
				else if(stage.contains(poke)){
					poke.gotoAndStop(241);
				}
			}
			if(showPik){
				if (stage.contains(poke) && poke.currentFrame==291){
					stage.removeChild(poke);
				}
				if (stage.contains(poke) && poke.currentFrame>=264 && poke.currentFrame<=290){
					poke.gotoAndStop(poke.currentFrame+1);
					trace("next");
				}
				else if(stage.contains(poke)){
					poke.gotoAndStop(264);	
				}
			}
			if(showReg){
				if (stage.contains(poke) && poke.currentFrame==317){
					stage.removeChild(poke);
				}
				if (stage.contains(poke) && poke.currentFrame>=292 && poke.currentFrame<=316){
					poke.gotoAndStop(poke.currentFrame+1);
					trace("next");
				}
				else if(stage.contains(poke)){
					poke.gotoAndStop(292);	
				}
			}
			if(showPik){
				if (stage.contains(poke) && poke.currentFrame==359){
					stage.removeChild(poke);
				}
				if (stage.contains(poke) && poke.currentFrame>=318 && poke.currentFrame<=358){
					poke.gotoAndStop(poke.currentFrame+1);
					trace("next");
				}
				else if(stage.contains(poke)){
					poke.gotoAndStop(318);				
				}
			}
			if(showZap){
				if (stage.contains(poke) && poke.currentFrame==387){
					stage.removeChild(poke);
				}
				if (stage.contains(poke) && poke.currentFrame>=360 && poke.currentFrame<=386){
					poke.gotoAndStop(poke.currentFrame+1);
					trace("next");
				}
				else if(stage.contains(poke)){
					poke.gotoAndStop(360);				
				}
			}
		}//gameloop
		
	}//end class
}//end package