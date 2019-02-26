/////////////////////
// VISUAL MODES
int V_NONE, 
  V_PULSING, 
  V_ROTATE_ANGLE_COUNT, 
  V_ROTATE_ANGLE, 
  V_PULSE_LINE_BACK, 
  V_PULSE_LINE_RIGHT, 
  V_PULSE_LINE_LEFT, 
  V_PULSE_LINE_UP, 
  V_PULSE_LINE_DOWN, 
  V_CYCLE_CONST, 
  V_SHOW_ONE, 
  V_ROTATE_ANGLE_BEATS, 
  V_PULSING_ON_LINE, 
  V_SEGMENT_SHIFT, 
  V_FADE, 
  V_DISPLAY, 
  V_TRANSIT;

/////////////////////
// KINECT MODES
int K_NONE = -1;
int K_AIR_Z = 0;
int K_TRANSIT_X = 1;
int K_AIR_BRIGHT = 2;
int K_AIR_LINE = 3;
int K_SPOTLIGHT = 4;
int K_CONSTELLATION = 5;
int K_PAINT = 6;
int kinectHues[] = { 0, 50, 100, 150, 200, 250 };

///////////////////////
// OTHER VARIABLES
int pulseIndex = 0;
int lastCheckedPulse = 0;
int pointDirection = 4;
int seesawVals[] = {0, 0};
boolean pulsingForward = false;

void initModes() {
  int temp = -1;
  V_NONE = temp++; 
  V_PULSING = temp++; 
  V_ROTATE_ANGLE_COUNT = temp++;
  V_ROTATE_ANGLE = temp++; 
  V_PULSE_LINE_BACK = temp++;
  V_PULSE_LINE_RIGHT = temp++;
  V_PULSE_LINE_LEFT = temp++;
  V_PULSE_LINE_UP = temp++;
  V_PULSE_LINE_DOWN = temp++;
  V_CYCLE_CONST = temp++; 
  V_SHOW_ONE = temp++; 
  V_ROTATE_ANGLE_BEATS = temp++; 
  V_PULSING_ON_LINE = temp++; 
  V_SEGMENT_SHIFT = temp++; 
  V_FADE = temp++;
  V_TRANSIT = temp++;
  V_DISPLAY = temp++;
}
void playMode() {
  visualMode = V_PULSING_ON_LINE;
  //if (visualMode == V_ROTATE_ANGLE_COUNT) rotateAngleCounter(100, 20);   // could be fixed
  //else 
  if (visualMode == V_PULSE_LINE_BACK) pulseLineForBack(600); //pulseLineBack(200); // either do just one ring, or do two rings and laterals in between
  else if (visualMode == V_PULSE_LINE_RIGHT) pulseLineRight(90, 80); // just do vertical lines or cubes around
  else if (visualMode == V_PULSE_LINE_LEFT)  pulseLineLeft(90, 80);
  else if (visualMode == V_PULSE_LINE_UP) pulseLineUp(90, 80);
  else if (visualMode == V_PULSE_LINE_DOWN) pulseLineDown(90, 80);

  else if (visualMode == V_PULSING) pulsing(3);
  //else if (visualMode == V_SHOW_ONE) showOne(500);
  else if (visualMode == V_PULSING_ON_LINE) pulseLinesCenter(1);
  //else if (visualMode == V_SEGMENT_SHIFT) segmentShift(10);  // transit but now looks bad
  else if (visualMode == V_TRANSIT) transit(30);
  else if (visualMode == V_DISPLAY) displayLines(strokeVizWeight, 255);
}

//////////////////////////////////////////////////////////////////
void handLight(float x, float y, int rad, color c) {
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).handLight(x, y, rad, c);
  }
}
void transit(int rate) {

  if (millis() - lastCheckedPulse > rate) {
    pulseIndex++;
    if (pulseIndex > 100) pulseIndex = 0;
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displaySegment(pulseIndex / 100.0, .2);
  }
}

void transitHand(float per, color c) {
  stroke(c);
  per = constrain(per, 0, 1.0);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displaySegment(per, .2);
  }
}



void rainbow() {
  pulseIndex++;
  if (pulseIndex > 255) pulseIndex = 0;
  colorMode(HSB, 255);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).display(color(pulseIndex, 255, 255));
  }
  colorMode(RGB, 255);
}

void segmentShift(int jump) {

  pulseIndex++;
  if (pulseIndex > 100) pulseIndex = 0;

  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displaySegment(pulseIndex / 100.0, .5);
  }
}

void rotateAngle(int rate, int angleGap) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex+= angleGap;
    if (pulseIndex > -70 ) {
      pulseIndex = -280;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayAngle(pulseIndex, pulseIndex+angleGap, color(255));
  }
}



void displayLines(int sw, color c) {
  strokeWeight(sw);
  for (int i = 0; i < lines.size(); i++) {
    stroke(c);
    fill(c);
    lines.get(i).display(c);
  }
}

