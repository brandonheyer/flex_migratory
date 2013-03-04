package engine.graphics2D
{
/**
 * A Point2D is a two dimensional cartesian point
 *  
 * @author Brandon Heyer
 */
public class Point2D extends XYPair
{	
	//--------------------------------------------------------------------------
	//
	// Variable Declarations
	//
	//--------------------------------------------------------------------------
	
	/**
	 * An actual zero'd point 
	 */	
	public static const ZERO_POINT:Point2D = new Point2D(0, 0);
	
	//--------------------------------------------------------------------------
	//
	// Public Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor 
	 * 
	 * @param x the x value, defaults to zero
	 * @param y the y value, defaults to zero
	 */	
	public function Point2D(x:Number = 0, y:Number = 0) {
		super(x, y);
	}
	
	/**
	 * Subtraction of two points, results in a vector between the two points 
	 * 
	 * @param rhs the point to subtract from
	 * @return a vecrtor between the two points
	 */	
	public function minus(rhs:Point2D):Vector2D {
		return new Vector2D(_x - rhs.x, _y - rhs.y);
	}
	
	/**
	 * Addition of a point and a vector results in a point moved by
	 * the direction & magnitude of the vector
	 *  
	 * @param rhs The vector to move the point by	 
	 * @return The point at a new location	 
	 */	
	public function plus(rhs:Vector2D):Point2D {
		return new Point2D(_x + rhs.x, _y + rhs.y);
	}
	
	/**
	 * In-place addition of a vector
	 *  
	 * @param rhs The vector to move the point by	 
	 */	
	public function plusEquals(rhs:Vector2D):void {
		_x += rhs.x;
		_y += rhs.y;
	}
	
	/**
	 * Scale a vector and then add a vector to the point
	 *  
	 * @param scalar the scale factor for the vector
	 * @param v the vector
	 * @return the moved point
	 */	
	public function scalePlus(scalar:Number, v:Vector2D):Point2D {
		return new Point2D(_x + (v.x * scalar), _y + (v.y * scalar));
	}
	
	/**
	 * In-place scaling and addition of a vector 
	 * 
	 * @param scalar the scale factor for the vector
	 * @param v the vector	 
	 */	
	public function scalePlusEquals(scalar:Number, v:Vector2D):void {
		_x += v.x * scalar;
		_y += v.y * scalar;
	}		
}
}