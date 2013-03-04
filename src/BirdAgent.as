package
{
import engine.game.SpriteAgent;
import engine.graphics2D.Point2D;
import engine.graphics2D.Vector2D;

import flash.display.BitmapData;
import flash.geom.Matrix;

/**
 * A bird agent is represented as a triangular cursor graphically.
 * It has constant speed and the cursor is updated to represnet the
 * agent's heading.
 *  
 * @author Brandon Heyer
 */
public class BirdAgent extends SpriteAgent
{
	//--------------------------------------------------------------------------
	//
	// Variable Declarations
	//
	//--------------------------------------------------------------------------
	
	private static const BIRD_COLOR:Number = 0x666666;
	
	/**
	 * @private
	 * The transformation matrix to use to rotate the image
	 * No point in creating this EVERY time we need it. 
	 */	
	private var m:Matrix = new Matrix();
	
	/**
	 * @private 
	 * Reset the matrix to the "new" state
	 */	
	private function resetMatrix():void {
		m.a = m.d = 1;
		m.b = m.c = m.tx = m.ty = 0;				
	}
	
	//--------------------------------------------------------------------------
	//
	// Public Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 * 
	 * <p>Creates a bird agent with a triangular pointer, speed of 5,
	 * radius of 5, and a normalized random heading.</p>
	 * 
	 * @param initialLoc The starting location of the bird agent
	 */	
	public function BirdAgent(initialLoc:Point2D) {		
		super();
		
		// Initialize the bird's main properties
		location.set(initialLoc);
		_speed = 5; //Math.random() * 15 + 5;
		_radius = 5;
		_heading = new Vector2D(Math.random() * 2 - 1, Math.random() * 2 - 1);
		_heading.normalize();
		
		// Create the graphical representation of the bird
		_sprite.graphics.lineStyle(1, BIRD_COLOR);
		_sprite.graphics.moveTo(3,4);
		_sprite.graphics.lineTo(6,9);
		_sprite.graphics.lineTo(3,14);
		_sprite.graphics.lineTo(16,9);
		_sprite.graphics.lineTo(3,3);
		
		_graphic = new BitmapData(18, 18);
	}
	
	//--------------------------------------------------------------------------
	//
	// Public Overrides from SpriteAgent and Agent
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Get the graphic for the bird, unlike a normal <code>SpriteAgent</code>
	 * the <code>BirdAgent</code> will more than likely ALWAYS be in a dirty
	 * state and need to have the graphic recreated.
	 *  
	 * @return The bitmap data for the bird agent
	 */	
	public override function get graphic():BitmapData {		
		resetMatrix();
		
		// Move the graphic so we can rotate it from it's center
		m.translate(-9, -9);			
		
		// Rotate according the the angle of the bird's heading
		m.rotate(_heading.angle());
		
		// Move the graphic back
		m.translate(9, 9);
		
		// Apply transformation to sprite
		_sprite.transform.matrix = m;	
		
		// Prefill the bitmap with transparency
		_graphic.fillRect(_graphic.rect, 0x00000000);			
				
		// Draw the sprite to the graphic
		_graphic.draw(_sprite, m, null, null, _graphic.rect, true);							
		
		return _graphic;
	}
	
	/**	 	 
	 * Update the bird agent by creating a velocty based off of the
	 * time since last update, heading, and speed
	 *  
	 * @inheritDoc
	 */	
	public override function update(delta:Number):void {			
		location.scalePlusEquals(_speed * delta, _heading);
	}
}
}