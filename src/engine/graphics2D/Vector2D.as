package engine.graphics2D
{
import errors.DivisionByZeroError;

/**
 * A vector is an XYPair with direction and magnitude
 *  
 * @author Brandon Heyer
 */
public class Vector2D extends XYPair
{	
	//--------------------------------------------------------------------------
	//
	// Variable Declartions
	//
	//--------------------------------------------------------------------------
	
	/**
	 * A zero'd vector 
	 */	
	public static const ZERO_VEC:Vector2D = new Vector2D(0,0);
		
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
	public function Vector2D(x:Number = 0, y:Number = 0) {
		super(x, y);
	}
	
	/**
	 * The angle from horizontal of the vector
	 *  
	 * @return the angle (in radians) from horizontal of the vector
	 */	
	public function angle():Number {
		if (magnitudeSq() < TOL * TOL &&
			magnitudeSq() > (-1.0 * TOL) * (-1.0 * TOL)) return 0.0;
		
		return Math.atan2(_y, _x);
	}
	
	/**
	 * Divide or scale down a vector by a value
	 *  
	 * @param d the value to scale by
	 * @return the scaled vector	 
	 */	
	public function divide(d:Number):Vector2D {
		if (d == 0) throw new DivisionByZeroError();
		
		return new Vector2D(x / d, y / d);
	}
	
	/**
	 * In place division / scaling of a vector
	 *  
	 * @param d the number to scale / divide by
	 */	
	public function divideEquals(d:Number):void {
		if (d == 0) throw new DivisionByZeroError();
		
		x /= d;
		y /= d;
	}
	
	/**
	 * Calculate the dot product of the vector and another vector
	 * 
	 * @param rhs the second vector
	 * @return the dot produt
	 */	
	public function dot(rhs:Vector2D):Number {
		return x * rhs.x + y * rhs.y;
	}
	
	/**
	 * Get the left orthogonal of the vector
	 *  
	 * @return the left orthogonal vector
	 */	
	public function getLeftOrtho():Vector2D {
		return new Vector2D(-1 * y, x);
	}
	
	/**
	 * Get the right orthogonal of the vector 
	 * 
	 * @return the right orthogonal vector
	 */	
	public function getRightOrtho():Vector2D {
		return new Vector2D(y, -1 * x);
	}
	
	/**
	 * Get a normalized version of the vector
	 *  
	 * @return the normalized vector 
	 */	
	public function getNormalized():Vector2D {
		if (magnitudeSq() < TOL * TOL &&
			magnitudeSq() > (-1.0 * TOL) * (-1.0 * TOL)) return this;
		
		if (equals(ZERO_VEC)) return this;
		
		return new Vector2D(x / magnitude(), y / magnitude());
	}
	
	/**
	 * Get the magnitude of the vector
	 *  
	 * @return The magnitued of the vector	 
	 */	
	public function magnitude():Number {
		return Math.sqrt(magnitudeSq());
	}
	
	/**
	 * Get the squared magnitued of the vector, use to avoid sqrt calls
	 * if you do not need the actual magnitude of the vector.
	 *  
	 * @return the squared magnitude of the vector	 
	 */	
	public function magnitudeSq():Number {
		return (_x * _x) + (_y * _y);
	}
	 
	/**
	 * Subrtract another vector from this one
	 *  
	 * @param rhs the other vector
	 * @return the difference vector 	 
	 */	
	public function minus(rhs:Vector2D):Vector2D {
		return new Vector2D(_x - rhs.x, y - rhs.y);
	}
	
	/**
	 * In place subtraction of another vector from this one
	 *  
	 * @param rhs the other vector 
	 */	
	public function minusEquals(rhs:Vector2D):void {
		_x -= rhs.x;
		_y -= rhs.y;
	}
	
	/**
	 * Inverse the vector
	 */	
	public function negate():void {
		x *= -1;
		y *= -1;
	}
	
	/**
	 * In place normalization of the vector
	 */	
	public function normalize():void {
		if (magnitudeSq() < TOL * TOL &&
			magnitudeSq() > (-1.0 * TOL) * (-1.0 * TOL)) return;
		
		if (equals(ZERO_VEC)) return;
		
		var xMag:Number = x / magnitude();
		var yMag:Number = y / magnitude();

		_x = xMag;
		_y = yMag;
	}
	
	/**
	 * Add a vector to this one
	 *  
	 * @param rhs the other vector
	 * @return the resulting sum vector 
	 */	
	public function plus(rhs:Vector2D):Vector2D {
		return new Vector2D(_x + rhs.x, _y + rhs.y);
	}
	
	/**
	 * In place addition of another vector
	 *  
	 * @param rhs the other vector
	 */	
	public function plusEquals(rhs:Vector2D):void {
		_x += rhs.x;
		_y += rhs.y;
	}
	
	/**
	 * Reflect the vector over the x axis
	 */	
	public function reflectX():void {
		_x *= -1;
	}
	
	/**
	 * Reflect the vector over the y axis
	 */	
	public function reflectY():void {
		_y *= -1;
	}
	
	/**
	 * Scale and add another vector to this one
	 *  
	 * @param scalar the scale factor of second vector
	 * @param v the second vector
	 * @return The sum of the scaled vector and this one 	 
	 */	
	public function scalePlus(scalar:Number, v:Vector2D):Vector2D {
		return new Vector2D(x + (v.x * scalar), y + (v.y * scalar));
	}
	
	/**
	 * In place scale and addition of another vector
	 *  
	 * @param scalar the scale factor of the second vector
	 * @param v the second vector
	 */	
	public function scalePlusEquals(scalar:Number, v:Vector2D):void {
		x += v.x * scalar;
		y += v.y * scalar;
	}
	
	/**
	 * Set this vector to its left ortho 	 
	 */	
	public function setLeftOrtho():void {
		var temp:Number = _x;
		_x = -1 * y;
		_y = temp;
	}
	
	/**
	 * Set this vector to its right ortho 	 
	 */	
	public function setRightOrth():void {
		var temp:Number = _x;
		
		_x = _y;
		_y = -1 * temp;
	}
	
	/**
	 * Multiply / scale this vector
	 *  
	 * @param d the scale factor
	 * @return the scaled / product vector
	 */	
	public function times(d:Number):Vector2D {
		return new Vector2D(_x * d, _y * d);		
	}
	
	/**
	 * In place multiplication / scaling of the vector
	 * 
	 * @param d the scale factor
	 */	
	public function timesEquals(d:Number):void {
		_x *= d;
		_y *= d;
	}
	
	/**
	 * Shorten a vector to a given magnitude
	 *  
	 * @param d the magnitude to shorten the vector to
	 */	
	public function truncate(d:Number):void {
		if (magnitudeSq() > d * d) {
			normalize();
			timesEquals(d);
		}
	}
	
	/**
	 * Set this vector to the one between two points\
	 *  
	 * @param p1 the first point
	 * @param p2 the second point
	 */	
	public function createFromPoints(p1:Point2D, p2:Point2D):void {
		_x = p1.x - p2.x;
		_y = p1.y - p2.y;
	}
	
	/**
	 * Rotate the vector off of the given angle
	 *  
	 * @param angle the angle in radians
	 */	
	public function rotate(angle:Number):void {
		var ca:Number = Math.cos(angle);
		var sa:Number = Math.sin(angle);
		
		var xt:Number = (_x * ca) - (_y * sa);
		var yt:Number = (_y * ca) - (_x * sa);
		
		x = xt;
		y = yt;
	}
}
}