class Player {
  int x = 15, y = 16, dir = 0;
  float scale = 6;
  PGraphics pg;
  int[] DX = {0, 1, 0, -1};
  int[] DY = {-1, 0, 1, 0};

  void setup() {
    pg = createGraphics(11, 11);
  }

  void walk() {
    move(1);
  }
  
  void back() {
    move(-1);
  }
  
  void move(int d) {
    int nx = x + DX[dir]*d, ny = y + DY[dir]*d;
    if (m.check(nx, ny)) {
      x = nx;
      y = ny;
    }
  }

  void turnBy(int d) {
    dir = (dir + d + 4) % 4;
  }

  void draw() {
    //draw minimaze around player
    int N = pg.width;
    int k = N/2;
    pg.beginDraw();
    pg.background(0);
    pg.noStroke();
    for (int i = 0; i < N*N; i++) {
      int dx = i % N - k;
      int dy = i / N - k;
      int mx = x + dx;
      int my = y + dy;
      int mi = my * m.M + mx;
      if (m.check(mx, my)) continue;
      pg.fill(0,200,0);
      pg.rect(i % N, i / N, 1, 1);
    }
    pg.endDraw();

    //draw player
    pushMatrix();
    noStroke();
    fill(0, 255, 0);
    translate(width/2, height-43);
    tint(255,200);
    image(pg, -pg.width*scale/2, -pg.height*scale/2, pg.width*scale, pg.height*scale);
    rect(-scale/2, -scale/2, 1*scale, 1*scale);

    stroke(0, 255, 0);
    strokeWeight(2);
    rotate(HALF_PI * dir);
    line(0, 0, 0, -scale);
    strokeWeight(1);

    popMatrix();
  }
}
