
void initGrid(PGraphics g) {
  //g.rectMode(CENTER);
  float fov = PI/3.0;
  float cameraZ = (g.height/2.0) / tan(fov/2.0);
  g.perspective(fov, float(g.width)/float(g.height), cameraZ/20.0, -5000);

  numRectZ = 6;
  
  rectW = int(g.width);
  rectH = int(g.height);
  zSpacing = int(rectW*.4);
  
  //numLinesY = int(rectH*1.0/zSpacing);
  //numLinesX = int(rectW*1.0/zSpacing);
  numLinesY = 4;
  numLinesX = 4;

  balls = new ArrayList<Ball>();
  //balls.add(new Ball(200, 200, -300));
  //balls.add(new Ball(300, 200, -600));
  //balls.add(new Ball(200, 300, -500));
}


void setRects() {
  int i = 0;

  // topRects()
  for (int x = 0; x < numLinesX-1; x++) {
    for (int z = 0; z < numRectZ-1; z++) {
      float xsp = rectW * 1.0/(numLinesX -1);
       //MoveableShape(int i, int side, int xSide, int ySide, int zSide, float x, float y, float z, float w, float h, float rx, float ry, float rz) {
 
      shapes.add(new MoveableShape(i++, TOP_S, x, -1, z, xsp*x-rectW/2+xsp/2, -zSpacing/2-zSpacing*z, rectH/2, xsp, zSpacing, radians(90), 0, 0));
    }
  }
  
  // bottomRects
  for (int x = 0; x < numLinesX-1; x++) {
    for (int z = 0; z < numRectZ-1; z++) {
      float xsp = rectW * 1.0/(numLinesX -1);
      shapes.add(new MoveableShape(i++, BOTTOM_S, x, -1, z, xsp*x-rectW/2+xsp/2, -zSpacing/2-zSpacing*z, -rectH/2, xsp, zSpacing, radians(90), 0, 0));
    }
  }
  // leftRects
  for (int z = 0; z < numRectZ-1; z++) {
    for (int y = 0; y < numLinesY-1; y++) {
      float ysp = rectH * 1.0/(numLinesY -1);
      shapes.add(new MoveableShape(i++, LEFT_S, -1, y, z, zSpacing/2 + z*zSpacing, -rectH/2+ysp/2+y*ysp, -rectW/2, zSpacing, ysp, 0, radians(90), 0));
    }
  }
   // rightRects
  for (int z = 0; z < numRectZ-1; z++) {
    for (int y = 0; y < numLinesY-1; y++) {
      float ysp = rectH * 1.0/(numLinesY -1);
      shapes.add(new MoveableShape(i++, RIGHT_S, -1, y, z, zSpacing/2 + z*zSpacing, -rectH/2+ysp/2+y*ysp, rectW/2, zSpacing, ysp, 0, radians(90), 0));
    }
  }
  // backRects
  for (int x = 0; x < numLinesX -1; x++) {
    for (int y = 0; y < numLinesY-1; y++) {
      float ysp = rectH * 1.0/(numLinesY -1);
      float xsp = rectW * 1.0/(numLinesX -1);
      shapes.add(new MoveableShape(i++, BACK_S, x, y, numRectZ-1, xsp*x-rectW/2+xsp/2, -rectH/2+ysp/2+y*ysp, -zSpacing*(numRectZ-1), xsp, ysp, 0, 0, 0));
    }
  }
}

//void drawSideRects(PGraphics g) {
//  for (int z = 0; z < numRectZ-1; z++) {
//    for (int y = 0; y < numLinesY-1; y++) {
//      float ysp = rectH * 1.0/(numLinesY -1);
//      g.fill(10, 255, 255);

//      // left
//      g.pushMatrix();
//      g.rotateY(radians(90));
//      g.translate(zSpacing/2 + z*zSpacing, -rectH/2+ysp/2+y*ysp, -rectW/2);
//      g.rect(0, 0, zSpacing, ysp); 
//      g.popMatrix();

//      // right
//      g.pushMatrix();
//      g.rotateY(radians(90));
//      g.translate(zSpacing/2 + z*zSpacing, -rectH/2+ysp/2+y*ysp, rectW/2);
//      g.rect(0, 0, zSpacing, ysp); 
//      g.popMatrix();
//    }
//  }
//}
