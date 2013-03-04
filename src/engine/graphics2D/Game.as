package engine.graphics2D
{
import flash.display.BitmapData;

/**
 * A game provides for the abilitiy to update based on time between
 * the last update, and to draw to a provided canvase
 *  
 * @author Brandon Heyer
 */
public interface Game
{
	/**
	 * Update any moving elements
	 *  
	 * @param delta the length of time (in seconds) that have passed 
	 * since the last update
	 */		
	function update(delta:Number):void;
	
	/**
	 * Draw elements to the canvas 
	 * 
	 * @param canvas the canvas to draw to
	 */	
	function draw(canvas:BitmapData):void;	
}
}