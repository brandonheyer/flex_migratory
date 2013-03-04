package engine.graphics2D
{

/**
 * A timer keeps track of time between frames and FPS for a game
 *  
 * @author Brandon Heyer
 */
public class Timer
{
	//--------------------------------------------------------------------------
	//
	// Variable Declarations
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 * The last frame start time 
	 */	
	private var beginTime:Number;
	
	/**
	 * @private
	 * The current time
	 */
	private var currTime:Number
	
	/**
	 * @private
	 * The time between the current and last frame 
	 */	
	private var frameLength:Number;
	
	//--------------------------------------------------------------------------
	//
	// Public Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */	
	public function Timer() {
		beginTime = 0;
		frameLength = 0;
	}
	
	/**
	 * Calculate the next time step / frame
	 */	
	public function tick():void {
		currTime = (new Date()).time;
		
		// There is a small probablility that framelenght may be zero
		// This could cause problems and it is more realisitcally closer
		// to 1, so set it as such
		if ((currTime - beginTime == 0) || (beginTime == 0))
			frameLength = 1;
		else
			frameLength = currTime - beginTime;
		
		beginTime = currTime;
	}
	
	/**
	 * Get the frames per second
	 *  
	 * @return the frames per second
	 */	
	public function getFPS():Number {
		return 1.0 / getDelta();
	}
	
	/**
	 * Get the time since last update in seconds
	 *  
	 * @return the time since last update in seconds
	 */	
	public function getDelta():Number {
		return frameLength / 1000.0;
	}
}
}