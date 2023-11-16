/*

Student:
Calvin Ip

Professor: 
Kit Barry

*/

// Variables
Pinball[] ball =  {
  new Pinball(200, 200, 10),
  new Pinball(201, 300, 10)
};

StaticBlocks[] block =  {
  new StaticBlocks(200, 500, 50, 50)
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
    b.checkBoundaryCollision();
  }
  
  ball[0].checkCollision(ball[1]);
  
  for (StaticBlocks b: block)  {
    b.display();
  }
  
}
