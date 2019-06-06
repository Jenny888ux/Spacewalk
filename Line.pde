
ArrayList<Line> lastLines = new ArrayList<Line>();

void displayQuad() {
  for (Line l : lines) {
    l.displayQuad();
  }
}

void displayQuadOff() {
  for (Line l : lines) {
    l.displayQuadOff();
  }
}

// not working
void drawLineSegBottomZ(float per, color c) {
  float zD = per * 5;
  int full = int(zD);
  for (int i = full; i >= 0; i++) {
    drawLineBottomZ(0, i, c);
  }
  Line l = getLine(BOTTOM_S, Z_ORIENT, 0, full+1);
  l.displaySegment(0, zD-full);
}


void drawCube(int index, color c) {
  // rings clockwise from bottom left
  if (index < 5*3*4) {
    int s = index % 12;
    int z = index/12;
    if (s < 3) {
      drawCubeLeft(s, z, c);
    } else if (s < 6) {
      drawCubeTop(s-3, z, c);
    } else if (s < 9) {
      int v = s - 6;
      drawCubeRight(2-v, z, c);
    } else {
      int v = s - 9;
      drawCubeBottom(2-v, z, c);
    }
  } else {
    int x = (index-5*3*4)/4;
    int y = (index-5*3*4)%4;
    drawCubeBack(x, y, c);
  }
}

void drawCubeRing(int zCircle, color c) {
  drawCircle(zCircle, c);
  drawCircle(zCircle+1, c);
  for (int i = 0; i < 5; i++) {
    drawLineTopZ(i, zCircle, c);
    drawLineBottomZ(i, zCircle, c);
    drawLineLeftZ(i, zCircle, c);
    drawLineRightZ(i, zCircle, c);
  }
}

void drawCubeBottom(int pos, int zCircle, color c) {
  drawLineBottomX(pos, zCircle, c);
  drawLineBottomX(pos, zCircle+1, c);
  drawLineBottomZ(pos, zCircle, c);
  drawLineBottomZ(pos+1, zCircle, c);
}

void drawCubeTop(int pos, int zCircle, color c) {
  drawLineTopX(pos, zCircle, c);
  drawLineTopX(pos, zCircle+1, c);
  drawLineTopZ(pos, zCircle, c);
  drawLineTopZ(pos+1, zCircle, c);
}

void drawCubeLeft(int pos, int zCircle, color c) {
  drawLineLeftY(pos, zCircle, c);
  drawLineLeftY(pos, zCircle+1, c);
  drawLineLeftZ(pos, zCircle, c);
  drawLineLeftZ(pos+1, zCircle, c);
}

void drawCubeRight(int pos, int zCircle, color c) {
  drawLineRightY(pos, zCircle, c);
  drawLineRightY(pos, zCircle+1, c);
  drawLineRightZ(pos, zCircle, c);
  drawLineRightZ(pos+1, zCircle, c);
}

void drawCubeBack(int x, int y, color c) {
  drawLineBackX(x, y, c);
  drawLineBackX(x, y+1, c);
  drawLineBackY(x, y, c);
  drawLineBackY(x+1, y, c);
}

void drawTop(color c) {
  for (int j = 0; j < 6; j++) {
    for (int i = 0; i < 4; i++) {
      drawLineTopX(i, j, c);
      drawLineTopZ(i, j, c);
    }
  }
}

void drawBottom(color c) {
  for (int j = 0; j < 6; j++) {
    for (int i = 0; i < 4; i++) {
      drawLineBottomX(i, j, c);
      drawLineBottomZ(i, j, c);
    }
  }
}

void drawBack(color c) {
  for (int j = 0; j < 4; j++) {
    for (int i = 0; i < 4; i++) {
      drawLineBackX(i, j, c);
      drawLineBackY(i, j, c);
    }
  }
}

void drawZColumn(int z, color c) {
  // clockwise from top
  if (z < 3) {
    for (int i = 0; i < 6; i++) {
      drawCubeTop(z, i, c);
    }
  } else if (z < 6) {
    for (int i = 0; i < 6; i++) {
      drawCubeRight(2-(z-3), i, c);
    }
  } else if (z < 9) {
    for (int i = 0; i < 6; i++) {
      drawCubeBottom(2-(z-6), i, c);
    }
  } else if (z < 12) {
    for (int i = 0; i < 6; i++) {
      drawCubeLeft((z-9), i, c);
    }
  }
}