void displayLines(int sw) {
  strokeWeight(sw);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).display();
  }
}

void displayLines() {
  strokeWeight(strokeVizWeight);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).display();
  }
}

void wipeRight(int amt, int w) {
  stroke(255);
  displayLines();
  fill(0);
  noStroke();
  pulseIndex += amt;
  if (pulseIndex > width) pulseIndex = 0;
  rect(pulseIndex, 0, w, height);
}

void rotateAngleCounter(int rate, int angleGap) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex-= angleGap;
    if (pulseIndex < -280 ) {
      pulseIndex = -70;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayAngle(pulseIndex, pulseIndex+angleGap, color(255));
  }
}

void displayYPoints(int y, color c) {
  fill(c);
  stroke(c);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPointY(y);
  }
}

void displayXPoints(int x, color c) {
  fill(c);
  stroke(c);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPointX(x);
  }
}

void displayYPoints(int rate, int bottom, int top) {
  pulseIndex += pointDirection * rate;
  if (pulseIndex > top) {
    pulseIndex = top;
    pointDirection = -1;
  } else if (pulseIndex < bottom) {
    pulseIndex = bottom;
    pointDirection = 1;
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPointY(pulseIndex);
  }
}

void displayXPoints(int rate, int left, int right) {
  pulseIndex += pointDirection * rate;
  if (pulseIndex > right) {
    pulseIndex = right;
    pointDirection = -1;
  } else if (pulseIndex < left) {
    pulseIndex = left;
    pointDirection = 1;
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPointX(pulseIndex);
    lines.get(i).displayPointX(pulseIndex+100);
  }
}

void randomLines(int rate) {
  if (millis() - lastCheckedPulse > rate) {
    background(0);
    lastCheckedPulse = millis();
    for (int i = 0; i < 20; i++) {
      line(random(50, width - 100), random(50, height - 100), random(50, width - 100), random(50, height - 100));
    }
  }
}


void pulseLinesCenter(int rate) {
  pulseIndex += pointDirection * rate;
  if (pulseIndex > 100) {
    pulseIndex = 100;
    pointDirection = -1;
  } else if (pulseIndex < 0) {
    pulseIndex = 0;
    pointDirection = 1;
  }
  float per = pulseIndex / 100.0;
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayCenterPulse(per);
  }
}


void pulseLineRight(int rate, int bandSize) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex+= bandSize;
    if (pulseIndex > width) {
      pulseIndex = -bandSize;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayBandX(pulseIndex, pulseIndex+bandSize);
  }
}

void pulseLineLeft(int rate, int bandSize) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex-=bandSize;
    if (pulseIndex < -bandSize) {
      pulseIndex = width;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayBandX(pulseIndex, pulseIndex+bandSize);
  }
}

void pulseLineUp(int rate, int bandSize) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex-=bandSize;
    if (pulseIndex < -bandSize) {
      pulseIndex = height;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayBandY(pulseIndex, pulseIndex+bandSize, color(255));
  }
}


void pulseLineDown(int rate, int bandSize) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex+=bandSize;
    if (pulseIndex > height) {
      pulseIndex = -bandSize;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayBandY(pulseIndex, pulseIndex+bandSize, color(255));
  }
}

void pulseLineBack(int rate) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex++;
    if (pulseIndex > 8) {
      pulseIndex = -1;
    }
    lastCheckedPulse = millis();
  }
  drawCircle(pulseIndex, color(255));
  drawCircle((pulseIndex-1), color(155));
  drawCircle((pulseIndex-2), color(55));
  //drawCubeRing(pulseIndex,color(255));
}

void pulseLineForward(int rate) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex--;
    if (pulseIndex < -1) {
      pulseIndex = 0;
    }
    lastCheckedPulse = millis();
  }
  drawCircle(pulseIndex, color(255));
  drawCircle((pulseIndex+1), color(155));
  drawCircle((pulseIndex+2), color(55));
  //drawCubeRing(pulseIndex,color(255));
}

void pulseLineForBack(int rate) {
  //lightY = 100;
  float per = map(constrain(lastCheckedPulse, 0, rate), 0, rate, 0, 1);
  lightZ = int(map(pulseIndex+per, 0, 5, -100, -1000));
  if (millis() - lastCheckedPulse > rate) {
    lastCheckedPulse = millis();
    if (pulsingForward) {
      pulseIndex--;
      if (pulseIndex < 1) {
        pulsingForward = false;
      }
    } else {
      pulseIndex++;
      if (pulseIndex > 4) {
        pulsingForward = true;
      }
    }
  }
  drawCircle(pulseIndex, color(255));
}


void showOne(int rate) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex++;
    lastCheckedPulse = millis();
  }
  if (lines.size() > 0) {
    for (int i = 0; i < 15; i++) {
      int ind = (pulseIndex + 10*i)%lines.size();
      lines.get(ind).display(255);
    }
  }
}

