import controlP5.*;
class Miles{

    float miles = 0;
    
    String getStr(){
      String ret = "000";
      if(miles <10){
      ret = ret +"00" + int(miles);}
      else if(miles <100 && miles > 10){
      ret = ret +"0" + int(miles);}
      else{
      ret = ret + "" + int(miles);}
      return ret;
    }
}

class Coordinates{

    float x;
    float y;
    
    Coordinates(float a, float b){
      this.x = a;
      this.y = b;
    }
    
    void modifyXY(float a, float b){
      this.x = a;
      this.y = b;
    }
}

class Meter{
  
 
  
    int control = -1; 
    int centerX;
    int centerY;
    int radius;
    float angle;
    float radian;
    Coordinates tipVal;
        
    Meter(int cX, int cY, int r, float a){
      centerX = cX;
      centerY = cY;
      radius = r;
      angle = a;
      radian = angle * PI/180;
      tipVal = new Coordinates(centerX + radius*cos(radian), centerY + radius*sin(radian));
        
    }    
      
    void Gas(float a){
      
      
      if(f.angle >= 180){
        angle+=a; //0.5
        float radian = angle * PI/180;
        tipVal.modifyXY((centerX + radius*cos(radian)), (centerY + radius*sin(radian)));
        M.miles += 0.005;
        f.angle -= 0.1;
        f.radian = f.angle * PI/180;
        f.tipVal.modifyXY(f.centerX + f.radius*cos(f.radian), f.centerY + f.radius*sin(f.radian));
      }
      else{
        print("Fuel GONE!");
      }
    }
     
    void Glide(float a){
      angle-=a; //0.1
      float radian = angle * PI/180;
      tipVal.modifyXY((centerX + radius*cos(radian)), (centerY + radius*sin(radian)));
      M.miles += 0.0005;
    }
    
    void Brake(float a){
      angle-=a; //1
      float radian = angle * PI/180;
      tipVal.modifyXY((centerX + radius*cos(radian)), (centerY + radius*sin(radian)));
      M.miles += 0.0001;
    }
  
}


void keyReleased(){
    s.control = -1;
    t.control = -1;
}


void keyPressed(){
    
    if(key == 'w' && f.angle > 180){
      s.control = 0;
      t.control = 0;
    }
    else if(key == 's'){
      s.control = 1;
      t.control = 1;
    }
    else if(key == 'q'){
      warningIdx = 0;
    }
}

String getCurtime(){

  return (hour()-12) +":"+ (minute()) +":"+ (second());
}

void mousePressed(){

    print(mouseX, mouseY);
}

void gearUp(){
  if(drive_idx <4){
    drive_idx += 1;
  } 
}

void gearDown(){
  if(drive_idx > 0){
    drive_idx -=1;
  }
}

void iL(){
  if(indicator == 0){
  indicator = -1;}
  else {indicator = 0;}
}

void iR(){
  if(indicator == 0){
  indicator = 1;}
  else {indicator = 0;}
}

void hazardtoggle(){
  if(parkingLights == 0){
  parkingLights = 1;}
  else {parkingLights = 0;}
}

void fuelRefill(){
  f.angle = 250;
  f.radian = f.angle * PI/180;
  f.tipVal.modifyXY(f.centerX + f.radius*cos(f.radian), f.centerY + f.radius*sin(f.radian));
}

void displayWarnings(){
  warningIdx +=1;
}

void High(){
   if(beamIdx == 0){
  beamIdx = 1;}
  else {beamIdx = 0;}
  
}

void Low(){
  if(beamIdx == 0){
  beamIdx = -1;}
  else {beamIdx = 0;}
}

void Fog(){
  if(beamIdx == 0){
  beamIdx = 2;}
  else {beamIdx = 0;}
}

void cruizeControl(){
 if(cruize == 0 || cruize == -1){
  cruize = 1;}
  else {cruize = -1;}
}