void drawZLines(color c) {
  for (int j = 0; j < 6; j++) {
    for (int i = 0; i < 4; i++) {
      drawLineTopZ(i, j, c);
      drawLineBottomZ(i, j, c);
      drawLineLeftZ(i, j, color(255));
      drawLineRightZ(i, j, color(255));
    }
  }
}

void drawAllLines() {
  for (int j = 0; j < 6; j++) {
    for (int i = 0; i < 4; i++) {
      drawLineTopX(i, j, color(255));
      drawLineTopZ(i, j, color(255));

      drawLineBottomX(i, j, color(255));
      drawLineBottomZ(i, j, color(255));

      drawLineLeftY(i, j, color(255));
      drawLineLeftZ(i, j, color(255));

      drawLineRightY(i, j, color(255));
      drawLineRightZ(i, j, color(255));

      drawLineBackX(i, j, color(255));
      drawLineBackY(i, j, color(255));
    }
  }
}


void drawCircle(int zCircle, color c) {
  for (int i = 0; i < 4; i++) {
    drawLineTopX(i, zCircle, c);
    drawLineBottomX(i, zCircle, c);
  }
  for (int i = 0; i < 3; i++) {
    drawLineLeftY(i, zCircle, c);
    drawLineRightY(i, zCircle, c);
  }
}



void drawCube(int side, int position, int zCircle, color c) {
  if (side == TOP_S) drawCubeTop(position, zCircle, c);
  else if (side == BOTTOM_S) drawCubeBottom(position, zCircle, c);
  else if (side == LEFT_S) drawCubeLeft(position, zCircle, c);
  else if (side == RIGHT_S) drawCubeRight(position, zCircle, c);
  else if (side == BACK_S) drawCubeBack(position, zCircle, c);
}

void updateLinePositions() {
  for (Line l : lines) {
    l.update();
  }
}

void automateLinesGeneration() {
  lines = new ArrayList<Line>();
  for (Shape s : shapes) {
    ((MoveableShape)s).initShapeLines();
  }
  //screen.endDraw();
  lines.addAll(lines.size(), lastLines);
}

/*
I want to be able to query by row, column, and z depth
 
 make a series of lines (all grouped into a bigger line?) with nodes along the way
 */

//void addNode(int mx, int my) {
//  nodes.add(new Node(nodes.size() + "", mx, my));
//}

//boolean hasCurrentNode() {
//  return (currentNodeIndex > -1);
//}

//void moveCurrentNode(int dx, int dy) {
//  nodes.get(currentNodeIndex).move(dx, dy);
//}

//void displayCurrentNode() {
//  if (hasCurrentNode()) {
//    fill(0, 255, 0);
//    stroke(0, 255, 0);
//    //nodes.get(currentNodeIndex).display();
//  }
//}

//void setCurrentNodeZ(int zp) {
//  nodes.get(currentNodeIndex).z = zp;
//}

//int getClickedNode(int mx, int my) {
//  for (int i = 0; i < nodes.size(); i++) {
//    if (nodes.get(i).mouseOver(mx, my)) {
//      return i;
//    }
//  }
//  return -1;
//}

//void checkEdgeClick(int mx, int my) {
//  int prevNodeIndex = currentNodeIndex;
//  //currentNodeIndex = getClickedNode(mx, my);
//  //cout << currentNodeIndex << " " << prevNodeIndex << std::endl;
//  // if we actually clicked on a star to create an edge
//  if (currentNodeIndex >= 0) {
//    // if we've already selected a star
//    if (prevNodeIndex >= 0) {
//      // oops, clicked on the same star
//      if (prevNodeIndex == currentNodeIndex) {
//        currentNodeIndex = -1;
//      }
//      // clicked a new star! let's add an edge
//      else {
//        // add link in adjacency matrix
//        Node n2 = nodes.get(prevNodeIndex);
//        Node n1 = nodes.get(currentNodeIndex);
//        //lines.add(new Line(n1.getX(), n1.getY(), n2.getX(), n2.getY(), prevNodeIndex, currentNodeIndex));
//      }
//    }
//  }
//}


//void checkNodeClick(int mx, int my) {
//  currentNodeIndex = getClickedNode(mx, my);
//}

