class Moving {

  boolean moving = false;
  ArrayList<PVector> movingPoints;
  ArrayList<Float> movingRatios;
  PVector startPoint;
  PVector endPoint;

  Moving(Line l) {
    movingPoints = new ArrayList<PVector>();
    addLine(l);
  }

  void addLine(Line l) {
    movingPoints.add(l.p1);
    movingPoints.add(l.p2);
    setEndPoints();
    setRatios();
  }

  void setRatios() {
    movingRatios = new ArrayList<Float>();
    PVector sp = new PVector(startPoint.x, startPoint.y);
    PVector ep = new PVector(endPoint.x, endPoint.y);
    float totLen = dist(sp.x, sp.y, ep.x, ep.y);
    for (int i = 0; i < movingPoints.size(); i++) {
      float ratioStart = dist(movingPoints.get(i).x, movingPoints.get(i).y, sp.x, sp.y)/totLen;
      movingRatios.add(ratioStart);
    }
  }

  void setEndPoints() {
    if (movingPoints.size() == 0) {
      moving = false;
    } else {
      moving = true;

      // initialize variables
      startPoint = movingPoints.get(0);//new PVector(pts[0].x, pts[0].y);
      endPoint = movingPoints.get(1); //new PVector(pts[1].x, pts[1].y);

      // get the max distance points
      float dis = 0;
      for (int i = 0; i < movingPoints.size()-1; i++) {
        for (int j = i+1; j < movingPoints.size(); j++) {
          float d = dist(movingPoints.get(i).x, movingPoints.get(i).y, movingPoints.get(j).x, movingPoints.get(j).y);
          if (d > dis) {
            dis = d;
            startPoint = movingPoints.get(i);//new PVector(movingPoints.get(i).x, movingPoints.get(i).y);
            endPoint = movingPoints.get(j);//new PVector(movingPoints.get(j).x, movingPoints.get(j).y);
          }
        }
      }
      // startPoint on the left
      if (startPoint.x > endPoint.x) {
        PVector temp = startPoint;
        startPoint = endPoint;
        endPoint = temp;
      }
    }
  }



  void move(float dx2, float dy2, float dx1, float dy1) {
    PVector sp = new PVector(startPoint.x, startPoint.y);
    PVector ep = new PVector(endPoint.x, endPoint.y);
    for (int i = 0; i < movingPoints.size(); i++) {
      float ratioStart = movingRatios.get(i);
      movingPoints.get(i).x = lerp(sp.x + dx1, ep.x + dx2, ratioStart);
      movingPoints.get(i).y = lerp(sp.y + dy1, ep.y + dy2, ratioStart);
    }
  }

  void display() {
    colorMode(RGB, 255);
    fill(0, 255, 0);
    ellipse(startPoint.x, startPoint.y, 10, 10);
    fill(255, 0, 0);
    ellipse(endPoint.x, endPoint.y, 10, 10);
    colorMode(HSB, 255);
  }
}