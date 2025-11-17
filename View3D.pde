class View3D {
  PGraphics pg3;
  PImage pg3_old;
  int fadeDuration = 500;
  long fadeStartTime = -fadeDuration;

  void setup() {
    pg3 = createGraphics(200, 200);
  }

  void draw() {
    int b[] = new int[18];
    int lut[][] = {
      {-1, -5, 0, -5, 1, -5, -1, -4, 0, -4, 1, -4, -1, -3, 0, -3, 1, -3, -1, -2, 0, -2, 1, -2, -1, -1, 0, -1, 1, -1, -1, 0, 0, 0, 1, 0},
      {5, 1, 5, 0, 5, 1, 4, -1, 4, 0, 4, 1, 3, -1, 3, 0, 3, 1, 2, -1, 2, 0, 2, 1, 1, -1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1},
      {1, 5, 0, 5, -1, 5, 1, 4, 0, 4, -1, 4, 1, 3, 0, 3, -1, 3, 1, 2, 0, 2, -1, 2, 1, 1, 0, 1, -1, 1, 1, 0, 0, 0, -1, 0},
      {-5, -1, -5, 0, -5, -1, -4, 1, -4, 0, -4, -1, -3, 1, -3, 0, -3, -1, -2, 1, -2, 0, -2, -1, -1, 1, -1, 0, -1, -1, 0, -1, 0, 0, 0, -1},
    };

    for (int i=0; i<b.length; i++) {
      int dx = lut[p.dir][i*2];
      int dy = lut[p.dir][i*2+1];
      int x = p.x+dx;
      int y = p.y+dy;
      int j = y*m.M+x;
      b[i] = (x>=0 && y>=0 && x<m.M && y<m.M) ? m.maze[j] : 0;
    }

    pg3.beginDraw();
    pg3.background(0);
    pg3.translate(pg3.width/2, pg3.height/2);
    pg3.fill(0,20,0,240);
    //pg3.noFill();
    pg3.stroke(0, 255, 0);
    pg3.rectMode(CENTER);

    float s[] = {120, 100, 80, 62, 45, 29, 15, 7, 7};

    //draw trapezoids
    for (int i=0; i<b.length; i++) {
      if (b[i]==0) continue;
      int x = i%3;
      int y = i/3;
      if (x==0 || x==2) {
        float m = x==0 ? -1 : 1;
        pg3.beginShape();
        pg3.vertex(m*s[5-y], -s[6-y]);
        pg3.vertex(m*s[5-y], s[6-y]);
        pg3.vertex(m*s[6-y], s[6-y]);
        pg3.vertex(m*s[7-y], s[7-y]);
        pg3.vertex(m*s[7-y], -s[7-y]);
        pg3.vertex(m*s[6-y], -s[6-y]);
        pg3.endShape(CLOSE);
      }
    }

    //draw squares
    for (int i=0; i<b.length; i++) {
      if (b[i]==0) continue;
      //pg3.stroke(mazeColors[i]);
      int x = i%3;
      int y = i/3;
      if (x==1) {
        pg3.rect(0, 0, s[6-y]*2, s[6-y]*2);
      }
    }
    pg3.endDraw();

    //crossfade old view into new view if key was pressed recently
    if (millis()-fadeStartTime < fadeDuration) {
      int alpha = (int)map(millis()-fadeStartTime, 0, fadeDuration, 0, 255);
      tint(255, 255-alpha);
      image(pg3_old, 0, 0, width, height);
      tint(255, alpha);
    }
    image(pg3, 0, 0, width, height);
    tint(255);
  }

  void startFade() {
    pg3_old = pg3.get();
    fadeStartTime = millis();
  }
}