//void checkDeleteNodeClick(int mx, int my) {
//  currentNodeIndex = getClickedNode(mx, my);
//  if (currentNodeIndex > -1) {
//    removeNode(currentNodeIndex);
//    currentNodeIndex = -1;
//  }
//}

//int getCurrentNode() {
//  //cout << currentNodeIndex << std::endl;
//  return currentNodeIndex;
//}

//void setCurrentNode(int num) {
//  this.currentNodeIndex = num;
//}


//void removeNode(int index) {
//  nodes.remove(index);
//  deleteLines(index);
//}

//void displayNodes() {
//  for (int i = 0; i < nodes.size(); i++) {
//    nodes.get(i).display();
//  }
//}

//void displayNodeLabels() {
//  for (int i = 0; i < nodes.size(); i++) {
//    nodes.get(i).displayLabel();
//  }
//}


//void drawLineToCurrent(int x, int y) {
//  stroke(255);
//  if (currentNodeIndex > -1 && currentNodeIndex < nodes.size()) {
//    line(nodes.get(currentNodeIndex).getX(), nodes.get(currentNodeIndex).getY(), x, y);
//  }
//}


void saveLines() {
  processing.data.JSONObject json;
  json = new processing.data.JSONObject();
  json.setInt("linesNum", lines.size());
  saveJSONObject(json, "data/lines/lines.json");

  for (int i = 0; i < lines.size(); i++) {
    processing.data.JSONObject json2;
    json2 = new processing.data.JSONObject();
    Line l = lines.get(i);
    json2.setInt("x1", l.getX1());
    json2.setInt("y1", l.getY1());
    json2.setInt("x2", l.getX2());
    json2.setInt("y2", l.getY2());
    json2.setInt("orient", l.orient);
    json2.setInt("side", l.side);
    json2.setInt("xs", l.xs);
    json2.setInt("ys", l.ys);
    json2.setInt("zs", l.zs);


    saveJSONObject(json2, "data/lines/line" + i + ".json");
  }
}

void loadLines() {
  processing.data.JSONObject json;
  json = loadJSONObject("data/lines/lines.json");
  int linesNum = json.getInt("linesNum");

  for (int i = 0; i < linesNum; i++) {
    processing.data.JSONObject lineJson = loadJSONObject("data/lines/line" + i + ".json");
    int x1 = lineJson.getInt("x1");
    int y1 = lineJson.getInt("y1");
    int x2 = lineJson.getInt("x2");
    int y2 = lineJson.getInt("y2");
    int orient = lineJson.getInt("orient");
    int side =  lineJson.getInt("side");
    int xs =  lineJson.getInt("xs");
    int ys =  lineJson.getInt("ys");
    int zs =  lineJson.getInt("zs");

    lines.add(new Line(x1, y1, x2, y2, orient, side, xs, ys, zs));
    //lines.get(i).zIndex = z;
    //lines.get(i).constellationG = cg;
  }
}



class Line {

  PVector p1;
  PVector p2;
  PVector originalP1, originalP2;
  float ang;
  //int constellationG = 0;
  //int twinkleT;
  //int twinkleRange = 0;
  long lastChecked = 0;
  int rainbowIndex = int(random(255));
  int xs, ys, zs;
  int orient;
  int side;


  Line(float x1, float y1, float x2, float y2, int orient, int s, int xs, int ys, int zs) {
    this.p1 = new PVector(x1, y1);
    this.p2 = new PVector(x2, y2);
    this.originalP1 =new PVector(x1, y1);
    this.originalP2 = new PVector(x2, y2);
    initLine();

    this.orient = orient;
    this.side = s;
    this.xs = xs;
    this.ys = ys;
    this.zs = zs;
  }

  void update() {
    p1 = ks.getSurface(0).getPointOnTransformedPlane(originalP1.x, originalP1.y).add(ks.getSurface(0).x, ks.getSurface(0).y);
    p2 = ks.getSurface(0).getPointOnTransformedPlane(originalP2.x, originalP2.y).add(ks.getSurface(0).x, ks.getSurface(0).y);
  }



  void initLine() {
    leftToRight();
    ang = atan2(this.p1.y - this.p2.y, this.p1.x - this.p2.x);
    if (ang > PI/2) ang -= 2*PI;
    //twinkleT = int(random(50, 255));
    //twinkleRange = int(dist(p1.x, p1.y, p2.x, p2.y)/100);
  }

  void display(color c) {
    stroke(c);
    fill(c);
    display();
  }


