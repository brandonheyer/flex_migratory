package engine.graphics2D
{
import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;

import mx.events.FlexEvent;

import spark.primitives.BitmapImage;

/**
 * A video controller is the central controller which handles frame updates
 * and is the canvas for which the game is drawn to, and double buffered to
 *  
 * @author Brandon Heyer
 */
public class VideoController extends BitmapImage
{
	//--------------------------------------------------------------------------
	//
	// Variable Declarations
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 * The timer for the game 
	 */	
	private var gameTimer:Timer;
		
	/**
	 * @private
	 * The game itself 
	 */	
	private var _game:Game;
	
	/**
	 * @private
	 * The secondary buffer 
	 */	
	private var _backBuffer:BitmapData;
		
	/**
	 * @private
	 * The clear color for the buffer 
	 */
	private var _clearColor:uint = 0x000000;			
	
	//--------------------------------------------------------------------------
	//
	// Event Handlers
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Handle creation complete event by setting everything up
	 */	
	protected function creationCompleteHandler(event:Event):void {
		removeEventListener(Event.ACTIVATE, 
							creationCompleteHandler);
		
		_backBuffer = new BitmapData(width, height, false, _clearColor);	
		
		gameTimer = new Timer();						
	}	
	
	//--------------------------------------------------------------------------
	//
	// Public Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 	 
	 */	
	public function VideoController() {												
		addEventListener(FlexEvent.READY, creationCompleteHandler);		
	}
	
	/**
	 * Update is the cyclic event for all games, it causes an update
	 * to all components of the game (through the game instance) as well
	 * as a draw from all components (again through the game instance) 
	 */	
	public function update():void {
		// Advace game time
		gameTimer.tick();
		
		// Bubble the update call
		_game.update(gameTimer.getDelta());
		
		// Clear the buffer
		_backBuffer.fillRect(_backBuffer.rect, _clearColor);
		
		// Bubble the draw call
		_game.draw(_backBuffer);
		
		// Copy the back buffer to the screen
		(source as BitmapData).copyPixels(_backBuffer, 
										  _backBuffer.rect, 
										  new Point(0, 0));
	}
	
	//--------------------------------------------------------------------------
	//
	// Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * The clear color for the frame
	 */
	public function get clearColor():uint {
		return _clearColor;
	}
	
	/**
	 * @private
	 */
	public function set clearColor(value:uint):void {
		_clearColor = value;
	}	
	
	/**
	 * The game instance
	 */
	public function get game():Game {
		return _game;
	}
	
	/**
	 * @private
	 */
	public function set game(value:Game):void {
		_game = value;
	}
	
	/** 
	 * The current frames per second
	 * 
	 * TODO: this could probably be extended to get a smoother agregate 
	 * over the course of several seconds	 
	 */
	public function get fps():Number {
		return gameTimer.getFPS();
	}

}
}