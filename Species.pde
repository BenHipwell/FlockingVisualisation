//creates the species class which is used to create instances of species of multiple flocks
class Species{
  //creates an array of flock instances
  ArrayList<Flock> flocks = new ArrayList<Flock>();
  //creates a private integer which is used to store the number of the flocks to create, which is passed through from the contructor
  private int size;
  
    //initialises the constructor procedure, in which the number of flocks within the species is passed into
    Species(int size)
  {
    this.size = size;
    GenFlocks();
  }
  
  //initialises the procedure to generate the flocks
  void GenFlocks(){
    //changes the colour mode temporarily to make the colour of the boids to be vivid against the black background 
    colorMode(HSB, 1);
    //this starts a for loop which adds a new flock to the object array based on the number of flocks determined
    for (int i = 0; i < size; i++){
      //this adds a new flock passing through the size of the flock and the randomised colour of that flock
      flocks.add(new Flock(400, color(random(1),random(0.8,1),random(0.7,1))));
    }
    colorMode(RGB,255);
  }
  
  //initiates the update function to write the code that should be infitely repeated
  void update(){
    
    //starts a for loop to call the update function of every flock
    for (int i = 0; i < size; i++) {
      flocks.get(i).update();
    }
  }
  
  //initialises the show function used to draw the boids, via the flock's show method
  void show(){
    
    //starts a for loop to call the show function of every flock
    for (int i = 0; i < size; i++) {
      flocks.get(i).show();
    }
  }
  
  
}
