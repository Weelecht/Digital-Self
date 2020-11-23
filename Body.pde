class Body {
  
  PVector handLeft;
  PVector handRight;
  PVector spineMid;
  
  
  Body(PVector tHandLeft, PVector tHandRight, PVector tSpineMid) {
    
    handLeft = new PVector(tHandLeft.x,tHandLeft.y);
    handRight = new PVector(tHandRight.x,tHandRight.y);
    spineMid = new PVector(tSpineMid.x,tSpineMid.y);
    
  }
  
  PVector getHandRight() {
    
   return handRight; 
    
  }
  
  PVector getHandLeft() {
    
   return handLeft; 
    
  }
  
  PVector getSpineMid() {
    
   return spineMid; 
    
  }
}
