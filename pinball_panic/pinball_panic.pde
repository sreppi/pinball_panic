/*

Student:
Calvin Ip

Professor: 
Kit Barry

*/

// Variables
Pinball ball;
StaticBlocks block;

void setup()  {
  size (400, 600);
  frameRate(60);
  
  ball = new Pinball();
  block = new StaticBlocks();
}

void draw()  {
  background(#768ca4);
  rectMode(CENTER);
  
  ball.display();
  ball.physics();
  block.display();
  
}
