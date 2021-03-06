
import KinectPV2.KJoint;
import KinectPV2.*;  // Thomas Sanchez Lengeling http://codigogenerativo.com/
KinectPV2 kinect;


float elbowLAngle = 0;
float elbowRAngle = 0;
float handRAngle = 0;
float handLAngle = 0;
float kneeLAngle = 0;
float kneeRAngle = 0;
float footLAngle = 0;
float footRAngle = 0;
float spineAngle = 0;
float handRZ = 0;
float handRY = 0;
float handRX = 0;
float handRDZ = 0;
float handRDY = 0;
float handLDY = 0;
float handRDX = 0;
float handLDX = 0;

boolean currentlyTracked = false;

//void drawConstellationFirst() {
//  if (graphL.nodes.size() > 20) {
//    stroke(255, 0, 0);
//    fill(255, 0, 0);
//    ArrayList<Node> bodyNodes = new ArrayList<Node>(); 

//    for (int j = 0; j < 5; j++) {
//      if (j == 0) bodyNodes = graphL.getConstellationPath(11, bodyPoints[0].next);
//      else {
//        if (bodyNodes.size() > 0) bodyNodes = graphL.getConstellationPath(bodyNodes.get(bodyNodes.size()-1), bodyPoints[j].next);
//      }
//      for (int i = 0; i < bodyNodes.size()-1; i++) {
//        line(bodyNodes.get(i).getX(), bodyNodes.get(i).getY(), bodyNodes.get(i+1).getX(), bodyNodes.get(i+1).getY());
//      }
//    }
//  }
//}





void setBodyAngles(KJoint[] joints) {
  elbowLAngle = getJointAngle(joints[KinectPV2.JointType_ElbowLeft], joints[ KinectPV2.JointType_ShoulderLeft]);

  elbowRAngle = getJointAngle(joints[KinectPV2.JointType_ElbowRight], joints[ KinectPV2.JointType_ShoulderRight]);

  handRAngle = getJointAngle(joints[KinectPV2.JointType_ElbowRight], joints[ KinectPV2.JointType_WristRight]);
  handLAngle = getJointAngle(joints[KinectPV2.JointType_ElbowLeft], joints[ KinectPV2.JointType_WristLeft]);
  kneeLAngle = getJointAngle(joints[KinectPV2.JointType_HipLeft], joints[ KinectPV2.JointType_KneeLeft]);
  kneeRAngle = getJointAngle(joints[KinectPV2.JointType_HipRight], joints[ KinectPV2.JointType_KneeRight]);
  footLAngle = getJointAngle(joints[KinectPV2.JointType_KneeLeft], joints[ KinectPV2.JointType_AnkleLeft]);
  footRAngle = getJointAngle(joints[KinectPV2.JointType_KneeRight], joints[ KinectPV2.JointType_AnkleRight]);
  spineAngle = getJointAngle(joints[KinectPV2.JointType_SpineMid], joints[ KinectPV2.JointType_SpineShoulder]);

  //handRZ = joints[KinectPV2.JointType_ShoulderRight].getZ() - joints[KinectPV2.JointType_WristRight].getZ();
  handRX = joints[KinectPV2.JointType_WristRight].getX();
  handRY = joints[KinectPV2.JointType_WristRight].getY();

  // shoulder is farther back than wrist, so shoulder minus wrist positive; so handRDZ will be positive and bigger when reaching forward
  handRDZ = joints[KinectPV2.JointType_ShoulderRight].getZ() - joints[KinectPV2.JointType_WristRight].getZ();
  handRDX = joints[KinectPV2.JointType_WristRight].getX() - joints[KinectPV2.JointType_ShoulderRight].getX();
  handLDX = joints[KinectPV2.JointType_WristLeft].getX() - joints[KinectPV2.JointType_ShoulderLeft].getX();
  handRDY = joints[KinectPV2.JointType_WristRight].getY() - joints[KinectPV2.JointType_ShoulderRight].getY();
  handLDY = joints[KinectPV2.JointType_WristLeft].getY() - joints[KinectPV2.JointType_ShoulderLeft].getY();
  //println(joints[KinectPV2.JointType_ShoulderRight].getZ() + " " + handRZ);
}

void drawKinect() {
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeleton3d();
  //individual joints
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    //if the skeleton is being tracked compute the skleton joints
    if (skeleton.isTracked()) {
      currentlyTracked = true;

      KJoint[] joints = skeleton.getJoints();
      color col  = skeleton.getIndexColor();
      //setBody(joints);
      setBodyAngles(joints);

      playKinectModes(col);

      return;
    }
  }
  currentlyTracked = false;
}

//--------------------------------------------------------------
void initKinect() {
  kinect = new KinectPV2(this);
  //enable 3d  with (x,y,z) position
  kinect.enableSkeleton3DMap(true);
  kinect.init();
}

//--------------------------------------------------------------

void testKinect() {

  noFill();
  stroke(255);
  strokeWeight(4);
  rect(0, height/2, 255+100, 100);
  noStroke();
  fill(0, 255, getHandPanelY());
  rect(int(getHandPanelY()), height/2, 100, 100);
}

float getJointAngle(KJoint j1, KJoint j2) {
  return atan2((j1.getY() - j2.getY()), (j1.getX() - j2.getX()));
}

byte getHandPanelZ() {
  //println(handRZ);
  int z = constrain(int(map(handRZ, -.25, 0.7, 0, 255)), 0, 254);
  return byte(z);
}

byte getHandPanelX() {
  int x = constrain(int(map(handRX, -1.0, 1.0, 0, 255)), 0, 255);
  return byte(x);
}

PVector getHandMapped() {
  float x = map(handRX, -2.0, 2.0, 0, width);
  float y = map(handRY, -2.0, 2.0, height, 0);
  PVector h = new PVector(x, y);
  return h;
}

byte getHandPanelY() {
  int y = constrain(int(map(handRY, -1.0, 1.0, 0, 255)), 0, 255);
  return byte(y);
}
