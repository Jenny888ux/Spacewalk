
boolean KINECT_ON = false;

import java.util.ArrayList;

///////////////////////////////////////
int strokeVizWeight = 3;

// MODES
int VISUALIZE = 0;
int ADD_NODES = 1;
int ADD_EDGES = 2;
int MOVE_NODES = 3;
int MOVE_LINES = 4;
int SET_LINEZ = 5;
int SET_CONST = 6;
int SET_NODES_Z = 7;
int DELETE_NODES = 8;
int MOVEABLE_LINES = 9;
int CALIBRATION = 10;
int SHOW_PERFECT = 11;
int mode = ADD_NODES;

int currentScene = -1;
int visualMode = -1;
int kinectMode = -1; 
long sendTime = 0;
///////////////////////////////////////

long stringChecked = 0;
ArrayList<Line> lines;
PVector offset;
PVector nodeOffset;
float sc = 1.0;
int lineIndex = 0;
int triggered = -1;
int triggeredTime = 0;
int currentString;

// grid and balls
int zSpacing, rectW, rectH, numLinesY, numLinesX, numRectZ;
ArrayList<Ball> balls;
ArrayList<Shape> shapes;
int TOP_S = 0;
int BOTTOM_S = 1;
int LEFT_S = 2;
int RIGHT_S = 3;
int BACK_S = 4;

long lastChecked = 0;
int visualIndex = 0;
int lastCheckedMode = 0;
color c1, c2;
color [] zColors;
float huePosition = 0;
int counter = 0;

void setup() {
  fullScreen(P3D);
  //size(800, 600, P3D);

  lines = new ArrayList<Line>();
  shapes = new ArrayList<Shape>();
  nodes = new ArrayList<Node>();

  initScreens();
  initModes();
  initGrid(screen);
  setRects();

  colorMode(HSB, 255);

  zColors = new color[6];
  setRandomColors();
  //setColors();
}


//--------------------------------------------------------------
void draw() {
  background(0);

  if (mode == VISUALIZE) 
    visualize(screen);
  else {
    visualizeSetting(screen);
    settingFunctions();
  }
}


void visualizeSetting(PGraphics g) {
  screen.beginDraw();
  screen.background(0);
  screen.pointLight(205, 205, 205, g.width/2, g.height/2, -100);
  screen.pushMatrix();
  screen.translate(g.width/2, g.height/2, 170);
  setGradientZs();
  //setColors();
  if (mode != SHOW_PERFECT) displayShapes(screen);
  else displayPerfectLines(3, screen);
  screen.popMatrix();

  screen.stroke(255);
  screen.fill(255);
  screen.strokeWeight(strokeVizWeight);

  screen.endDraw();

  renderScreens();
}

void visualize(PGraphics g) {

  noCursor();
  screen.beginDraw();
  screen.background(0);
  screen.pointLight(205, 205, 205, mouseX, mouseY, -100);
  screen.pushMatrix();
  screen.translate(g.width/2, g.height/2, 150);
  //setRainbowPulse(20);
  setGradientZs();
  displayShapes(screen);
  screen.popMatrix();

  screen.stroke(255);
  screen.fill(255);
  screen.strokeWeight(strokeVizWeight);
  strokeWeight(strokeVizWeight);
  changeMode();
  playMode();
  screen.endDraw();

  renderScreens();
}
void changeMode() {
  if (millis() - lastCheckedMode > 8000) {
    if (int(random(2)) == 0) visualMode = V_DISPLAY;
    else visualMode = int(random(15));
    lastCheckedMode = millis();
  }
}

//--------------------------------------------------------------
void keyPressed() {
  if (key == 's') {
    saveShapes();
    saveLines();
    saveKeystone();
  } else if (key == 'r') loadLines();
  else if (key == 'a') mode = ADD_NODES;
  else if (key == 'e') mode = ADD_EDGES;
  else if (key == 'm') mode = MOVE_LINES;
  else if (key == 't') mode = MOVEABLE_LINES;
  else if (key == 'n') mode = MOVE_NODES;
  else if (key == 'd') mode = DELETE_NODES;
  else if (key == 'z') mode = SET_LINEZ;
  else if (key == 'p') mode = SHOW_PERFECT;
  else if (key == 'c') {
    mode = CALIBRATION;
    toggleCalibration();
  }
  else if (key == 'g') mode = SET_CONST;
  else if (key == 'v') mode = VISUALIZE;
  else if (key == 'x') printLineLength();
  else if (mode == MOVE_LINES) {
    if (lineIndex >= 0) {
      Line l = lines.get(lineIndex);
      if (keyCode == UP) l.moveP1(0, -1);
      else if (keyCode == DOWN) l.moveP1(0, 1);
      else if (keyCode == RIGHT) l.moveP1(1, 0);
      else if (keyCode == LEFT) l.moveP1(-1, 0);
      else if (key == 'i') l.moveP2(0, -1);     
      else if (key == 'k') l.moveP2(0, 1);     
      else if (key == 'l') l.moveP2(1, 0);
      else if (key == 'j') l.moveP2(-1, 0);
    }
  } else if (mode == MOVE_NODES) {
    if (hasCurrentNode()) {
      if (keyCode == UP) moveCurrentNode(0, -1);
      else if (keyCode == DOWN) moveCurrentNode(0, 1);
      else if (keyCode == RIGHT) moveCurrentNode(1, 0);
      else if (keyCode == LEFT) moveCurrentNode(-1, 0);
    }
  } else if (mode == SET_LINEZ) {
    println(parseInt(key));
    int k = parseInt(key) - 48;
    if (k > 0 && k < 9) {
      lines.get(lineIndex).setZIndex(k);
    }
  } else if (mode == SET_NODES_Z) {
    if (hasCurrentNode()) {
      println(parseInt(key));
      int k = parseInt(key) - 48;
      if (k > 0 && k < 9) {
        setCurrentNodeZ(k);
      }
    }
  } else if (mode == SET_CONST) {
    int k = parseInt(key) - 48;
    if (k > 0 && k < 9) {
      lines.get(lineIndex).setConstellationG(k);
    }
  } else if (mode == VISUALIZE) {
  }
  return;
}

