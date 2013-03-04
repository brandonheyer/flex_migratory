package engine.graphics2D
{
import flash.geom.Point;

/**
 * The coordinate translator allows for conversion between world and 
 * screen units. This way we don't always have to think in pixels
 *  
 * @author Brandon Heyer 
 */
public class CoordinateTranslator
{
	
	//--------------------------------------------------------------------------
	//
	// Variable Declarations
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 * The screen's width
	 */
	private var _screenWidth:uint;
	
	/**
	 * @private
	 * The screen's height
	 */
	private var _screenHeight:uint;
	
	/**
	 * @private
	 * The world's width
	 */
	private var _worldWidth:Number;
	
	/**
	 * @private
	 * The world's height
	 */
	private var _worldHeight:Number;
	
	/**
	 * @private
	 * The lower left location of the world
	 */
	private var _lowerLeft:Point2D;
	
	//--------------------------------------------------------------------------
	//
	// Public Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor. 
	 * 
	 * @param screenWidth the screen's width
	 * @param screenHeight the screen's height
	 * @param worldWidth the world's width
	 * @param worldHeight the world's height
	 * @param lowerLeft the lower left point of the world	 
	 */	
	public function CoordinateTranslator(screenWidth:uint, 
										 screenHeight:uint, 
										 worldWidth:Number, 
										 worldHeight:Number, 
										 lowerLeft:Point2D) {
		_screenWidth = screenWidth;
		_screenHeight = screenHeight;
		_worldWidth = worldWidth;
		_worldHeight = worldHeight;
		_lowerLeft = new Point2D(lowerLeft.x, lowerLeft.y);
	}
	
	/**
	 * Convert a screen point to a world point
	 *  
	 * @param p the screen's pixel point
	 * @return the worlds point	 
	 */	
	public function screenToWorld(p:Point):Point2D {
		var worldX:Number = ((_worldWidth * p.x) / _screenWidth) +
			_lowerLeft.x;
		
		var worldY:Number = _worldHeight + _lowerLeft.y - 
			((p.y * _worldHeight) / _screenHeight);
		
		return new Point2D(worldX, worldY);
	}
	
	/**
	 * Inplace translation of an existing point to a world point
	 *   
	 * @param p the point to translate	 
	 */	
	public function translatePointToWorld(p:Point2D):void {
		var worldX:Number = ((_worldWidth * p.x) / _screenWidth) +
			_lowerLeft.x;
		
		var worldY:Number = _worldHeight + _lowerLeft.y - 
			((p.y * _worldHeight) / _screenHeight);

		// In place, we could call screenToWorld but avoid the new by doing
		// it this way
		p.x = worldX;
		p.y = worldY;
	}
	
	/**
	 * Convert a world point to a screen point
	 *  
	 * @param p The world point
	 * @return the screen point
	 */	
	public function worldToScreen(p:Point2D):Point {
		var screenX:uint = (_screenWidth / _worldWidth) * (p.x - _lowerLeft.x);
		var screenY:uint = _screenHeight - (_screenHeight / _worldHeight) *
			(p.y - _lowerLeft.y);
		
		return new Point(screenX, screenY);
	}
	
	/**
	 * Convert a world linear distance to a screen distance in the Y direction
	 *  
	 * @param d world distance
	 * @return screen distance	 
	 */	
	public function worldToScreenDistanceY(d:Number):uint {
		return (_screenHeight * d) / _worldHeight;
	}
	
	/**
	 * Convert a world linear distance to a screen distance in the X direction
	 *  
	 * @param d world distance
	 * @return screen distance
	 */	
	public function worldToScreenDistanceX(d:Number):uint {
		return (_screenWidth * d) / _worldWidth;
	}
	
	//--------------------------------------------------------------------------
	//
	// Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * The world's width
	 */	
	public function get worldWidth():Number {
		return _worldWidth;
	}
	
	/**
	 * @private
	 */
	public function set worldWidth(value:Number):void {
		_worldWidth = value;
	}
	
	/**
	 * The world's height
	 */
	public function get worldHeight():Number {
		return _worldHeight;
	}
	
	/**
	 * @private
	 */
	public function set worldHeight(value:Number):void {
		_worldHeight = value;
	}
	
	/**
	 * The screen's width
	 */
	public function get screenWidth():uint {
		return _screenWidth;
	}
	
	/**
	 * @private
	 */
	public function set screenWidth(value:uint):void {
		_screenWidth = value;
	}
	
	/**
	 * The screen's height
	 */
	public function get screenHeight():uint {
		return _screenHeight;
	}
	
	/**
	 * @private
	 */
	public function set screenHeight(value:uint):void {
		_screenHeight = value;
	}
	
	/**
	 * The lower left point of the world
	 */
	public function set lowerLeft(value:Point2D):void {
		lowerLeft = new Point2D(value.x, value.y);
	}
}
}