//adds the library used to create the sliders
import controlP5.*;
ControlP5 cp5;

//creates a public variable used to store the size of the radius of which other boids within are considered neighbours
float radius = 60;
//creates a public variable used to store the size of the separation radius of which other boids within are considered neighbours to move away from
float sradius = 25;
//creates a public float value to store the strength of the separation algorhtm to be multiplied by 
float separation = 500;
//creates a public float value to store the strength of the cohesion algorhtm to be multiplied by
float cohesion = 0.002;
//creates a public float value to store the strength of the alignment algorhtm to be multiplied by
float alignment = 0.08;

//this defines the flock class and sets it's name as 'flock' which will be required when constructing an instance of it
Flock flock;
//this defines the species class and sets it's name as 'species' which will be required when constructing an instance of it
Species species;

//this initialises the setup procedure of the main class, which is used to set up and start the simulation
void setup(){
  //this creates the simulation area of a size specified for the boids to move around in
  size(1900,1000, P2D);
  //this creates a new instance of the species class, passing through the number of flocks there should be in that species
  species = new Species(3);
  //this sets the number of frames that should be executed and shown per second
  frameRate(100);
  
  //this creates a new instance of the ControlP5 module from a library that I am using
  cp5 = new ControlP5(this);
  
  //these lines of code create a slider for each of the public variables found above which affect boid behaviour, where I have set the size, location, range and a label for each of them
  cp5.addSlider("radius").setLabel("Radius Size").setPosition(10,10).setRange(0.01,200).setWidth(200).setHeight(20);
  cp5.addSlider("sradius").setLabel("Separation Radius Size").setPosition(10,40).setRange(0.01,150).setWidth(200).setHeight(20);
  cp5.addSlider("separation").setLabel("Separation Strength").setPosition(10,70).setRange(0,5000).setWidth(200).setHeight(20);
  cp5.addSlider("cohesion").setLabel("Cohesion Strength").setPosition(10,100).setRange(0,0.01).setWidth(200).setHeight(20);
  cp5.addSlider("alignment").setLabel("Alignment Strength").setPosition(10,130).setRange(0,2).setWidth(200).setHeight(20);

}

//initialises the draw function which contains code that is to be constanlty repeated
void draw(){
  //this colours the background black
  background(0);
  //this calls the update function in the species class, which is the top of the class dependencies
  species.update();
  //this calls the show function in the species class, which is the top of the class dependencies 
  species.show();
  fill(255);
  //displays the framerate on the corner of the screen to test performance
  text(frameRate, 20, 170);
}
