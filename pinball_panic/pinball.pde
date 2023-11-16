class Pinball {
  // Variables
  PVector position = new PVector(200,200);
  PVector velocity = new PVector(0, 2.1);
  PVector gravity = new PVector(0, 0.2);
  
  // Contructor
  Pinball() {
    
  }
  
  void display()  {
    noStroke();
    fill(#D7D7DE);
    ellipse(position.x, position.y, 20, 20);
  }
  
  void physics()  {
    position.add(velocity);
    velocity.add(gravity);
    
      // Bounce off edges
    if ((position.x > width) || (position.x < 0)) {
      velocity.x = velocity.x * -1;
    }
    if (position.y > height) {
      velocity.y = velocity.y * -0.5; // Reducing the velocity when it hits the floor
      position.y = height;
    }
  }
}
