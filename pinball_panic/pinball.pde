class Pinball {
  // Variables
  PVector position = new PVector(200, 200);
  PVector velocity = new PVector(0, 2.1);
  PVector gravity = new PVector(0, 0.2);

  float radius, m;

  float BOUNCEFACTOR = 0.5;
  float FRICTION = 0.995;

  // Contructor
  Pinball(float x, float y, float r) {
    position = new PVector (x, y);
    radius = r;
    m = radius * 1;
  }

  void display() {
    noStroke();
    fill(#D7D7DE);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }

  void physics() {
    position.add(velocity);
    velocity.add(gravity);
  }

  void checkBoundaryCollision() {

    // Bounce off edges
    if ((position.x > width - radius) || (position.x < 0 + radius)) {
      velocity.x = velocity.x * -1;
    }
    if (position.y > height - radius) {
      velocity.y = velocity.y * -BOUNCEFACTOR; // Reducing the velocity when it hits the floor
      position.y = height - radius;
      friction();
    }
  }



  void bounce() {
    velocity.y *= -BOUNCEFACTOR;
    position.y += velocity.y;
  }

  void wallBounce() {
    velocity.x *= -BOUNCEFACTOR;
    position.x += velocity.x;
  }

  void friction() {
    velocity.x *= FRICTION;
  }

void checkCollision(Pinball other) {
  // Get distances between the balls components
  PVector distanceVect = PVector.sub(other.position, position);

  // Calculate magnitude of the vector separating the balls
  float distanceVectMag = distanceVect.mag();

  // Minimum distance before they are touching
  float minDistance = radius + other.radius;

  // Only check collision if the balls have moved a certain distance
  if (distanceVectMag < minDistance && distanceVectMag > 0.1) {
    float distanceCorrection = (minDistance - distanceVectMag) / 2.0;
    PVector d = distanceVect.copy();
    PVector correctionVector = d.normalize().mult(distanceCorrection);
    other.position.add(correctionVector);
    position.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball positions. You
       just need to worry about bTemp[1] position*/
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      /* this ball's position is relative to the other
       so you can use the vector between them (bVect) as the
       reference point in the rotation expressions.
       bTemp[0].position.x and bTemp[0].position.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate
       the final velocity along the x-axis. */
      PVector[] vFinal = {
        new PVector(), new PVector()
      };

      // final rotated velocity for b[0]
      vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = {
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      other.position.x = position.x + bFinal[1].x;
      other.position.y = position.y + bFinal[1].y;

      position.add(bFinal[0]);

      // update velocities
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  }
}