  void display() {
    line(p1.x, p1.y, p2.x, p2.y);
  }

  void displayQuadOff() {
    pushMatrix();
    float len = dist(p1.x, p1.y, p2.x, p2.y);
    float ang = atan2(this.p1.y - this.p2.y, this.p1.x - this.p2.x);
    translate(p1.x, p1.y);
    rotateZ(ang+PI/2);
    noStroke();
    float sw = strokeVizWeight;
    beginShape();


    fill(0);
    vertex(-sw/2, 0);
    vertex(sw/2, 0);
    vertex(sw/2, len);

    vertex(-sw/2, len);
    endShape();
    popMatrix();
  }

  void displayQuad() {
    pushMatrix();
    float len = dist(p1.x, p1.y, p2.x, p2.y);
    float ang = atan2(this.p1.y - this.p2.y, this.p1.x - this.p2.x);
    translate(p1.x, p1.y);
    rotateZ(ang+PI/2);
    noStroke();
    float sw = strokeVizWeight;
    //if (!( orient == Y_ORIENT )) {
      beginShape();


      fill(255);
      if (side != BACK_S) {
        if (side == RIGHT_S) fill(map(zs+1, 0, numRectZ, 255, 50));
        else fill(map(zs, 0, numRectZ, 255, 50));
      }
      vertex(-sw/2, 0);
      vertex(sw/2, 0);
      if (orient == Z_ORIENT && side != BACK_S) {
        if (side == RIGHT_S) fill(map(zs, 0, numRectZ, 255, 50));
        else fill(map(zs+1, 0, numRectZ, 255, 50));
      }
      vertex(sw/2, len);

      vertex(-sw/2, len);
      endShape();
    //}
    popMatrix();
    //stroke(255);
  }

  void displayCenterPulse(float per) {
    per = constrain(per, 0, 1.0);
    float midX = (p1.x + p2.x)/2;
    float midY = (p1.y + p2.y)/2;
    float x1 = map(per, 0, 1.0, midX, p1.x);
    float x2 = map(per, 0, 1.0, midX, p2.x);
    float y1 = map(per, 0, 1.0, midY, p1.y);
    float y2 = map(per, 0, 1.0, midY, p2.y);
    stroke(255);
    strokeWeight(strokeVizWeight);
    line(x1, y1, x2, y2);
  }



  void moveP1(int x, int y) {
    p1.x += x;
    p1.y += y;
  }

  void moveP2(int x, int y) {
    p2.x += x;
    p2.y += y;
  }

  void displayZDepth() {
    colorMode(HSB, 255);
    stroke(map(zs, 0, 9, 0, 255), 255, 255);
    display();
    colorMode(RGB, 255);
  }

  void leftToRight() {
    if (p1.x > p2.x) {
      PVector temp = new PVector(p1.x, p1.y);
      p1.set(p2);
      p2.set(temp);
    }
  }

  void rightToLeft() {
    if (p1.x < p2.x) {
      PVector temp = p1;
      p1.set(p2);
      p2.set(temp);
    }
  }

  void displayPercent(float per) {
    per*= 2;
    float p = constrain(per, 0, 1.0);
    PVector pTemp = PVector.lerp(p1, p2, p);
    line(p1.x, p1.y, pTemp.x, pTemp.y);
  }

  void displayPercentWid(float per) {
    per = constrain(per, 0, 1.0);
    int sw = int(map(per, 0, 1.0, 0, 5));
    strokeWeight(sw);
    line(p1.x, p1.y, p2.x, p2.y);
  }



  void displayBandX(int start, int end, color c) {
    if (p1.x > start && p1.x < end) {
      display(c);
    }
  }

  void randomSegment() {
    //float len = random(
  }

  void displayBandX(int start, int end) {
    if (p1.x > start && p1.x < end) {
      display(color(255));
    } else {
      displayNone();
    }
  }

  void displayBandY(int start, int end, color c) {
    if (p1.y > start && p1.y < end) {
      display(c);
    } else {
      displayNone();
    }
  }

  void displayBandZ(int start, int end, color c) {
    if (zs >= start && zs < end) {
      display(c);
    } else {
      displayNone();
    }
  }

  void displayBandZ(int band, color c) {
    if (zs == band) {
      display(c);
    } else {
      displayNone();
    }
  }

  void displayNone() {
    //strokeWeight(18);
    display(color(0));
    //strokeWeight(2);
  }


