class Dot {

  PVector location;
  PVector acceleration;
  PVector velocity;
  PVector target;
  float maxSpeed;
  float maxForce;
  float mass;
  float lifeSpan = 255;
  int tailSize = floor(random(1, 10));
  float xOff = random(0.1);

  ArrayList<PVector> past;

  Dot(float tMass, float tMaxSpeed, float tMaxForce) {

    maxSpeed = tMaxSpeed;
    maxForce = tMaxForce;
    location = new PVector(random(width), random(height));
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    mass = random(8, tMass);

    past = new ArrayList<PVector>();
  }

  void display(float col, float brightness) {

    float noise = map(noise(xOff), 0, 1, 0, 100);
    //float noise2 = map(noise(xOff),0,1,0,255);
    float lifeSpanMapping  = map(lifeSpan, 255, 0, 0, 100);
    float fadeDist  = map(col, 0, 230, 100, 0);
    push();
    strokeWeight(mass/10);
    stroke(col + noise, 255, 255, lifeSpanMapping + fadeDist);
    point(location.x, location.y);
    pop();

    for (int i = 0; i < past.size(); i++) {
      PVector current = past.get(i);
      push();
      strokeWeight(mass/10 + i);
      stroke(col + noise, 255, 255, lifeSpanMapping + fadeDist);
      point(current.x, current.y);
      pop();
    }
  }

  void applyForce(PVector force) {

    PVector fMass = force.get();
    fMass.div(mass);
    acceleration.add(fMass);
  }

  PVector friction() {

    float c = 0.01;
    float normal = 1;
    float frictionMag = c * normal;

    PVector friction = velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(frictionMag);
    return friction;
  }


  void seek(PVector target) {

    PVector desired = PVector.sub(target, location);
    desired.setMag(maxSpeed);
    PVector steering = PVector.sub(desired, velocity);
    steering.limit(maxForce);

    applyForce(steering);
  }

  boolean isDead() {

    if (lifeSpan <= 0) {
      return true;
    } else {
      return false;
    }
  }

  void update() {

    PVector tail = new PVector(location.x, location.y);
    past.add(tail);

    if (past.size() > tailSize) {

      past.remove(0);
    }

    velocity.add(acceleration);
    location.add(velocity);

    lifeSpan -= 0.1;
    acceleration.mult(0);
    xOff += random(0.1);
  }

  void edges() {

    if (location.x > width || location.x < 0) {
      velocity.x *= -1;
    }
    if (location.y > height || location.y < 0) {
      velocity.y *= -1;
    }
  }

  float calcCol(PVector firstPoint) {
    float primaryColourMapping = map(dist(firstPoint.x, firstPoint.y, location.x, location.y), 0, width, 0, 230);
    return primaryColourMapping;
  }

  float calcBrightness(PVector left, PVector right) {
    float brightnessMapping = map(dist(left.x, left.y, right.x, right.y), 0, width, 255, 0);
    return brightnessMapping;
  }
}