// get a string
// up, down, left, right -> p1
// i, k, j, l -> p2
boolean hasCurrentStringPoint() {
  return true;
}

//--------------------------------------------------------------
void keyReleased() {
}

//--------------------------------------------------------------
void mousePressed() {
}

//--------------------------------------------------------------
void mouseReleased() {
  if (mode == ADD_NODES) {
    displayLines();
    addNode(mouseX, mouseY);
  } else if (mode == MOVE_NODES) {
    displayNodes();
    checkNodeClick(mouseX, mouseY);
  } else if (mode == ADD_EDGES) {
    checkEdgeClick(mouseX, mouseY);
  } else if (mode == DELETE_NODES) {
    checkDeleteNodeClick(mouseX, mouseY);
  } else if (mode == SET_LINEZ || mode == SET_CONST || mode == MOVE_LINES) {
    for (int i = 0; i < lines.size(); i++) {
      if (lines.get(i).mouseOver()) {
        lineIndex = i;
        println("l index " + lineIndex);
        break;
      }
    }
  } else if (mode == SET_NODES_Z) {
    checkNodeClick(mouseX, mouseY);
    //updateLineZs();
  }
}

void setLines() {
  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);
    if (l.mouseOver()) {
      stroke(255);
      fill(255);
    } else if (i == lineIndex) {
      colorMode(RGB);
      stroke(0, 255, 255);
      fill(0, 255, 255);
    } else {
      colorMode(HSB);
      stroke(map(l.zIndex, 0, 9, 0, 255), 255, 255);
      fill(map(l.zIndex, 0, 9, 0, 255), 255, 255);
    }
    l.display();
  }
}



void setConst() {
  background(50);
  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);
    if (l.mouseOver()) {
      stroke(255);
      fill(255);
    } else if (i == lineIndex) {
      colorMode(RGB);
      stroke(0, 255, 255);
      fill(0, 255, 255);
    } else {
      colorMode(HSB);
      stroke(map(l.constellationG, 0, 9, 0, 255), 255, 255);
      fill(map(l.constellationG, 0, 9, 0, 255), 255, 255);
    }
    l.display();
  }
}

//void updateLineZs() {
//  for (int i = 0; i < lines.size(); i++) {
//    lines.get(i).updateZ();
//  }
//}

void displayLineZDepth() {
  for (Line line : lines) {
    line.displayZDepth();
  }
}

void deleteLines(int index) {
  for (int i = lines.size() - 1; i >=0; i--) {
    if (lines.get(i).findByID(index)) {
      lines.remove(i);
    }
  }
}

void displayBox(int hue, String title) {
  if (mouseY < height - 60) {
    colorMode(HSB, 255);
    fill(hue, 255, 255);
    noStroke();
    rect(0, height-50, width, 50);
    fill(255);
    stroke(255);
    textSize(30);
    text(title, 30, height-15);
    colorMode(RGB, 255);
  }
}

void settingFunctions() {
  displayNodes();
  displayNodeLabels();

  

  if (mode == ADD_EDGES) {
    drawLineToCurrent(mouseX, mouseY);
    displayBox(0, "ADD EDGES");
    displayLines(strokeVizWeight, 255);
  } else if (mode == ADD_NODES) {
    ellipse(mouseX, mouseY, 20, 20);
    displayBox(20, "ADD NODES");
    displayLines(strokeVizWeight, 255);
  } else if (mode == DELETE_NODES) {
    displayLines(strokeVizWeight, 255);
    displayBox(50, "DELETE NODES");
  } else if (mode == MOVE_NODES || mode == MOVE_LINES) {
    displayCurrentNode();
    displayBox(70, "MOVE");
    displayLines(strokeVizWeight, 255);
  } else if (mode == SET_NODES_Z) {
    displayLineZDepth();
    displayBox(100, "SET NODES Z");
    displayCurrentNode();
    displayLines(strokeVizWeight, 255);
  } else if (mode == SET_CONST) {
    setConst();
    displayBox(140, "SET CONSTELLATIONS");
    displayLines(strokeVizWeight, 255);
  } else if (mode == SET_LINEZ) {
    displayZIndexes();
    displayLines(strokeVizWeight, 255);
  } else if (mode == CALIBRATION) {
    displayBox(130, "CALIBRATING MAP");
    displayLines(strokeVizWeight, 255);
  } else if (mode == SHOW_PERFECT) {
    displayBox(140, "PERFECT LINES");
  }
}

