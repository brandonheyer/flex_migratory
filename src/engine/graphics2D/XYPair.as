package engine.graphics2D
{

/**
 * An XYPair is the base class for Points and Vectors and provides
 * the basic functionallity common to both (such as properties and equals)
 *  
 * @author Brandon Heyer
 */
public class XYPair
{
	//--------------------------------------------------------------------------
	//
	// Variable Declarations
	//
	//--------------------------------------------------------------------------
	
	/**
	 * The equivalence tollerance to account for floating point differences 
	 */	
	public static const TOL:Number = 0.000001;
	
	/**
	 * @private
	 * The x value of the pair 
	 */	
	protected var _x:Number;
	
	/**
	 * @private
	 * The y value of the pair 
	 */	
	protected var _y:Number;
	
	//--------------------------------------------------------------------------
	//
	// Public Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 *  
	 * @param x the x value
	 * @param y the y value
	 */	
	public function XYPair(x:Number, y:Number) {
		_x = x;
		_y = y;
	}
	
	/**
	 * Check to see if this and another pair are equal given 
	 * a certain tollerance
	 *  
	 * @param p The point to check against
	 * @param tolerance the tolerance to use, defaults to <code>TOL</code>
	 * @return the equality of the two sets
	 */	
	public function equals(p:XYPair, tolerance:Number = TOL):Boolean {
		var dx:Number = Math.abs(_x - p.x);
		var dy:Number = Math.abs(_y - p.y);
		
		return dx < tolerance && dy < tolerance;	
	}
	
	/**
	 * Set the x and y values based off of another pair
	 *  
	 * @param p The pair to set the values from
	 */	
	public function set(p:XYPair):void {
		_x = p.x;
		_y = p.y;
	}
	
	/**
	 * Convert the pair to a coordinate string
	 *  
	 * @return the coordinate string
	 */	
	public function toString():String {
		return "(" + _x + ", " + _y + ")";
	}	
	
	//--------------------------------------------------------------------------
	//
	// Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * The x value
	 */
	public function get x():Number {
		return _x;
	}
	
	/**
	 * @private
	 */
	public function set x(value:Number):void {
		_x = value;
	}
	
	/**
	 * The y value
	 */
	public function get y():Number {
		return _y;
	}
	
	/**
	 * @private
	 */
	public function set y(value:Number):void {
		_y = value;
	}	
}
}