  void displayAngle(int start, int end, color c) {
    if (end < -360) {
      if (ang >= radians(start) || ang < end + 360) {
        display(c);
      }
    } else if (ang >= radians(start) && ang < radians(end)) {
      display(c);
    } else {
      displayNone();
    }
  }


  void displayEqualizer(int[] bandH, color c) {
    if (p1.x >= 0 && p1.x < width/4) {
      displayBandY(0, bandH[0], c);
    } else if (p1.x >= width/4 && p1.x < width/2) {
      displayBandY(0, bandH[1], c);
    } else if (p1.x >= width/2 && p1.x < width*3.0/4) {
      displayBandY(0, bandH[2], c);
    } else {
      displayBandY(0, bandH[3], c);
    }
  }

  void displayPointX(int x) {
    float ym;

    if (x > p1.x && x < p2.x) {
      ym = map(x, p1.x, p2.x, p1.y, p2.y);
      ellipse(x, ym, 10, 10);
    } else if (x > p2.x && x < p1.x) {
      ym = map(x, p2.x, p1.x, p2.y, p1.y);
      ellipse(x, ym, 10, 10);
    }
  }

  void displayPointY(int y) {
    float xm;
    if ( (y > p1.y && y < p2.y) ) {
      xm = map(y, p1.y, p2.y, p1.x, p2.x);
      ellipse(xm, y, 10, 10);
    } else if (y > p2.y && y < p1.y) {
      xm = map(y, p2.y, p1.y, p2.x, p1.x);
      ellipse(xm, y, 10, 10);
    }
  }

  // www.jeffreythompson.org/collision-detection/line-point.php
  boolean mouseOver() {
    float x1 = p1.x;
    float y1 = p1.y;
    float x2 = p2.x;
    float y2 = p2.y;
    float px = mouseX;
    float py = mouseY;
    float d1 = dist(px, py, x1, y1);
    float d2 = dist(px, py, x2, y2);
    float lineLen = dist(x1, y1, x2, y2);
    float buffer = 0.2;    // higher # = less accurate
    if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
      return true;
    }
    return false;
  }


  void displayZIndex() {
    colorMode(HSB, 255);
    display(color(map(zs, 0, numRectZ-1, 0, 255), 255, 255));
  }



  void handLight(float x, float y, int rad, color c) {
    float i = 0.0;
    float startX = p1.x;
    float startY = p1.y;
    boolean started = false;
    while (i < 1.0) {
      i+= .1;
      if (!started) {
        float dx = map(i, 0, 1.0, p1.x, p2.x);
        float dy = map(i, 0, 1.0, p1.y, p2.y);
        float dis = dist(x, y, dx, dy);
        if (dis < rad) {
          startX = dx;
          startY = dy;
          started = true;
        }
      } else {
        float dx = map(i, 0, 1.0, p1.x, p2.x);
        float dy = map(i, 0, 1.0, p1.y, p2.y);
        float dis = dist(x, y, dx, dy);
        if (dis > rad) {
          stroke(c);
          line(startX, startY, dx, dy);
          break;
        }
      }
    }
  }

  void displaySegment(float startPer, float sizePer) {
    PVector pTemp = PVector.lerp(p1, p2, startPer);
    PVector pTempEnd = PVector.lerp(pTemp, p2, constrain(startPer + sizePer, 0, 1));
    stroke(255);
    strokeWeight(strokeVizWeight);
    line(pTemp.x, pTemp.y, pTempEnd.x, pTempEnd.y);
  }


  int getX1() {
    return int(p1.x);
  }

  int getX2() {
    return int(p2.x);
  }

  int getY1() {
    return int(p1.y);
  }

  int getY2() {
    return int(p2.y);
  }

  void setGradientZ(color c1, color c2, int jump) {
    colorMode(HSB, 255);
    int colhue = (frameCount%255) + zs*jump;
    if (colhue < 0) colhue += 255;
    else if (colhue > 255) colhue -= 255;
    colorMode(RGB, 255);
    float m;
    if (colhue < 127) {
      m = constrain(map(colhue, 0, 127, 0, 1), 0, 1);
      display(lerpColor(c1, c2, m));
    } else {
      m = constrain(map(colhue, 127, 255, 0, 1), 0, 1);
      display(lerpColor(c2, c1, m));
    }
  }
}


