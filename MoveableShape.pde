boolean wasAutomated = false;

class MoveableShape extends Shape {

  int side, xSide, ySide, zSide;
  float x, y, z, w, h, rx, ry, rz;
  float lineC;

  MoveableShape(int i, int side, int xSide, int ySide, int zSide, float x, float y, float z, float w, float h, float rx, float ry, float rz) {
    super(i);

    this.side = side;
    this.xSide = xSide;
    this.ySide = ySide;
    this.zSide = zSide;
    this.x = x;
    this.y = y;
    this.z = z;
    this.rx = rx;
    this.ry = ry;
    this.rz = rz;
    this.lineC = 0;


    addPoint(new PVector(-w/2, -h/2, 0));
    addPoint(new PVector(w/2, -h/2, 0));
    addPoint(new PVector(w/2, h/2, 0));
    addPoint(new PVector(-w/2, h/2, 0));
    
  }

  void randomLineColor() {
    if (this.lineC == 0) {
      if (int(random(400)) == 0) {
        this.lineC = 255;
      }
    } else {
      this.lineC = lineC - 2.5;
      if (this.lineC < 0) {
        this.lineC = 0;
      }
    }
  }


  void drawShapeCube() {
    //stroke(this.lineC);
    //this.lineC = color(255);
    if (lineC > 1) {
      if (side == TOP_S || side == BOTTOM_S) {
        drawCube(side, xSide, zSide, color(lineC));
      } else if (side == LEFT_S || side == RIGHT_S) {
        drawCube(side, ySide, zSide, color(lineC));
      } else {
        drawCube(side, xSide, ySide, color(lineC));
      }
    }
  }


  void initShapeLines() {
    pushMatrix();

    screen.pushMatrix();

    screen.translate(screen.width/2, screen.height/2, 0);
    screen.rotateX(rx);
    screen.rotateY(ry);
    screen.rotateZ(rz);


    screen.translate(x, y, z);

    int p1 = 0, p2 = 0, p3 = 0, p4 = 0, o1 = 0, o2 = 0;
    if (side == TOP_S || side == BOTTOM_S) {
      // horiz towards back plane
      p1 = 0;
      p2 = 1;
      o1 = X_ORIENT;
      // horiz out of page
      //p1 = 2;
      //p2 = 3;

      if (side == TOP_S) {
        // right vert
        p3 = 1;
        p4 = 2;
        o2 = Z_ORIENT;
      } else {
        // left vert
        p3 = 3;
        p4 = 0;
        o2 = Z_ORIENT;
      }
    } else if (side == RIGHT_S || side == LEFT_S) {


      // vert towards back plane
      p1 = 1;
      p2 = 2;
      o1 = Y_ORIENT;

      // vert towards out of screen
      //p1 = 0;
      // p2 = 3;

      if (side == RIGHT_S) {
        // horiz bottom
        p3 = 2;
        p4 = 3;
        o2 = Z_ORIENT;
      } else {
        // horiz top
        p3 = 0;
        p4 = 1;
        o2 = Z_ORIENT;
      }
    } else {
      // vertical on back plane
      p1 = 1;
      p2 = 2;
      o2 = Y_ORIENT;

      // horizontal on back plane
      p3 = 2;
      p4 = 3;
      o2 = X_ORIENT;
    }


    PVector point1 = ks.getSurface(0).getTransformedCursor(int(screen.screenX(pts.get(p1).x, pts.get(p1).y)), int(screen.screenY(pts.get(p1).x, pts.get(p1).y)));
    PVector point2 = ks.getSurface(0).getTransformedCursor(int(screen.screenX(pts.get(p2).x, pts.get(p2).y)), int(screen.screenY(pts.get(p2).x, pts.get(p2).y)));
    //if (!(side==BACK_S && xSide == 2)) 
    lines.add(new Line(point1.x, point1.y, point2.x, point2.y, o1, side, xSide, ySide, zSide));


    PVector point3 = ks.getSurface(0).getTransformedCursor(int(screen.screenX(pts.get(p3).x, pts.get(p3).y)), int(screen.screenY(pts.get(p3).x, pts.get(p3).y)));
    PVector point4 = ks.getSurface(0).getTransformedCursor(int(screen.screenX(pts.get(p4).x, pts.get(p4).y)), int(screen.screenY(pts.get(p4).x, pts.get(p4).y)));
   
    //if (!(side==BACK_S && ySide == 2))
    lines.add(new Line(point3.x, point3.y, point4.x, point4.y, o2, side, xSide, ySide, zSide) );

    if (zSide == 0) {
      if (side == TOP_S || side == BOTTOM_S) {

        // horiz towards out of page
        p1 = 2;
        p2 = 3;
        o1 = X_ORIENT;
      } else if (side == RIGHT_S || side == LEFT_S) {

        // vert towards back plane
        p1 = 0;
        p2 = 3;
        o1 = Y_ORIENT;
      }
      lastLines.add(new Line(screen.screenX(pts.get(p1).x, pts.get(p1).y), screen.screenY(pts.get(p1).x, pts.get(p1).y), 
        screen.screenX(pts.get(p2).x, pts.get(p2).y), screen.screenY(pts.get(p2).x, pts.get(p2).y), o1, side, xSide, ySide, zSide-1) );
    }

    screen.popMatrix();
    popMatrix();
  }



