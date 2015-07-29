package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;
import ash.signals.Signal1;

import app.systems.SystemEvents;
import app.math.CollisionResponse;

class GameSystem extends System {


    private var events: SystemEvents;

    public function new(events: SystemEvents) {
		super();

        this.events = events;
        events.ENTITY_COLLIDED.add(onEntityCollided);

	}


	public override function update(elapsed: Float) : Void {


	}



	private function onEntityCollided(entity1: Entity, entity2: Entity, collisionResponse: CollisionResponse) : Void {

		if (Type.getClass(entity1) == app.entities.Car && Type.getClass(entity2) == app.entities.Finish) {
			trace("load level");
		}

	}

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {

    	//Erstes Level laden
        events.LOAD_LEVEL.dispatch(0);
        
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {

    }


}