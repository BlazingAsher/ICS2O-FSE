package{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.*;
	
	public class EndScene extends MovieClip{

		var isFinished:Boolean;
		
		public function EndScene(){
			// constructor code
			isFinished = false;
		}
		
		public function handleKeyboardDown(e){
			if(e.keyCode == Keyboard.SHIFT){
				isFinished = true;
			}
		}
		
		public function handleKeyboardUp(e){
			
		}
		
		public function getIsFinished(){
			return isFinished;
		}
	}
	
}
