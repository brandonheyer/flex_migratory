package engine.game
{
import engine.graphics2D.Point2D;
import engine.graphics2D.Vector2D;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.sampler.NewObjectSample;

import spark.primitives.Graphic;

/**
 * An agent is a game element with a location, destination, heading, speed
 * and visual representation.
 * 
 * <p>This class should be handled as an abstract class as the major
 * functionalities are not implemented</p>
 *  
 * @author Brandon Heyer
 */
public class Agent
{
	//--------------------------------------------------------------------------
	//
	// Protected Variable Declarations
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 * The current location of the agent  
	 */	
	protected var _location:Point2D = new Point2D();
	
	/**
	 * @private
	 * The destination of the agent 
	 */	
	protected var _destination:Point2D = new Point2D();
	
	/**
	 * @private
	 * The heading of the agent (vector direction & magnitude) 
	 */	
	protected var _heading:Vector2D = new Vector2D;
	
	/**
	 * @private
	 * The speed of the agent 
	 */	
	protected var _speed:Number;
	
	/**
	 * @private
	 * The visual representation of the agent 
	 */	
	protected var _graphic:BitmapData;
	
	/**
	 * @private
	 * Whether or not a collision has occured 
	 */	
	protected var _collision:Boolean;
	
	/**
	 * @private
	 * The radius of the agent 
	 */	
	protected var _radius:Number;
	
	//--------------------------------------------------------------------------
	//
	// Abstract Public Methods
	//
	//--------------------------------------------------------------------------
	
	public function Agent() { /* Abstract */ }
	
	/**
	 * Update the agent as necessary. This function is considered abstract
	 * and should be overridden in child classes.
	 *  
	 * @param delta time since last update	 
	 */	
	public function update(delta:Number):void { /* Abstract */ }
	
	//--------------------------------------------------------------------------
	//
	// Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * The location for the agent 	 	 
	 */	
	public function get location():Point2D {
		return _location;
	}
	
	/**
	 * @private
	 */	
	public function set location(value:Point2D):void {
		_location.set(value);
	}

	/**
	 * The destination point for the agent 	 
	 */	
	public function get destination():Point2D {
		return _destination;
	}
	
	/**
	 * @private
	 */	
	public function set destination(value:Point2D):void {
		_destination.set(value);
	}

	/**
	 * The graphic for the agent
	 */
	public function get graphic():BitmapData {		
		return _graphic;
	}

	/**
	 * @private
	 */
	public function set graphic(value:BitmapData):void {
		_graphic = value;
	}

	/**
	 * The collision status of the agent
	 */	
	public function get collision():Boolean {
		return _collision;
	}

	/**
	 * @private
	 */
	public function set collision(value:Boolean):void {
		_collision = value;
	}

	/**
	 * The radius for the agent
	 */	
	public function get radius():Number {
		return _radius;
	}

	/**
	 * @private
	 */	
	public function set radius(value:Number):void {	
		_radius = value;
	}
	
	/**
	 * The heading for the agent.
	 * <p><b>Note:</b> Setting this will make the destination of the agent
	 * inaccurate and if you are relying on destination in your update cycle
	 * you may not want to directly set heading.</p>
	 */	
	public function get heading():Vector2D {
		return _heading;
	}
	
	/**
	 * @private
	 */
	public function set heading(value:Vector2D):void {
		_heading.set(value);
	}
	
	/**
	 * The speed of the agent
	 */
	public function get speed():Number {
		return _speed;
	}
	
	/**
	 * @private
	 */
	public function set speed(value:Number):void {
		_speed = value;	
	}
}
}