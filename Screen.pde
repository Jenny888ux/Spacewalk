import deadpixel.keystone.*;  // to modify keystone lib and then make a jar file: jar cvf keystone.jar .

float scaleFactor = 1.4;
int screenW = int(1200*scaleFactor);
int screenH = int(800*scaleFactor);

PVector test1 = new PVector(0, 0);
PVector test2 = new PVector(100, 100);

Keystone ks;
int keystoneNum = 0;
CornerPinSurface surface;
PGraphics screen;
boolean isCalibrating = false;

void initScreens() {
  ks = new Keystone(this);

  surface = ks.createCornerPinSurface(screenW, screenH, 20);
  screen = createGraphics(screenW, screenH, P3D);

  //loadKeystone();
}


void saveKeystone() {
  ks.save("data/keystone/keystone.xml");
  println(ks.getSurface(0).getTransformedCursor(int(test1.x),int(test1.y)));
  //println(ks.getSurface(0).getTransformedCursor(100,100));
}

void loadKeystone() {
  ks.load("data/keystone/keystone.xml");
}

void renderScreens() {
  surface.render(screen);
}

void toggleCalibration() {
  isCalibrating = !isCalibrating;
  if (isCalibrating) ks.startCalibration();
    else ks.stopCalibration();
}