void printLineLength(int inchesWide) {
  float len = 6;
  for (Line l : lines) {
    len += dist(l.p1.x, l.p1.y, l.p2.x, l.p2.y);
  }
  println(int(len) + "px", int(len*inchesWide/width) + "in", nf(len*inchesWide/width/12.0, 0, 2) +"ft");
  println("---------------");
}

void drawLine(int side, int orient, int position, int zCircle, color c) {
  if (side == TOP_S) {
    if (orient == X_ORIENT) {
      drawLineTopX(position, zCircle, c);
    } else if (orient == Z_ORIENT) {
      drawLineTopZ(position, zCircle, c);
    }
    // NOT DONE
  }
}

void drawLineRightZ(int position, int zCircle, color c) {
  Line l = getLineRightZ(position, zCircle);
  if (l != null) l.display(c);
}

Line getLineRightZ(int position, int zCircle) {
  if (lines.size() > 0) {
    if (position  >= 0 && position < 4 && zCircle >= 0 && zCircle < 5) {
      return getLine(RIGHT_S, Z_ORIENT, position, zCircle);
    }
  }
  return null;
}

void drawLineLeftZ(int position, int zCircle, color c) {
  Line l = getLineLeftZ(position, zCircle);
  if (l != null) l.display(c);
}


Line getLineLeftZ(int position, int zCircle) {
  if (lines.size() > 0) {
    if (position  >= 0 && position < 4 && zCircle >= 0 && zCircle < 5) {
      return getLine(LEFT_S, Z_ORIENT, position, zCircle);
    }
  }
  return null;
}

void drawLineBottomZ(int position, int zCircle, color c) {
  Line l = getLineBottomZ(position, zCircle);
  if (l != null) l.display(c);
}


Line getLineBottomZ(int position, int zCircle) {
  if (lines.size() > 0) {
    if (position  >= 0 && position < 4 && zCircle >= 0 && zCircle < 5) {
      return getLine(BOTTOM_S, Z_ORIENT, position, zCircle);
    }
  }
  return null;
}

void drawLineTopZ(int position, int zCircle, color c) {
  Line l = getLineTopZ(position, zCircle);
  if (l != null) l.display(c);
}

Line getLineTopZ(int position, int zCircle) {
  if (lines.size() > 0) {
    if (position  >= 0 && position < 4 && zCircle >= 0 && zCircle < 5) {
      return getLine(TOP_S, Z_ORIENT, position, zCircle);
    }
  }
  return null;
}

void drawLineRightY(int position, int zCircle, color c) {
  Line l = getLineRightY(position, zCircle);
  if (l != null) l.display(c);
}

Line getLineRightY(int position, int zCircle) {
  if (lines.size() > 0) {
    if (position  >= 0 && position < 3 && zCircle >= 0 && zCircle < 6) {
      return getLine(RIGHT_S, Y_ORIENT, position, zCircle);
    }
  }
  return null;
}

void drawLineLeftY(int position, int zCircle, color c) {
  Line l = getLineLeftY(position, zCircle);
  if (l != null) l.display(c);
}


Line getLineLeftY(int position, int zCircle) {
  if (lines.size() > 0) {
    if (position  >= 0 && position < 3 && zCircle >= 0 && zCircle < 6) {
      return getLine(LEFT_S, Y_ORIENT, position, zCircle);
    }
  }
  return null;
}

void drawLineBottomX(int position, int zCircle, color c) {
  Line l = getLineBottomX(position, zCircle);
  if (l != null) l.display(c);
}


Line getLineBottomX(int position, int zCircle) {
  if (lines.size() > 0) {
    if (position  >= 0 && position < 3 && zCircle >= 0 && zCircle < 6) {
      return getLine(BOTTOM_S, X_ORIENT, position, zCircle);
    }
  }
  return null;
}

void drawLineTopX(int position, int zCircle, color c) {
  Line l = getLineTopX(position, zCircle);
  if (l != null) l.display(c);
}


Line getLineTopX(int position, int zCircle) {
  if (lines.size() > 0) {
    if (position  >= 0 && position < 3 && zCircle >= 0 && zCircle < 6) {
      return getLine(TOP_S, X_ORIENT, position, zCircle);
    }
  }
  return null;
}


void drawLineBackY(int position, int zCircle, color c) {
  Line l = getLineBackY(position, zCircle);
  if (l != null) l.display(c);
}


