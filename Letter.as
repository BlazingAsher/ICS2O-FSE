package
{
	import flash.display.MovieClip;
	import flash.events.*;
	public class Letter extends MovieClip
	{
		public function Letter(letterNumber:int)//CONSTRUCTOR - runs when the program starts
		//it has the same name as the class name - runs ONLY ONCE
		{
			this.gotoAndStop(letterNumber);
		}//end CONSTRUCTOR
		
	}//end class
}//end package