void setup(){
    size(1334, 593);
    print(s.tipVal.x, s.tipVal.y);
    
    // Image loading
    bg = loadImage("./background.jpg");
    fuelwar = loadImage("./fuelwar.jpg");
    iL = loadImage("./LI.jpg");
    iR = loadImage("./RI.jpg");
    iLCopy = loadImage("./LICopy.jpg");
    iRCopy = loadImage("./RICopy.jpg");
    pL = loadImage("./pL.jpg");
    bL= loadImage("./bL.JPG");
    cC= loadImage("./cC.JPG");
    cE= loadImage("./cE.JPG");
    dO= loadImage("./dO.JPG");
    eT= loadImage("./eT.JPG");
    fL= loadImage("./fL.JPG");
    fogL= loadImage("./fogL.JPG");
    hB= loadImage("./hB.JPG");
    lB= loadImage("./lB.JPG");
    sB= loadImage("./sB.JPG");
    sC= loadImage("./sC.JPG");
    tP= loadImage("./tP.JPG");
    
    // Button loading
    gearUp = new ControlP5(this);
    gearUp.addButton("GearUP").setSize(80,50).setPosition(1230, 445).plugTo(this, "gearUp");
    gearDown = new ControlP5(this);
    gearDown.addButton("GearDown").setSize(80,50).setPosition(1230, 500).plugTo(this, "gearDown");
    
    indicatorLeft = new ControlP5(this);
    indicatorRight = new ControlP5(this);
    parkingL = new ControlP5(this);
    fuelRefill = new ControlP5(this);
    toggleWarnings = new ControlP5(this);
    cruizeC = new ControlP5(this);
    
    indicatorLeft.addButton("Indicator\nLeft").setSize(80,50).setPosition(1230, 335).plugTo(this, "iL");
    indicatorRight.addButton("Indicator\nRight").setSize(80,50).setPosition(1230, 390).plugTo(this, "iR");
    parkingL.addButton("Hazard\nLights").setSize(80,50).setPosition(1230, 280).plugTo(this, "hazardtoggle");
    fuelRefill.addButton("Refill\nFuel").setSize(80,50).setPosition(1230, 225).plugTo(this, "fuelRefill");
    toggleWarnings.addButton("Warnings").setSize(80,50).setPosition(1230, 170).plugTo(this, "displayWarnings");
    cruizeC.addButton("CruizeC").setSize(80,50).setPosition(1230, 100).plugTo(this, "cruizeControl");
    
    
    for(int i=0; i<3; i++){
      BeamBtns[i] = new ControlP5(this);
      String[] arr = {"High", "Low", "Fog"};
      BeamBtns[i].addButton(arr[i]).setSize(80,50).setPosition(1050 + (i*100), 10).plugTo(this, arr[i]);
    }   
    
}