void pulsing(int rate) {
  pulseIndex += rate;
  pulseIndex %= 510;
  int b = pulseIndex;
  if (pulseIndex > 255) b = int(map(pulseIndex, 255, 510, 255, 0));
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).display(b);
  }
}


void linePercentW(int per) {
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPercentWid(per);
  }
}



void cycleModes(int rate) {
  if (millis() - stringChecked > rate) {
    visualMode = int(random(1, 11));
    stringChecked = millis();
  }
  playMode();
}



///////////////////////////////////////////////////////////////////////////////////////////
// KINECT MODES


void playKinectModes(color c) {
  if (kinectMode == K_SPOTLIGHT) drawSpotlightLR(50, c);
  else if (kinectMode == K_AIR_Z) airBenderZ(c);
  else if (kinectMode == K_TRANSIT_X) airBenderX(c);
  else if (kinectMode == K_AIR_BRIGHT) brightnessAirBenderY(c);
  else if (kinectMode == K_AIR_LINE) linesXY(c);
  else if (kinectMode == K_PAINT) paint(50, c);
}


void airBenderZ(color c) {
  int band = constrain(int(map(handRDZ, -0.5, 0.5, 6, -1)), 0, 5);
  int start = lines.size() / 6 * band;
  int end = lines.size() / 6 * (band + 1);
  if (end > lines.size()) end = lines.size();
  for (int i = start; i < lines.size(); i++) {
    // assumes lines are sorted closest to farthest
    // we draw closest last (at end of lines)

    // if hand is positive and big when far back
    // so map inverse so that when hand is big, we draw first items in lines array (corresponding to farthest back items)
    if (i >= start && i < end) lines.get(i).display(c);
    //else lines.get(i).displayNone();
  }
}

void airBenderX(color c) {
  float x = map(handRDX, -2, 2, 0, 1);
  transitHand(x, c);
}

void brightnessAirBenderY(color c) {
  int brightR = constrain(int(map(handRDY, -.6, 0, 0, 255)), 0, 255);
  int brightL = constrain(int(map(handLDY, -.6, 0, 0, 255)), 0, 255);
  int bright = max(brightR, brightL);
  float hue = hue(c);
  colorMode(HSB, 255);
  displayLines(color(hue, 255, bright));
  colorMode(RGB, 255);
}

void linesXY(color c) {
  int r = constrain(int(map(handRDY, -.5, 0.3, height, 0)), 0, height);
  int l = constrain(int(map(handLDX, -.5, .7, 0, width)), 0, width);
  displayYPoints(r, c);
  displayXPoints(l, c);
}

void paint(int r, color c) {
  //pulseIndex += pointDirection * rate;
  //if(pulseIndex > 255) pointDirection = -1;
  //else if (pulseIndex < 50) pointDirection = 1;
  //stroke(pulseIndex);
  drawSpotlightLR(r, c);
}




void drawSpotlightLR(int rad, color c) {
  int y1 = constrain(int(map(handRDY, -.5, 0.3, height, 0)), 0, height);
  int x1 = constrain(int(map(handRDX, -.5, .7, 0, width)), 0, width);

  int y2 = constrain(int(map(handLDY, -.5, 0.3, height, 0)), 0, height);
  int x2 = constrain(int(map(handLDX, -.5, .7, 0, width)), 0, width);

  handLight(x1, y1, rad, c);
  handLight(x2, y2, rad, c);
}


// good
boolean checkHand(int range) {
  return (withinRange(degrees(handRAngle), 260, range) && withinRange(degrees(handLAngle), 180, range));
}


boolean withinRange(float actual, float ideal, float range) {
  actual = map(actual, -180, 180, 0, 360);
  if (ideal - range/2 < 0) {
    if (actual < ideal + range/2 || actual > ideal + 360 - range/2) return true;
    return false;
  } else if (ideal + range/2 > 360) {
    if (actual > ideal - range/2 || actual < ideal + range/2 - 360) return true;
    return false;
  } else {
    if (actual > ideal - range/2 && actual < ideal + range/2) return true;
    return false;
  }
}


//void airBenderZ() {
//  int band = constrain(int(map(handRZ, 0, 50, 0, 8)), 0, 8);

//  for (int i = 0; i < lines.size(); i++) {
//    lines.get(i).displayBandZ(band, color(255));
//  }
//}

// old?
void airBenderY() {
  float rhBrightness = 0;
  if (handRAngle > -90 && handRAngle < 90) {
    rhBrightness = map(handRAngle, -90, 90, 0, 255);
  } else if (handRAngle > 90) {
    rhBrightness = map(handRAngle, 90, 180, 255, 255/2.0);
  } else if (handRAngle < -90) {
    rhBrightness = map(handRAngle, -180, -90, 255/2.0, 0);
  }

  displayLines(int(rhBrightness));
}
