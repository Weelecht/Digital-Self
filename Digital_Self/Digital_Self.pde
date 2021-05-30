import KinectPV2.*;
import KinectPV2.KJoint;

KinectPV2 kinect;

ArrayList<Dot> dots;
int maxDots = 1000;

void setup() {
  size(1920, 1080, P3D);
  rectMode(CENTER);
  frameRate(60);
  colorMode(HSB);

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  dots = new ArrayList<Dot>();

  kinect.init();
}

void draw() {
  
 background(240, 30, 20);
  image(kinect.getColorImage(), 0, 0, width/4, height/4);

  ArrayList<KSkeleton> skeletonArray = kinect.getSkeletonColorMap();

  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();


      if (dots.size() < maxDots) {
        //maxMass, limitSpeed, setMag
        dots.add(new Dot(30, random(6, 9), random(0.3, 6)));
        //dots.add(new Dot(30, random(1, 3), random(0.05, 1)));
      }
      
      PVector handRight = new PVector(joints[KinectPV2.JointType_HandRight].getX(), joints[KinectPV2.JointType_HandRight].getY());
      PVector handLeft = new PVector(joints[KinectPV2.JointType_HandLeft].getX(), joints[KinectPV2.JointType_HandLeft].getY());
      PVector spineMid = new PVector(joints[KinectPV2.JointType_SpineMid].getX(), joints[KinectPV2.JointType_SpineMid].getY());
      
      
      for (Dot d : dots) {
        d.display(d.calcCol(spineMid),(d.calcBrightness(handLeft,handRight)));
        d.seek(handLeft);
        d.seek(handRight);
      }
    }
  }


  for (int i = 0; i < dots.size(); i++) {
    Dot d = dots.get(i);
    d.update();
    d.edges();
    
    if(d.isDead()) {
     dots.remove(i); 
    }
  }
 
}
