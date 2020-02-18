//creates a flock class which is used to make instances of flocks of lots of boids
class Flock {
  //creates an array of boid objects
  ArrayList<Boid> boids = new ArrayList<Boid>();
  //creates a private integer which is used to store the size of the flock to create, which is passed through from the contructor
  private int size;
  //creates a private colour variable which is used to store the colour of the boids in the flock, which is passed through into the contructor
  private color colour;
  
  //initialises the constructor procedure, in which the size and colour of the flock is passed into
  Flock(int size, color colour)
  {
    this.size = size;
    this.colour = colour;
    GenBoids();
  }
  
  //initialises the procedure to generate the boids in the flock
  void GenBoids()
  {
    //this starts a for loop which adds a new boid to the object array based on the size of the flock determined as stored from constructor
    for (int i = 0; i < size; i++)
      //adds a new boid instance into the array
      boids.add(new Boid());
    
  }
  
  //initialises the separation algorithm
  void separation(){
  
    //this starts a new for loop to cycle through every boid in the flock
    for (int a = 0; a < size; a++){
      PVector averageP = new PVector();
      float count = 0;
      //this starts another loop to create a nested for loop to check for neighbours, for every boid
      for (int b = 0; b < size; b++){
          //this calculates the distance between the boid and the one being checked against
          float distance = boids.get(a).location.dist(boids.get(b).location);
          //this checks whether the boid is within the range of the radius to be considered a neighbour
          if (distance < sradius){
            
            //this highlights the boid red if it is within the separation radius of the boid that is being visualised 
            if (a==0){
              boids.get(b).fill = true;
              boids.get(b).colour = color(255,0,0);
            }
          
             //these copies of the two locations are created so that the two coordinates can be used for calculations without affecting the actual value of the location
             PVector locationA = boids.get(a).location.copy();
             PVector locationB = boids.get(b).location.copy();
             locationA.sub(locationB);
             //this takes the distance between the boids and adds an inversely proportional of this to the averageP value
             locationA.normalize().mult(1.0/locationB.dist(locationA));
             averageP.add(locationA);
             count++;
          }
      }
            //this then finds the average velocity that should be added to move away from the boids in the separation radius, where ones closer have a larger affect on this value
            averageP.div(count);
            //this sets the boid's separation heading value to the desired velocity to move away from the boids, which will be later used to visualise this separation algorithm
            boids.get(a).sHeading = averageP;
            //this adds a small proportion of this average to the velocity of the boid, depending on the value of the public separation variable
            boids.get(a).velocity.add(averageP.mult(separation));
    }
  }
  
  //initialises the cohesion algorithm
  void cohesion(){
    
    //this starts a new for loop to cycle through every boid in the flock
    for (int a = 0; a < size; a++){
      int count = 0;
      PVector Total = new PVector();
      for (int b = 0; b < size; b++){
          //this starts another loop to create a nested for loop to check for neighbours, for every boid
          float distance = boids.get(a).location.dist(boids.get(b).location);
          //this checks whether the boid is within the range of the radius to be considered a neighbour
          if (distance < radius){
            
            //this highlights the boid green if it is within the radius of the boid that is being visualised
            if (a==0){
              boids.get(b).fill = true;
              boids.get(b).colour = color(0,255,0);
            }
            
            //this adds up the locations of the boids within the neighbour radius
            Total.add(boids.get(b).location);
            count++;
          }
        }       
        
        //this then finds the average position of the boids within the neighbour radius 
        Total.div(count);
        //the steer function within the boid class it then called, passing through the value of the average position of the neighbours 
        boids.get(a).steer(Total);
    }
  }
  
  //initialises the alignment algorithm
  void alignment() {
     
     //this starts a new for loop to cycle through every boid in the flock
     for (int a = 0; a < size; a++){
      PVector averageV = new PVector();
      float count = 0;
      //this starts another loop to create a nested for loop to check for neighbours, for every boid
      for (int b = 0; b < size; b++){
          //this starts another loop to create a nested for loop to check for neighbours, for every boid
          float distance = boids.get(a).location.dist(boids.get(b).location);
          //this checks whether the boid is within the range of the radius to be considered a neighbour
          if (distance < radius){
            //this adds up the velocities of the boids within the neighbour radius
            averageV.add(boids.get(b).velocity);
            count++;
          }
      }
            //this then finds the average velocity of the boids within the neighbour radius
            averageV.div(count);
            //this sets the boid's alignment heading value to the desired velocity to move with the boids, which will be later used to visualise this alignment algorithm
            boids.get(a).aHeading = averageV;       
            //this adds a small proportion of this average to the velocity of the boid, depending on the value of the public alignment variable
            boids.get(a).velocity.add(averageV.mult(alignment));
    }
  }
  
  //initiates the update function to write the code that should be infitely repeated
  public void update()
  {
    //to execute the cohesion algorithm
    cohesion();
    //to execute the alignment algorithm
    alignment();
    //to execute the separation algorithm
    separation();
     
    //starts a for loop to call the update function of every boid 
    for (int i = 0; i < size; i++) {
      boids.get(i).update();
    }
      
  }
  
  //initialises the show function to be used to draw the boids within the flock
  void show()
  {
    fill(colour);
    stroke(colour);
    //calls the present function to display the visualisations for the first boid in the flock
    boids.get(0).present();
    
    stroke(colour);
    //starts a for loop to call the show function of every boid to draw them
    for (int i = 1; i < size; i++) { //<>//
      boids.get(i).show();
    }
  }
  
}
