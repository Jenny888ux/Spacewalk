import deadpixel.keystone.*;  // to modify keystone lib and then make a jar file: jar cvf keystone.jar .

int screenW = 1200;
int screenH = 800;

Keystone ks;
int keystoneNum = 0;
CornerPinSurface surface;
PGraphics screen;
boolean isCalibrating = false;

void initScreens() {
  ks = new Keystone(this);

  surface = ks.createCornerPinSurface(screenW, screenH, 20);
  screen = createGraphics(screenW, screenH, P3D);

  loadKeystone();
}


void saveKeystone() {
  ks.save("data/keystone/keystone.xml");
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
