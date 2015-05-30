package app.entities;

import ash.core.Entity;

import app.components.Position;
import app.components.Display;
import app.components.Vehicle;
import app.components.Input;
import app.components.Camera;
import app.entities.sprites.VehicleSprite;


class Car extends Entity {

	public function new(x: Float, y: Float) {
		super();

		var vehicleComponent: Vehicle = new Vehicle();

		this.add( new Camera() );
		this.add( new Position(x, y) );
		this.add( new Input() );
		this.add( new Display(new VehicleSprite(vehicleComponent)) );
		this.add( vehicleComponent );


	}

}