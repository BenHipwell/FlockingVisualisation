//creates a boid class used for each instance of a boid on screen
class Boid {

  //creates a private vector variable to store the location of the boid
  private PVector location;
  //creates a private vector variable to store the velocity of the boid
  private PVector velocity;
  //creates a private float value to store the maximum velocity of the boid
  private float maxVelocity = 2.5;
  //creates a private colour variable to store the colour of the boid
  private color colour;
  //creates a private boolean variable to determine whether the boid should be highlighted or not
  private boolean fill = false;
  //creates a private vector variable to store the velocity vector in which the separation algorithm is taking the boid which is used for the visualisations
  private PVector sHeading;
  //creates a private vector variable to store the velocity vector in which the cohesion algorithm is taking the boid which is used for the visualisations
  private PVector cHeading;
  //creates a private vector variable to store the velocity vector in which the alignment algorithm is taking the boid which is used for the visualisations
  private PVector aHeading;
  
  //constructor class which I have used to set a starting condition to the boid
  Boid()
  {
    //sets the random starting location of the boid
    location = new PVector(random(width),random(height));
    //sets the random starting velocity of the boid
    velocity = new PVector(random(-2,2), random(-2,2));
  }
  
  //initialises the wrap-around class so boids reappear on screen 
  void WrapAround(){
    
    if (location.y > height){
      location.y = 0;
      location.x = width-location.x;
    }
    
    if (location.y < 0){
      location.y = height;
      location.x = width-location.x;
    }
    
    if (location.x > width){
      location.x = 0;
      location.y = height-location.y;
    }
    
    if (location.x < 0){
      location.x = width;
      location.y = height-location.y;
    }
    
  }
  
  //initialises the update function of the Boid class, which contains code that I wish to be executed every frame
  public void update()
  {
    velocity.limit(maxVelocity);
    WrapAround();
    location.add(velocity);
  }
  
  //initialises the steer function which is used as part of the cohesion algorithm
  void steer(PVector desired) {
    //this finds the vector difference between the average position of the neighbours and the location of the boid to find the direction the boid should be moving from where it is
    desired.sub(location);
    //this sets the cohesion heading vector to this desired vector that cohesion is taking the boid in so that the visualisations can be displayed
    cHeading = desired;
    //this then adds a specified amount of this desired vector heading to the velocity depending on the value of the cohesion multiplier
    velocity.add(desired.mult(maxVelocity*(cohesion)));
  }
  
  //initialises the present class which is used to draw all of the visualisations
  void present(){
    //increases the thickness of the lines drawn
    strokeWeight(1.5);
    //pushes the current transformation matrix onto a stack so a new translation and rotation can be used for drawing the boid and only that
    pushMatrix();
    //translates the origin to the coordinates of the boid so I am able to rotate it based on it's heading
    translate(location.x,location.y);
    //this rotates the transformation matrix to the direction the boid is moving in
    rotate(velocity.heading()+(PI/2));
    //this draws the triangle relative the prior translation and rotation, using increased values so this visualisation boid is larger than the rest to stand out
    triangle(-5,10,0,-10,5,10);
    //this pops the original transformation matrix off of the stack to revert the rotation and translation so it doesn't affect the rest of the program
    popMatrix();  
    
    noFill();
    fill(255,94,62,70);
    circle(location.x, location.y, sradius*2);
    fill(192,255,100,70);
    circle(location.x, location.y, radius*2);
    
    //these three lines create float values used to store the multiplier to increase the length of the line visualisation by, based on the length of the heading vectors
    float aMult = sqrt(sq(aHeading.x)+sq(aHeading.y));
    float sMult = sqrt(sq(sHeading.x)+sq(sHeading.y));
    float cMult = sqrt(sq(cHeading.x)+sq(cHeading.y));
    
    pushMatrix();
    translate(location.x,location.y);
    stroke(0);
    //this rotates the transformation matrix in order to point the line in the direction that the alignment algorithm is taking it in
    rotate(aHeading.heading()-(PI/2));
    //this draws the line with it's length determined by the impact of the alignment algorithm
    line(0,0,0, 500*aMult);
    popMatrix();
    
    pushMatrix();
    translate(location.x,location.y);
    stroke(255,0,0);
    //this rotates the transformation matrix in order to point the line in the direction that the separation algorithm is taking it in
    rotate(sHeading.heading()-(PI/2));
    //this draws the line with it's length determined by the impact of the separation algorithm
    line(0,0,0, 500*sMult);
    popMatrix();
    
    pushMatrix();
    translate(location.x,location.y);
    stroke(255,255,255);
    //this rotates the transformation matrix in order to point the line in the direction that the cohesion algorithm is taking it in
    rotate(cHeading.heading()-(PI/2));
    //this draws the line with it's length determined by the impact of the cohesion algorithm
    line(0,0,0, 500*cMult);
    popMatrix();  
    
    //reverts the thickness of lines drawn so only the boids and visualisations drawn using the present class have thicker outlines
    strokeWeight(1);
  }
  
  //initialises the show class which is used to draw the boid onto the screen
  void show()
  {
    noFill();
    
    if (fill){
      fill(colour);
    }
    
    //pushes the current transformation matrix onto a stack so a new translation and rotation can be used for drawing the boid and only that
    pushMatrix();
    //translates the origin to the coordinates of the boid so I am able to rotate it based on it's heading
    translate(location.x,location.y);
    //this rotates the transformation matrix to the direction the boid is moving in
    rotate(velocity.heading()+(PI/2));
    //this draws the triangle relative the prior translation and rotation
    triangle(-3,7,0,-7,3,7);
    //this pops the original transformation matrix off of the stack to revert the rotation and translation so it doesn't affect the rest of the program
    popMatrix();  
    
    fill = false;
  }
} 
