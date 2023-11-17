/*

Student:
Calvin Ip

Professor: 
Kit Barry

*/

// Variables
Pinball[] ball =  {
  new Pinball(200, 200, 10),
  new Pinball(202, 300, 10)
};

StaticBlocks[] block =  {
  new StaticBlocks(200, 500, 50, 50),
  new StaticBlocks(300, 600, 50, 50)
};

void setup()  {
  size (400, 600);
  frameRate(60);
}

void draw()  {
  background(#768ca4);
  rectMode(CENTER);
  
  for (Pinball b : ball)  {
    b.display();
    b.physics();
    for (StaticBlocks c: block) {
      if((b.position.y - b.radius) < (c.position.y + c.size.y / 2) && (b.position.y + b.radius) > (c.position.y - c.size.y / 2)) {
        if((b.position.x - b.radius) < (c.position.x + c.size.x / 2) && (b.position.x + b.radius) > (c.position.x - c.size.x / 2)) {
          b.bounce();
          b.friction();
        }
      }
      if((b.position.x - b.radius) < (c.position.x + c.size.x / 2) && (b.position.x + b.radius) > (c.position.x - c.size.x / 2)) {
        if((b.position.y - b.radius) < (c.position.y + (c.size.y - 6) / 2) && (b.position.y + b.radius) > (c.position.y - (c.size.y - 6) / 2)) { // Subtracting 6 from the size is to prevent some weird clipping error.
          b.wallBounce();
        }
      }

    }
    
    //bisector for slopes to rotate
    //intersection for a line
    //balls as a point rather than a circle
        
    b.checkBoundaryCollision();
  }
  
  ball[0].checkCollision(ball[1]);
  
  for (StaticBlocks b: block)  {
    b.display();
  }
  
}
