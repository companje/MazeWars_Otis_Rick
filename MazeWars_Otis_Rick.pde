Maze m = new Maze();
Player p = new Player();
View3D v = new View3D();
  
void setup() {
  size(800, 800);
  noSmooth();
  p.setup();
  v.setup();  
}

void draw() {
  background(0);
  v.draw();
  p.draw();
}

void keyPressed() {
  if (keyCode==UP) p.walk();
  if (keyCode==DOWN) p.back();
  if (keyCode==LEFT) p.turnBy(-1);
  if (keyCode==RIGHT) p.turnBy(1);
  v.startFade();
}
