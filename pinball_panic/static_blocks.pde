class StaticBlocks  {
  // Variables
  PVector position;
  PVector size;
  
  // Contructor
  StaticBlocks(float x, float y, float w, float h)  {
    position = new PVector(x, y);
    size = new PVector(w,h);
  }
  
  void display() {
    noStroke();
    fill(#DB689A);
    rect(position.x, position.y, size.x, size.y);
  }
  
}
