package engine.game
{
import flash.display.BitmapData;
import flash.display.Sprite;


/**
 * A sprite agent is an agent with a sprite based graphical display.
 * 
 * <p>This class should be handled as an abstract class as the major
 * functionalities from Agent are not implemented</p>
 * 
 * @author Brandon Heyer
 */
public class SpriteAgent extends Agent
{
	//--------------------------------------------------------------------------
	//
	// Protected Variable Declarations
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 * The sprite instance to use to draw the vector based graphic to 
	 */	
	protected var _sprite:Sprite = new Sprite();
	
	/**
	 * @private
	 * Dirty marker for whether or not the bitmap data needs to be updated
	 * from the sprite graphic 
	 */	
	protected var _dirty:Boolean = true;
	
	//--------------------------------------------------------------------------
	//
	// Public Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */	
	public function SpriteAgent() {
		super();			
	}
	
	//--------------------------------------------------------------------------
	//
	// Overrides from Agent
	//
	//--------------------------------------------------------------------------
	
	/**
	 * With a <code>SpriteAgent</code> if the graphic data is marked as dirty,
	 * the bitmap data will be recreated from the sprite instance.
	 *  
	 * @inheritDoc 
	 */	
	public override function get graphic():BitmapData {
		if (_dirty) {
			_graphic = new BitmapData(_sprite.width, _sprite.height);;
			_graphic.fillRect(_graphic.rect, 0x00000000);
			_graphic.draw(_sprite);
			
			_dirty = false;
		}
		
		return _graphic;
	}	
	
	//--------------------------------------------------------------------------
	//
	// Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * By accessing the sprite we have to assume that something is being
	 * done to it and this will cause the graphic to be invalidated / marked
	 * as dirty
	 *  
	 * @return the sprite instance
	 */	
	public function get sprite():Sprite {
		_dirty = true;
		
		return _sprite;
	}

	/**
	 * By setting hte sprite the graphic data will be invalidated / marked
	 * as dirty
	 *  
	 * @param value the sprite to use for this sprite agent	 
	 */	
	public function set sprite(value:Sprite):void {
		_dirty = true;
		_sprite = value;
	}
}
}