class Moving {

  boolean moving = false;
  ArrayList<PVector> movingPoints;
  PVector startPoint;
  PVector endPoint;
  
  Moving(Line l) {
    movingPoints = new ArrayList<PVector>();
    movingPoints.add(l.p1);
    movingPoints.add(l.p2);
    setEndPoints();
  }
  
  void addLine(Line l) {
    movingPoints.add(l.p1);
    movingPoints.add(l.p2);
    setEndPoints();
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

  void move(float x1, float y1, float x2, float y2) {
    PVector sp = new PVector(startPoint.x, startPoint.y);
    PVector ep = new PVector(endPoint.x, endPoint.y);

    for (int i = 0; i < movingPoints.size(); i++) {
      movingPoints.get(i).x = map(movingPoints.get(i).x, sp.x, ep.x, sp.x + x1, ep.x + x2);
      movingPoints.get(i).y = map(movingPoints.get(i).y, sp.y, ep.y, sp.y + y1, ep.y + y2);
    }
  }


}