Line getLineBackY(int position, int zCircle) {
  if (lines.size() > 0) {
    if (position  >= 0 && position < 4 && zCircle >= 0 && zCircle < 3) {
      return getLine(BACK_S, Y_ORIENT, position, zCircle);
    }
  }
  return null;
}


void drawLineBackX(int position, int zCircle, color c) {
  Line l = getLineBackX(position, zCircle);
  if (l != null) l.display(c);
}

Line getLineBackX(int position, int zCircle) {
  if (lines.size() > 0) {
    if (position  >= 0 && position < 3 && zCircle >= 0 && zCircle < 4) {
      return getLine(BACK_S, X_ORIENT, position, zCircle);
    }
  }
  return null;
}



Line getLine(int side, int orient, int position, int zCircle) {
  int start = 0;
  int index = 0;
  if (side == TOP_S) {
    start = 0;
    if (orient == Z_ORIENT) {
      if (position == 0) {
        return getLine(LEFT_S, Z_ORIENT, 3, zCircle);
      }
      index = start + ((zCircle) + position* (numRectZ-1))*2 + 1;
      if (side == TOP_S) {
        index = start + ((zCircle) + (position-1) * (numRectZ-1))*2 + 1;
        return lines.get(index);
      }
    } else if (orient == X_ORIENT) {
      if (zCircle == 0) {
        return lines.get(lines.size()-12 + position);
      } else {

        index = start + ((zCircle-1) + (position)* (numRectZ-1))*2;
        return lines.get(index);
      }
    }
  } else if (side == BOTTOM_S) {
    start = (numLinesX+1) * (numRectZ);
    if (orient == Z_ORIENT) {
      if (position == 3) {
        return getLine(RIGHT_S, Z_ORIENT, 0, zCircle);
      }
      index = start + ((zCircle) + position* (numRectZ-1))*2 + 1;
      return lines.get(index);
    } else if (orient == X_ORIENT) {
      if (zCircle == 0) {
        return lines.get(lines.size()-9 + position);
      } else {

        index = start + ((zCircle-1) + (position)* (numRectZ-1))*2;
        return lines.get(index);
      }
    }
  } else if (side == LEFT_S) {
    start = (numLinesX+1) * (numRectZ)*2;

    if (orient == Y_ORIENT) {
      if (zCircle == 0) {
        return lines.get(lines.size()-6 + 2-position);
      }
      index = start +  ((zCircle-1) * (numLinesX-1) +(2-position))*2; // FIX
      return lines.get(index);
    } else if (orient == Z_ORIENT) {
      if (position == 0) {
        return getLine(BOTTOM_S, Z_ORIENT, 0, zCircle);
      }
      index = start +  ((zCircle) *(numLinesY-1) + 2-(position-1))*2 + 1;
      return lines.get(index);
    }
  } else if (side == RIGHT_S) {
    start = (numLinesX+1) * (numRectZ)*3;
    if (orient == Y_ORIENT) {
      if (zCircle == 0) {
        return lines.get(lines.size()-3 + 2-position);
      }
      index = start +  ((zCircle-1) * (numLinesX-1) +(2-position))*2;
      return lines.get(index);
    } else if (orient == Z_ORIENT) {
      if (position == 3) {
        return getLine(TOP_S, Z_ORIENT, 3, zCircle);
      }
      index = start +  ((zCircle) * (numLinesX-1) +(2-position))*2+1;
      return lines.get(index);
    }
  } else if (side == BACK_S) {
    start = (numLinesX+1) * (numRectZ)*4;
    if (orient == Y_ORIENT) {
      if (position == 0) {
        // ?
        return getLine(LEFT_S, Y_ORIENT, zCircle, 5);
        
      }
      else if (position == 3) {
        return getLine(RIGHT_S, Y_ORIENT, zCircle, 5);
      }
      index = start +  ((2-zCircle) + (numLinesY-1) *(position-1))*2;
      return lines.get(index);
    } else if (orient == X_ORIENT) {
      if (zCircle == 3) {
        return getLine(TOP_S, X_ORIENT, position, 5);
      }
      else if (zCircle == 0) return getLine(BOTTOM_S, X_ORIENT, position, 5);
      index = start +  ((2-zCircle) + (numLinesY-1) *(position))*2+1;
      //index = start +  ((2-zCircle) + (2) *(position))*2+1;
      return lines.get(index);
    }
  }

  return null;
}
