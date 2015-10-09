package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import app.math.Vector2;
import app.math.CollisionResponse;

import app.nodes.VehicleNode;
import app.components.Vehicle;
import app.components.Position;

class VehicleSystem extends System {

	private var vehicleNodes: NodeList<VehicleNode>;

    private var events: SystemEvents;

    //Naturkonstanten
    private static inline var ROLLING_RESISTANCE: Float = 12.8; //8
    private static inline var AIR_RESISTANCE: Float = 0.4257;    //2

    public function new(events: SystemEvents) {
        super();

        this.events = events;
    }

	public override function update(elapsed: Float) : Void {

        for (vehicleNode in vehicleNodes) {

            var vehicle: Vehicle = vehicleNode.vehicle,
                position: Position = vehicleNode.position;

            var tractionForce: Float = (vehicle.throttle ? vehicle.ENGINE_FORCE: 0) - (vehicle.brake && vehicle.velocity > 0 ? vehicle.BRAKE_FORCE: 0) - (vehicle.brake && vehicle.velocity < 0 ? vehicle.REVERSE_FORCE: 0);

            var dragForce: Float = -AIR_RESISTANCE * vehicle.velocity * vehicle.velocity, //C * v * |v|
                rollingForce: Float = -ROLLING_RESISTANCE * vehicle.velocity,
                longForce: Float = tractionForce + dragForce + rollingForce,
                acceleration: Float = longForce / vehicle.MASS;

            vehicle.velocity += elapsed * acceleration;



            var pixelVelocity: Float = vehicle.velocity * 200/5;

            //Aktuelle Positionen von Front- und Rückrad berechnen
            var frontWheel: Vector2 = position.vector + Vector2.fromPolar(position.rotation, vehicle.axisDistance/2);
            var backWheel: Vector2 = position.vector  + Vector2.fromPolar(position.rotation + 180, vehicle.axisDistance/2);

            //Front- und Rückrad bewegen
            frontWheel += Vector2.fromPolar(position.rotation + vehicle.steerAngle, pixelVelocity * elapsed);
            backWheel += Vector2.fromPolar(position.rotation, pixelVelocity * elapsed);

            //Neue Rotation des Autos ermitteln
            var rotation: Float = backWheel.angleTo(frontWheel);

            //trace(((frontWheel + backWheel) / 2) - position.vector );
            //Die neue Position des Autos ergibt sich aus Mittelpunkt zwischen Vorder- und Hinterrad
            var movement: Vector2 = (((frontWheel + backWheel) / 2) - position.vector );


            //Event an das CollisionSystem weitergeben, dass zurückgibt, ob das Auto fahren darf
            events.CAN_ENTITY_MOVE.dispatch(vehicleNode.entity, movement, function (response: CollisionResponse) {

                //Wenn Auto nicht kollidiert oder mit einem nicht soliden Objekt kollidiert, kann es auf die neue Position versetzt werden
                if (response.collision == false || response.solid == false) {
                    position.rotation = rotation;
                    position.vector += movement;
                }

            });


        }   


	}


	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(engine: Engine):Void {
        vehicleNodes = engine.getNodeList(VehicleNode);
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        vehicleNodes = null;
    }


}