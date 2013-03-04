package
{
import engine.game.Agent;
import engine.graphics2D.CoordinateTranslator;
import engine.graphics2D.Game;
import engine.graphics2D.Point2D;
import engine.graphics2D.Vector2D;

import errors.SingletonError;

import flash.display.BitmapData;
import flash.geom.Point;

import mx.collections.ArrayList;

/**
 * This game is a flocking simulator for "birds". Any agent with base
 * <code>Agent</code> class can be used but specifically the initial
 * implementation of this game was created with the usage of
 * <code>BirdAgent</code> in mind.
 * 
 * <p>The implementation of <code>BirdsGame</code> is a singleton</p>
 *  
 * @author Brandon Heyer 
 */
public class BirdsGame implements Game
{
	//--------------------------------------------------------------------------
	//
	// Variable Declarations
	//
	//--------------------------------------------------------------------------
	
	//--------------------------------------
	//  Public Constants
	//--------------------------------------
	
	/**
	 * The starting number of birds 
	 */	
	public static const STARTING_BIRDS:Number = 25;
	
	/**
	 * The total number of birds allowed
	 */
	public static const MAX_BIRDS:Number = 50;
	
	/**
	 * The starting alignment weight
	 */
	public static const STARTING_ALIGNMENT:Number = 25;
	
	/**
	 * The starting cohesion weight
	 */
	public static const STARTING_COHESION:Number = 25;
	
	/**
	 * The starting separation weight 
	 */	
	public static const STARTING_SEPARATION:Number = 25;
	
	/**
	 * The minimum starting speed 
	 */	
	public static const STARTING_MIN_SPEED:Number = 10;
	
	/**
	 * The maximum starting speed
	 */
	public static const STARTING_MAX_SPEED:Number = 10;
	
	/**
	 * The starting effect radius 
	 */	
	public static const STARTING_RADIUS:Number = 25;
	
	//--------------------------------------
	//  Private constants
	//--------------------------------------
	
	/**
	 * @private
	 * The width of the world, in world distance, not pixels
	 */
	private static const WORLD_WIDTH:Number = 80;
	
	/**
	 * @private
	 * The height of the world, in world distance, not pixels
	 */
	private static const WORLD_HEIGHT:Number = 60;
	
	/**
	 * @private
	 * The singleton instance for the game 
	 */	
	private static const _instance:BirdsGame = 
		new BirdsGame(Migratory.SCREEN_WIDTH, Migratory.SCREEN_HEIGHT);		
	
	//--------------------------------------
	//  Temporary placeholder variables
	//  to speed up update cylce
	//--------------------------------------	
	private var aj:Agent;
	private var ai:Agent;		
	private var tempMagnitude:Number = 0;
	private var tempVector:Vector2D = new Vector2D(0, 0);
	private var tempPoint:Point2D = new Point2D(0, 0);	
	private var alignmentVector:Vector2D = new Vector2D(0, 0);
	private var cohesionVector:Vector2D = new Vector2D(0, 0);
	private var separationVector:Vector2D = new Vector2D(0, 0);	
	
	/**
	 * @private 
	 * Used to store the alignment vectors for each update cycle 
	 */	
	private var alignmentVectorList:Array = new Array(MAX_BIRDS);
	
	/**
	 * @private
	 * Used to store the cohesion vectors for each update cycle 
	 */	
	private var cohesionVectorList:Array = new Array(MAX_BIRDS);
	
	/**
	 * @private
	 * Used to store the separation vectors for each update cycle 
	 */	
	private var separationVectorList:Array = new Array(MAX_BIRDS);
	
	/**
	 * @private
	 * Used to store birds that are within the effect radius
	 */	
	private var closeAgents:Array = new Array(MAX_BIRDS);
	
	/**
	 * @private
	 * Marker for actual array size of closeAgents 
	 */	
	private var closeAgentCount:Number = 0;
	
	/**
	 * @private
	 * The current birds displayed, essential treated as a FIFO queue
	 * for adding and removal 
	 */	
	private var agents:ArrayList = new ArrayList();
	
	/**
	 * @private
	 * The coordinate translator for world to pixel translation 
	 */	
	private var ct:CoordinateTranslator;
	
	//--------------------------------------
	//  Property variables
	//--------------------------------------
	private var _alignment:Number = STARTING_ALIGNMENT;
	private var _cohesion:Number = STARTING_COHESION;
	private var _separation:Number = STARTING_SEPARATION;
	private var _maxSpeed:Number = STARTING_MAX_SPEED;
	private var _minSpeed:Number = STARTING_MIN_SPEED;		
	private var currentRadius:Number = STARTING_RADIUS;		
	
	/**
	 * @private
	 * Get a random speed based on _minSpeed and _maxSpeed
	 *  
	 * @return The random speed	 
	 */	
	private function randomSpeed():Number {
		return Math.random() * Math.max(1, _maxSpeed - _minSpeed) + _minSpeed;
	}
	
	/**
	 * @private
	 * Update the radii of all agents being managed by this game instance
	 *  
	 * @param value	the radius to set
	 */	
	private function updateRadii(value:Number):void {
		for (var i:uint = 0; i < agents.length; i++) {
			(agents.getItemAt(i) as Agent).radius = value;	
			
			// Store the radius so we don't have to reference a 
			// agent to get to it
			currentRadius = value;
		}
	}
	
	/**
	 * @private
	 * Update the speeds of all agnets being managed by this game instance.
	 * Speeds are based off of a random value between _minSpeed and _maxSpeed.	 
	 */	
	private function updateSpeeds():void {
		for (var i:uint = 0; i < agents.length; i++)
			(agents.getItemAt(i) as Agent).speed = randomSpeed();
	}
	
	/**
	 * @private
	 * 
	 * Add a bird into the game with a random location, speed and the
	 * current effect radius
	 */	
	private function addBird():void {
		ai = new BirdAgent(new Point2D(Math.random() * WORLD_HEIGHT, 			
									   Math.random() * WORLD_WIDTH));
		
		ai.speed = randomSpeed();		
		ai.radius = currentRadius;		
		agents.addItem(ai);
	}
	
	/**
	 * Constructor.
	 * 
	 * <p>Create THE instance of the game based on the provided
	 * screen width and height.</p>
	 *  
	 * @param screenWidth The screen's width
	 * @param screenHeight The screen's height
	 */	
	public function BirdsGame(screenWidth:uint, screenHeight:uint) {
		// Only allow one instance
		if (_instance != null) throw new SingletonError();
		
		// Set up the coordinate translator
		ct = new CoordinateTranslator(screenWidth, screenHeight, 
			WORLD_WIDTH, WORLD_HEIGHT, Point2D.ZERO_POINT);					
		
		// Initialize the vector storage for access / setting later,
		// Memory use vs. improvement in the update cycle
		for (var i:uint = 0; i < MAX_BIRDS; i++) {
			alignmentVectorList[i] = new Vector2D(0, 0);
			cohesionVectorList[i] = new Vector2D(0, 0);
			separationVectorList[i] = new Vector2D(0, 0);
		}		
		
		// Add all the birds
		for (i = 0; i < STARTING_BIRDS; i++) addBird();
	}
	
	/**
	 * Update all agents managed by this game. The major calculations for
	 * alignment / cohesion / separation occur in this cycle.
	 *  
	 * @param delta time since last update	 
	 */	
	public function update(delta:Number):void {				
		for (var i:uint = 0; i < agents.length; i++) {
			// Base agent
			ai = agents.getItemAt(i) as Agent;
				
			// Gather up current vector storage and reset, much faster
			// than creating these vectors on the fly each time
			alignmentVector = alignmentVectorList[i];
			alignmentVector.x = 0;
			alignmentVector.y = 0;
			
			cohesionVector = cohesionVectorList[i];
			cohesionVector.x = 0;
			cohesionVector.y = 0;
			
			separationVector = separationVectorList[i];
			separationVector.x = 0;
			separationVector.y = 0;
			
			// Find near by birds
			for (var j:uint = 0; j < agents.length; j++) {
				// Ignore the same bird
				if (i == j) continue;
				
				// Possible Matching Agent
				aj = agents.getItemAt(j) as Agent;
				
				// No new call by doing subtraction outside of Point2D
				tempVector.x = aj.location.x - ai.location.x;
				tempVector.y = aj.location.y - ai.location.y;
				
				// If the distance between agents (squared) is within
				// the effect radius of the agent (squared) we have a math
				if (tempVector.magnitudeSq() <= ai.radius * ai.radius) {				
					closeAgents[closeAgentCount] = aj;				
					closeAgentCount++;
				}
			} 
			
			// Perform vector math for A/C/S
			for (j = 0; j < closeAgentCount; j++) {				
				// Matching Agent
				aj = closeAgents[j] as Agent;
				
				// Alignment
				tempVector.set(aj.heading);
				tempVector.timesEquals(aj.speed);
				alignmentVector.plusEquals(tempVector);
				
				// Cohesion
				tempVector.x = aj.location.x;
				tempVector.y = aj.location.y;				
				cohesionVector.plusEquals(tempVector);

				// Separation	
				tempVector.x = ai.location.x - aj.location.x;
				tempVector.y = ai.location.y - aj.location.y;
				
				// 0 * 0 = 0 so squaring is irrelevant 
				tempMagnitude = tempVector.magnitudeSq();	
				
				if (tempMagnitude != 0) 
					separationVector.scalePlusEquals(1 / tempMagnitude, tempVector);															
			}
									
			// No effects if no birds are near by
			if (closeAgentCount == 0) {
				alignmentVector.x = 0;
				alignmentVector.y = 0;
				
				cohesionVector.x = 0;
				cohesionVector.y = 0;
				
				separationVector.x = 0;
				separationVector.y = 0;
			} 
			// Perform any wrap up finalization for alignment and cohesion
			else {								
				alignmentVector.divideEquals(closeAgentCount);											
				cohesionVector.divideEquals(closeAgentCount);

				cohesionVector.x -= ai.location.x;
				cohesionVector.y -= ai.location.y;															
			}			
			
			closeAgentCount = 0;
		}
		
		// Apply a/c/s to all agents, do this in another step so the effect
		// is not compounded as we iterate through the first time
		for (var k:uint = 0; k < agents.length; k++) {						
			alignmentVector = alignmentVectorList[k];
			cohesionVector = cohesionVectorList[k];
			separationVector = separationVectorList[k];
						
			// Normalize the effects to make things a bit more even
			// It may be possible to avoid the sqrt's in normalize()
			// by introducing a "fudge factor" when scaling, but I was  
			// unable to find a satisfactory one that gave similar results
			alignmentVector.normalize();
			cohesionVector.normalize();
			separationVector.normalize();
			
			// Get current agent
			ai = agents.getItemAt(k) as Agent;
			
			// Scale the effects according to property values
			alignmentVector.divideEquals(_alignment);
			cohesionVector.divideEquals(_cohesion);
			separationVector.divideEquals(_separation);
			
			// Add all effects to the heading
			ai.heading.plusEquals(alignmentVector);
			ai.heading.plusEquals(cohesionVector);
			ai.heading.plusEquals(separationVector);
			
			// Normalize the heading to smooth things out
			ai.heading.normalize();						
			
			// Trickle the update call to the agent
			ai.update(delta);
			
			// Wrap the agent position and reset it to an actual value
			// The world could be treated as infinte, but this can
			// cause confusion when an agent has left the screen multiple times
			// and is thus further away from an agent "visually" next to it
			// ...Oh torus worlds...
			var tempX:Number = ai.location.x;
			var tempY:Number = ai.location.y;
			
			if (tempX < 0) tempX += WORLD_WIDTH;
			if (tempY < 0) tempY += WORLD_HEIGHT;
			
			ai.location.x = tempX % WORLD_WIDTH;
			ai.location.y = tempY % WORLD_HEIGHT;
		}
	}
	
	/**
	 * @inheritDoc	 
	 */	
	public function draw(canvas:BitmapData):void { 
		for (var i:uint = 0; i < agents.length; i++) {
			ai = agents.getItemAt(i) as Agent;
			
			canvas.copyPixels(ai.graphic, ai.graphic.rect,
				new Point(ct.worldToScreenDistanceX(ai.location.x % WORLD_WIDTH),
					ct.worldToScreenDistanceY(ai.location.y % WORLD_HEIGHT)));								
		}			
	}
	
	/**
	 * Get the singleton isntance for this game
	 *  
	 * @return the singleton instance for this game
	 */	
	public static function get instance():BirdsGame { return _instance; }

	/**
	 * Set the alignment scale factor 
	 * @param value the scale factor for alignment	 
	 */	
	public function set alignment(value:Number):void {
		_alignment = value;
	}
	
	/**
	 * Set the cohesion scale factor 
	 * @param value the scale factor for cohesion	 
	 */	
	public function set cohesion(value:Number):void {
		_cohesion = value;
	}
	
	/**
	 * Set the separation scale factor 
	 * @param value the scale factor for separation	 
	 */	
	public function set separation(value:Number):void {
		_separation = value;
	}
	
	/**
	 * Set then number of birds 
	 * @param value the number of birds
	 */	
	public function set birdCount(value:Number):void {
		// Remove birds to get to required count
		while (agents.length > value) agents.removeItemAt(0);
		
		// Or add them
		while (agents.length < value) addBird();
	}
	
	/**
	 * Set the minumum random speed for the birds 
	 * @param value the minimum random speed	 
	 */	
	public function set minSpeed(value:Number):void {
		_minSpeed = value;
		
		// Recalculate all birds speeds
		updateSpeeds();
	}
	
	/**
	 * Set the maximum random speed for the birds 
	 * @param value the maximum random speed	 
	 */	
	public function set maxSpeed(value:Number):void {
		_maxSpeed = value;
		
		// Recalculate all birds speeds
		updateSpeeds();		
	}
	
	/**
	 * Set the effect radius for the birds
	 * @param value the effect radius for the birds
	 */
	public function set radius(value:Number): void {
		updateRadii(value);		
	}
}
}