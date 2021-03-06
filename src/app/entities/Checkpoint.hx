package app.entities;

import ash.core.Entity;
import openfl.Assets;
import openfl.display.BitmapData;

import app.components.Position;
import app.components.Display;
import app.math.Vector2;
import app.components.Collision;
import app.components.CheckpointComponent;
import app.entities.sprites.ImageSprite;


class Checkpoint extends Entity {

    public function new(position: Vector2, scale: Vector2, rotation: Float) {
        super();

        var bitmap: BitmapData = Assets.getBitmapData("assets/textures/checkpoint.png");
        var width = bitmap.width * scale.x,
            height = bitmap.height * scale.y;
            
        this.add( new Position(position, rotation) );
        this.add( new Display(new ImageSprite(width, height, bitmap)) );
        this.add( new Collision(width, height, false) );
        this.add( new CheckpointComponent() ); 


    }

}