import keystoneMap.*;

float aspectRatio = 3.0/2.0; // width to height
float scaleFactor = 0.9;
int screenW, screenH;

Keystone ks;
int keystoneNum = 0;
CornerPinSurface surface;
PGraphics screen;
boolean isCalibrating = false;

void initScreens() {
  float w, h;
  // check to see which dimension is the limiting dimension
  if (aspectRatio < (width*1.0/height)) {
    h = height*scaleFactor;
    w = aspectRatio * h;
  }
  else {
    w = width*scaleFactor;
    h = 1/aspectRatio * w;
  }
  println(w, h, width, height);
  int screenW = int(w);
  int screenH = int(h);
  
  ks = new Keystone(this);

  surface = ks.createQuadPinSurface(screenW, screenH, 20);
  screen = createGraphics(screenW, screenH, P3D);
}


void saveKeystone() {
  ks.save("data/keystone/keystone.xml");
  //PVector t = ks.getSurface(0).getTransformedCursor(int(test1.x),int(test1.y));
  //PVector t2 = ks.getSurface(0).TL;

  //println(ks.getSurface(0).mesh[0].x + " " + mouseX + " " + mouseY);
  //println(t );
}

void loadKeystone() {
  ks.load("data/keystone/keystone.xml");
}

void renderScreens() {
  pushMatrix();
  translate(0, 0, -1);
  surface.render(screen);
  popMatrix();
}

void toggleCalibration() {
  isCalibrating = !isCalibrating;
  if (isCalibrating) ks.startCalibration();
  else ks.stopCalibration();
}