  void displayPerfect(int sw, PGraphics g) {
    g.pushMatrix();
    g.rotateX(rx);
    g.rotateY(ry);
    g.rotateZ(rz);
    g.translate(x, y, z);
    g.fill(map(zSide, 0, 4, 0, 255), 0, map(zSide, 0, 4, 255, 0));
    super.displayPerfect(sw, g);

    //stroke(255);
    g.noStroke();
    g.popMatrix();
  }

  void display(PGraphics g) {
    //fill(c);
    //noFill();
    g.noStroke();

    g.pushMatrix();

    g.rotateX(rx);
    g.rotateY(ry);
    g.rotateZ(rz);

    g.translate(x, y, z);
    //pulse(-1, 200);
    //pulseRainbow();
    //if (side == BACK_S) fill(0);
    g.fill(c);
    super.display(g);

    //stroke(255);
    g.noStroke();
    //sidesToRects(10);
    //drawMoveable();
    g.popMatrix();

    //checkMouseOver();
  }

  void pulse(int direction, int speed) {
    if (millis() - lastChecked > speed) {
      visualIndex+=direction;
      if (visualIndex < 0) visualIndex = numRectZ -1;
      else if (visualIndex > numRectZ -1) visualIndex = 0;

      lastChecked = millis();
    }
    if (this.zSide == visualIndex) {
      fill(255);
    } else fill(100);
  }



  // ah, so this creates a gradient from c1 to c2 and back to c1 so that they 
  // can loop
  // 
  void setGradientZ(color c1, color c2, int jump) {
    colorMode(HSB, 255);
    int colhue = (int((counter/1.5))%255) + zSide*jump;
    if (colhue < 0) colhue += 255;
    else if (colhue > 255) colhue -= 255;
    colorMode(RGB, 255);
    float m;
    if (colhue < 127) {
      m = constrain(map(colhue, 0, 127, 0, 1), 0, 1);
      c = lerpColor(c1, c2, m);
    } else {
      m = constrain(map(colhue, 127, 255, 0, 1), 0, 1);
      c = lerpColor(c2, c1, m);
    }
  }



  void setRainbow(int jump) {
    colorMode(HSB, 255);
    int colhue = (frameCount%255) + zSide*jump;
    if (colhue < 0) colhue += 255;
    else if (colhue > 255) colhue -= 255;
    if (zSide == numRectZ-1) c = 0;
    else c = color(colhue, 255, 255);
  }

  void sideColor(color[] cols) {
    if (side == BACK_S) {
      fill(cols[5]);
    } else if (side == LEFT_S) {
      fill(cols[0]);
    } else if (side == TOP_S) {
      fill(cols[1]);
    } else if (side == BOTTOM_S) {
      fill(cols[3]);
    } else if (side == RIGHT_S) {
      fill(cols[2]);
    }
  }

  void sidesToRects(int s, PGraphics g) {
    int jump = 1;
    g.pushMatrix();
    if (side == BACK_S) g.translate(0, 0, jump);
    else if (side == LEFT_S)g.translate(0, 0, jump);
    else if (side == TOP_S) g.translate(0, 0, -jump);
    else if (side == BOTTOM_S) g.translate(0, 0, jump);
    else if (side == RIGHT_S) g.translate(0, 0, -jump);
    super.sidesToRects(s, g);
    g.popMatrix();
  }

  PVector checkMouseOver() {
    for (PVector p : pts) {
      PVector temp = new PVector(screenX(p.x, p.y, p.z), screenY(p.x, p.y, p.z));
      float d = temp.dist(new PVector(mouseX, mouseY));
      println(d);
      if (d < 10) {
        println("found one");
        return p;
      }
    }
    return null;
  }
}
