package app.components;

import lime.math.Vector2;

//Speichert nötige Daten für Autosimulation
class Vehicle {

	public var Speed: Float;	//Geschwindigkeit
	public var SteerAngle: Float;	//Winkel der Vorderräder
	public var AxisDistance: Float;	//Entfernung zwischen beiden Achsen

	public function new() {
		
		this.Speed = 0;
		this.SteerAngle = 15;
		this.AxisDistance = 130; //Konstante Variale anghängig vom Fahrzeug

	}

}