void displayPerfectLines(int sw, PGraphics g) {
  for (Shape s : shapes) {
    ((MoveableShape)s).displayPerfect(sw, g);
  }
}

void displayZIndexes() {
  for (Line l : lines) {
    l.displayZIndex();
  }
}
boolean blackBackground() {
  if (kinectMode == K_PAINT) return false;
  return true;
}

void saveShapes() {
  processing.data.JSONObject json;
  json = new processing.data.JSONObject();
  json.setInt("num", shapes.size());
  saveJSONObject(json, "data/shapes/numShapes.json");
  for (Shape s : shapes) {
    s.saveShape();
  }
}

void loadShapes() {
  processing.data.JSONObject graphJson;
  graphJson = loadJSONObject("data/shapes/numShapes.json");
  int numShapes = graphJson.getInt("numShapes");
  //println(numShapes);

  shapes = new ArrayList<Shape>();
  for (int i = 0; i < numShapes; i++) {
    processing.data.JSONObject shape = loadJSONObject("data/shapes/shape_" + i + ".json");
    int num = shape.getInt("num");
    shapes.add(new Shape(num));
    processing.data.JSONArray ptsArray = shape.getJSONArray("ptsArray");
    for (int j = 0; j < ptsArray.size(); j+=3) {
      float x = ptsArray.getFloat(j);
      float y = ptsArray.getFloat(j+1);
      float z = ptsArray.getFloat(j+2);
      shapes.get(shapes.size() -1).addPoint(new PVector(x, y, z));
    }
  }
}

void displayShapes(PGraphics g) {
  for (Shape s : shapes) {
    s.display(g);
  }
}

void rainbowStrip() {
  colorMode(HSB, 255);
  if (millis() - lastChecked > 500) {
    lastChecked = millis();
    visualIndex++;
    visualIndex %= 7;
    println(visualIndex);
    for (Shape s : shapes) {
      if (((MoveableShape) s).zSide == visualIndex) {
        s.c = color(map(((MoveableShape) s).zSide, 0, 7, 0, 255), 255, 255);
      } else s.c = color(map(((MoveableShape) s).zSide, 0, 7, 0, 255), 55, 55);
    }
  }
}

void setColors() {
  colorMode(HSB, 255);

  float hueJump = .1;

  // happens every second?
  if (millis() - lastChecked > 500) {
    huePosition += hueJump;
    if (huePosition > 1) {
      huePosition = 0;
      setNextRandomColor();
    }
    zColors[0] = lerpColor(c1, c2, huePosition);
    for (int i = zColors.length-1; i > 0; i--) {
      zColors[i] = zColors[i-1];
    }
    lastChecked = millis();
  }

  // all the time
  for (Shape s : shapes) {
    s.c = zColors[5-((MoveableShape) s).zSide];
    //s.c = color((hue(c)+frameCount)%255, 255, 255);
  }
}

void setNextRandomColor() {
  colorMode(HSB, 255);
  c2 = c1;
  c1 = color(random(255), 255, 255);
  //if (abs(hue(c1) - hue(c2)) < 40) {
  //  c2 = color((hue(c2)+80)%255, 255, 255);
  //}
}

void setRandomColors() {
  colorMode(HSB, 255);

  c1 = color(getRandomNormalizedHue(), 255, 255);
  //c2 = color(getRandomNormalizedHue(), 255, 255);
  c2 = color((hue(c2)+80)%255, 255, 255);
  if (abs(hue(c1) - hue(c2)) < 40) {
    c2 = color((hue(c2)+80)%255, 255, 255);
  }
}

int getRandomNormalizedHue() {
  int randC = int(random(11));
  int h = 0;
  int [] colRanges = {0, 15, 30, 45, 60, 105, 125, 150, 185, 210, 235};
  if (randC == 0 || randC == 10) {
    return int(random(235, 255+15)-15);
  }
  return int(random(colRanges[randC], colRanges[randC+1]));
}

// returns true if hues are more different than diff
boolean areColorsDiff(color c1, color c2, int diff) {
  return abs(hue(c1)-hue(c2)) > diff;
}

void setGradientZs() {
  colorMode(HSB, 255);
  counter++;
  if (millis() - lastChecked > 15000) {
    //if (counter%255 == 127) {
    println(counter);
    setRandomColors();
    //setNextRandomColor();
    lastChecked = millis();
  }
  for (Shape s : shapes) {
    ((MoveableShape) s).setGradientZ(c1, c2, 30);
  }
}

void setRainbowPulse(int jump) {
  for (Shape s : shapes) {
    ((MoveableShape) s).setRainbow(jump);
  }
}
