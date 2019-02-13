class Shape {

  ArrayList<PVector>pts;
  color c;
  int num;

  Shape(int num) {
    pts = new ArrayList<PVector>();
    c = color(random(255), 255, 255);
    this.num = num;
  }

  void display(PGraphics s) {
    s.beginShape();
    for (int i = 0; i < pts.size(); i++) {
      s.vertex(pts.get(i).x, pts.get(i).y);
    }
    s.endShape(CLOSE);

    s.fill(255);
  }

  void displayPerfect(int sw, PGraphics s) {
    s.stroke(255);
    s.strokeWeight(sw);
    s.beginShape();
    for (int i = 0; i < pts.size(); i++) {
      s.vertex(pts.get(i).x, pts.get(i).y);
    }
    s.endShape(CLOSE);

    s.fill(255);
  }

  void drawMoveable(PGraphics s) {
    for (PVector pt : pts) {
      s.pushMatrix();
      s.translate(pt.x, pt.y, pt.z);
      s.sphere(5);
      s.popMatrix();
    }
  }

  void sidesToRects(int s, PGraphics g) {
    // top
    g.beginShape();
    g.vertex(pts.get(0).x-s/2, pts.get(0).y-s/2);
    g.vertex(pts.get(1).x+s/2, pts.get(1).y-s/2);
    g.vertex(pts.get(1).x+s/2, pts.get(1).y+s/2);
    g.vertex(pts.get(0).x-s/2, pts.get(0).y+s/2);
    g.endShape(CLOSE);

    // right
    g.beginShape();
    g.vertex(pts.get(1).x-s/2, pts.get(1).y-s/2);
    g.vertex(pts.get(1).x+s/2, pts.get(1).y-s/2);
    g.vertex(pts.get(2).x+s/2, pts.get(2).y+s/2);
    g.vertex(pts.get(2).x-s/2, pts.get(2).y+s/2);
    g.endShape(CLOSE);

    // left
    g.beginShape();
    g.vertex(pts.get(0).x-s/2, pts.get(0).y-s/2);
    g.vertex(pts.get(0).x+s/2, pts.get(0).y-s/2);
    g.vertex(pts.get(3).x+s/2, pts.get(3).y+s/2);
    g.vertex(pts.get(3).x-s/2, pts.get(3).y+s/2);
    g.endShape(CLOSE);

    // bottom
    g.beginShape();
    g.vertex(pts.get(3).x-s/2, pts.get(3).y-s/2);
    g.vertex(pts.get(2).x+s/2, pts.get(2).y-s/2);
    g.vertex(pts.get(2).x+s/2, pts.get(2).y+s/2);
    g.vertex(pts.get(3).x-s/2, pts.get(3).y+s/2);
    g.endShape(CLOSE);
  }

  void saveShape() {
    processing.data.JSONObject json2;
    json2 = new processing.data.JSONObject();

    json2.setInt("num", num);

    // adjacent node names
    processing.data.JSONArray ptsArray = new processing.data.JSONArray();      
    for (int j = 0; j < pts.size(); j+=3) 
    {
      ptsArray.setFloat(j, pts.get(j).x);
      ptsArray.setFloat(j+1, pts.get(j).y);
      ptsArray.setFloat(j+2, pts.get(j).z);
    }
    json2.setJSONArray("ptsArray", ptsArray);
    saveJSONObject(json2, "data/shapes/shape_" + num + ".json");
  }

  void addPoint() {
    pts.add(new PVector(mouseX, mouseY));
  }

  void addPoint(PVector p) {
    pts.add(p);
  }
}
