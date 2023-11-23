/*

 Student:
 Calvin Ip
 
 Professor:
 Kit Barry
 
 */

// Variables
ArrayList<Pinball> ball;
float spawnTimer = 0;

StaticBlocks[] block =  {
  new StaticBlocks(200, 500, 50, 50),
  new StaticBlocks(300, 600, 50, 50),
  new StaticBlocks(100, 600, 50, 50)
};

void setup() {
  size (400, 600);
  frameRate(60);
  ball = new ArrayList<Pinball>();
}

void draw()  {
  background(#768ca4);
  rectMode(CENTER);
  
  // Check collisions between balls
  for (int i = 0; i < ball.size(); i++) {
    for (int j = i + 1; j < ball.size(); j++) {
      ball.get(i).checkCollision(ball.get(j));
    }
  }

  for (Pinball b : ball)  {
    b.display();
    b.physics();
    b.checkBoundaryCollision();
    
    for (StaticBlocks c: block) {
      if((b.position.y - b.radius) < (c.position.y + c.size.y / 2) && (b.position.y + b.radius) > (c.position.y - c.size.y / 2)) {
        if((b.position.x - b.radius) < (c.position.x + c.size.x / 2) && (b.position.x + b.radius) > (c.position.x - c.size.x / 2)) {
          b.bounce();
          b.friction();
        }
      }
      if((b.position.x - b.radius) < (c.position.x + c.size.x / 2) && (b.position.x + b.radius) > (c.position.x - c.size.x / 2)) {
        if((b.position.y - b.radius) < (c.position.y + (c.size.y - 6) / 2) && (b.position.y + b.radius) > (c.position.y - (c.size.y - 6) / 2)) {
          b.wallBounce();
        }
      }
    }
  }
  
  for (StaticBlocks b: block)  {
    b.display();
  }
  
  if(mousePressed && spawnTimer == 0)  {
    spawnTimer = 1;
    Pinball newBall = new Pinball(random(198,202), 200, 10);
    // Check collisions between the new ball and existing balls
    for (Pinball existingBall : ball) {
      existingBall.checkCollision(newBall);
    }
    ball.add(newBall);
  }
  
  if (spawnTimer >= 1 && spawnTimer < 60)  {
    spawnTimer += 1;
  }
  if (spawnTimer >= 60)  {
    spawnTimer = 0;
  }
}