void draw(){
  
   clear();
   background(bg);
 
   strokeWeight(3);
   stroke(204, 102, 0);
   line(902, 306, s.tipVal.x, s.tipVal.y);
   stroke(1,1,1);
   line(320, 210, t.tipVal.x, t.tipVal.y);
   stroke(255,0,0);
   line(556, 441, f.tipVal.x, f.tipVal.y);
  
   textSize(32);
   fill(204, 102, 0);
   text(M.getStr(), 775, 398);
   
   textSize(24);
   text(getCurtime(), 272, 286);
   
   textSize(50);
   text(drive_mode_opt[drive_idx], 550, 103);
   
   switch (warningIdx){
   
     case 1: {image(bL, 280, 425, 50, 50);break;}
     case 2: {image(cE, 570, 173, 50, 50);break;}
     case 3: {image(dO, 257, 400, 50, 50);break;}
     case 4: {image(fL, 396, 422, 50, 50);break;}
     case 5: {image(sB, 150, 303, 50, 50);break;}
     case 6: {image(sC, 570, 173, 50, 50);break;}
     case 7: {image(tP, 570, 173, 50, 50);break;}
     case 8: {image(eT, 570, 173, 50, 50);break;}
     case 0: {
     image(bL, 280, 425, 50, 50);
     image(cE, 570, 173, 50, 50);
     image(dO, 257, 400, 50, 50);
     image(fL, 396, 422, 50, 50);
     image(sB, 150, 303, 50, 50);
     image(sC, 570, 173, 50, 50);
     image(tP, 570, 173, 50, 50);
     image(eT, 570, 173, 50, 50);
              }
     default: {}

   
   }
   
   
   if(beamIdx == 1){
     image(hB, 530, 289, 50, 50);
   }
   else if(beamIdx == -1){
     image(lB, 470, 289, 50, 50);
   }
   else if(beamIdx == 2){
     image(fogL, 580, 289, 50, 50);
   }
   
   
   
   if(indicator == 1 || parkingLights == 1){
     if(blinker %50 == 0){
       image(iR, 570, 173, 50, 50);
     }
     else{
       image(iRCopy, 570, 173, 50, 50);
     }
   }
   else{
     blinker+=1;
   }
   
   if(indicator == -1 || parkingLights == 1){
     if(blinker %50 == 0){
       image(iL, 500, 173, 50, 50);
     }
     else{
     image(iLCopy, 500, 173, 50, 50);
     }
   }
   else{
     blinker+=1;
   }
   
   
   
   if(parkingLights == 1){
     image(pL, 542, 250, 50, 50);
   }
   
   if(f.angle < 200){
     image(fuelwar, 533, 478, 50, 50);
   }
  
  if(cruize == 1 && s.angle <= 200 && drive_idx != 1){
    image(cC, 182, 65, 50, 50);
    s.Gas(0.5);
    t.Gas(1);
  }
  else if(cruize == 1 && s.angle > 200 && drive_idx != 1){
    image(cC, 182, 65, 50, 50);
    s.Glide(0.2);
    t.Glide(0.2);
  }
  else{
    if(s.angle > 180 && drive_idx != 1 && cruize == -1){
      s.Glide(0.2);
      t.Glide(0.2);
    }  
  }
  
  
  if(drive_idx > 1 || drive_idx == 0){
     if(s.control == 0 && s.angle < 360){
       s.Gas(0.5);
     }
     else if(s.control == -1 && s.angle >= 180){
       s.Glide(0.2);
     }
     else if(s.control == 1 && s.angle > 180){
       s.Brake(1);
     }
     
     
     if(t.control == 0 && t.angle < 360){
       t.Gas(1);
     }
     else if(t.control == -1 && t.angle >= 180){  
       t.Glide(0.5);
     }
     else if(t.control == 1 && t.angle > 180){
       t.Brake(3);
     }
  }
  
}

Meter s = new Meter(902, 306, 110, 180);
Meter t = new Meter(320, 210, 80, 180);
Meter f = new Meter(556, 441, 60, 250);

String[] drive_mode_opt = {"R", "P", "D", "1", "2"};
int drive_idx = 1;
int indicator = 0;
int blinker = 0;
int parkingLights = 0;
int warningIdx = 0;
int beamIdx = 0;
int cruize = 0;


ControlP5 gearUp;
ControlP5 gearDown;
ControlP5 indicatorLeft;
ControlP5 indicatorRight;
ControlP5 parkingL;
ControlP5 fuelRefill;
ControlP5 toggleWarnings;
ControlP5[] BeamBtns = new ControlP5[3];
ControlP5 cruizeC;

PImage bg;
PImage fuelwar;
PImage iL;
PImage iR;
PImage iLCopy;
PImage iRCopy;
PImage pL;

PImage   bL;
PImage   cE;
PImage   dO;
PImage   fL;
PImage   sB;
PImage   sC;
PImage   tP;
PImage   eT;
PImage   cC;
PImage   fogL;
PImage   hB;
PImage   lB;

Miles M = new Miles();
