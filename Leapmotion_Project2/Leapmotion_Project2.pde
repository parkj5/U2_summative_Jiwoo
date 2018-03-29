import de.voidplus.leapmotion.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer song;


float Brightness=255;
float Delta=-0.1;
//Light Position
int A= 150;
int B=250;
int C=100;
int D=20;
int E=30;

PImage Tree;
PImage Light;
PImage MLight;
PImage SLight;


Leaves[]Bunch= new Leaves[300];
Fallingleaves[]Wind= new Fallingleaves[30];
Sky[]Stars= new Sky[3];

LeapMotion leap;

void setup() 
{
  imageMode(CENTER);
  rectMode(CENTER);

  size(1000, 800, P2D);
  minim = new Minim(this);
  song= minim.loadFile("Evening.mp3");
  
  Tree=loadImage("Tree1.jpg");
  Tree.resize(1000, 800);
  Light= loadImage("Light.png");
  Light.resize(130, 130);
  MLight= loadImage("Light.png");
  MLight.resize(60, 60);
  SLight= loadImage("Light.png");
  SLight.resize(20, 20);

 
  leap = new LeapMotion(this);
  for (int i=0; i<300; i++)
  {
    Bunch[i]= new Leaves((int)random(500, 750), (int)random(250, 450), 0);
  }
  for (int f=0; f<30; f++)
  { 
    Wind[f]= new Fallingleaves((int)random(-400,-100), (int)random(-200,300), (int)random(1,3), (int)random(1,2));
  }
  for(int j=0; j<3; j++)
  {
    Stars[j]= new Sky((int)random(0,800),(int)random(-800,-300),0 , (int)random(30,40));
  }
}



void leapOnInit() {
}
void leapOnConnect() {
}
void leapOnFrame() {
}
void leapOnDisconnect() {
}
void leapOnExit() {
}


void draw() 
{
  background(0);
  
  song.play();

  Brightness+=Delta;
    if (Brightness>255)
  { 
    Delta*= -1;
  }
  if (Brightness<0)
  { 
    Delta*=-1;
  }
  
  tint(Brightness, Brightness, Brightness);
  image(Tree, 500, 400);

  for (int i=0; i<300; i++)
  { 
    Bunch[i].Render();
  }
  
  

  int fps = leap.getFrameRate();
  for (Hand hand : leap.getHands ()) 
  {
    int     handId             = hand.getId();
    PVector handPosition       = hand.getPosition();
    PVector handStabilized     = hand.getStabilizedPosition();
    PVector handDirection      = hand.getDirection();
    PVector handDynamics       = hand.getDynamics();
    float   handRoll           = hand.getRoll();
    float   handPitch          = hand.getPitch();
    float   handYaw            = hand.getYaw();
    boolean handIsLeft         = hand.isLeft();
    boolean handIsRight        = hand.isRight();
    float   handGrab           = hand.getGrabStrength();
    float   handPinch          = hand.getPinchStrength();
    float   handTime           = hand.getTimeVisible();
    PVector spherePosition     = hand.getSpherePosition();
    float   sphereRadius       = hand.getSphereRadius();

    hand.draw();

    if (hand.hasArm()) 
    {
      Arm     arm              = hand.getArm();
      float   armWidth         = arm.getWidth();
      PVector armWristPos      = arm.getWristPosition();
      PVector armElbowPos      = arm.getElbowPosition();
    }

    Finger  fingerThumb        = hand.getThumb();
    Finger  fingerIndex        = hand.getIndexFinger();
    Finger  fingerMiddle       = hand.getMiddleFinger();
    Finger  fingerRing         = hand.getRingFinger();
    Finger  fingerPink         = hand.getPinkyFinger();

    for (Finger finger : hand.getFingers()) 
    {
      int     fingerId         = finger.getId();
      PVector fingerPosition   = finger.getPosition();
      PVector fingerStabilized = finger.getStabilizedPosition();
      PVector fingerVelocity   = finger.getVelocity();
      PVector fingerDirection  = finger.getDirection();
      float   fingerTime       = finger.getTimeVisible();


      switch(finger.getType()) 
      {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      }

      Bone    boneDistal       = finger.getDistalBone();
      Bone    boneIntermediate = finger.getIntermediateBone();
      Bone    boneProximal     = finger.getProximalBone();
      Bone    boneMetacarpal   = finger.getMetacarpalBone();

      int     touchZone        = finger.getTouchZone();
      float   touchDistance    = finger.getTouchDistance();
      for (int i=0; i<200; i++)
      { 

        if (dist(fingerThumb.getPosition().x, fingerThumb.getPosition().y, Bunch[i].LX, Bunch[i].LY)<30)
        { 
          Bunch[i].LYspeed=(int)random(2, 4);
        }

        if (Bunch[i].LY>850)
        { 
          Bunch[i].LX=(int)random(500, 750);
          Bunch[i].LY=(int)random(250, 450);
          Bunch[i].LYspeed=0;
          
        }
      }
      
      for (int f=0; f<30; f++)
      {
        if(Brightness>180)
        {
        if(dist(fingerThumb.getPosition().x, fingerThumb.getPosition().y , fingerIndex.getPosition().x, fingerIndex.getPosition().y)<50 )
        {
          Wind[f].Render();
        }
        if(Wind[f].FLX>900 || Wind[f].FLY>900)
        {
          Wind[f].FLX= (int)random(-400,-100);
          Wind[f].FLY= (int)random(-200,300);
          Wind[f].FLXspeed= (int)random(1,3);
          Wind[f].FLYspeed=(int)random(1,2);
        }
      }
      }
      
      
      
      if(Brightness<30)
  {
   tint(255,200-Brightness);
  for (int j=0; j<3; j++)
   {
     Stars[j].Render();
   }
  }

        tint(255, 0, 0, 155-Brightness);
        image(Light, fingerThumb.getPosition().x, fingerThumb.getPosition().y);
        if(handIsRight)
        {
        image(MLight, fingerThumb.getPosition().x-A, fingerThumb.getPosition().y-A);
        image(SLight, fingerThumb.getPosition().x-A-D, fingerThumb.getPosition().y-A+D);
        image(SLight, fingerThumb.getPosition().x-A-E, fingerThumb.getPosition().y-A+D);
        image(SLight, fingerThumb.getPosition().x-A+E, fingerThumb.getPosition().y-A);
        image(SLight, fingerThumb.getPosition().x-A, fingerThumb.getPosition().y-A-D);
        }
        if(handIsLeft)
        {
        image(MLight, fingerThumb.getPosition().x+A+D, fingerThumb.getPosition().y-A);
        image(SLight, fingerThumb.getPosition().x+A, fingerThumb.getPosition().y-A-E);
        image(SLight, fingerThumb.getPosition().x+A, fingerThumb.getPosition().y-A+D);
        image(SLight, fingerThumb.getPosition().x+A-E, fingerThumb.getPosition().y-A);
        image(SLight, fingerThumb.getPosition().x+A+E, fingerThumb.getPosition().y-A+D);
        }
        
        tint(255, 255, 0, 155-Brightness);
        image(Light, fingerIndex.getPosition().x, fingerIndex.getPosition().y);
        if(handIsRight)
        {
        image(MLight, fingerIndex.getPosition().x-C, fingerIndex.getPosition().y-A);
        image(SLight, fingerIndex.getPosition().x-C, fingerIndex.getPosition().y-A-D);
        image(SLight, fingerIndex.getPosition().x-C-E, fingerIndex.getPosition().y-A+E);
        image(SLight, fingerIndex.getPosition().x-C-D, fingerIndex.getPosition().y-A-D);
        }
        if(handIsLeft)
        {
        image(MLight, fingerIndex.getPosition().x+C, fingerIndex.getPosition().y-A);
        image(SLight, fingerIndex.getPosition().x+C-E, fingerIndex.getPosition().y);
        image(SLight, fingerIndex.getPosition().x+C+D, fingerIndex.getPosition().y-D);
        }
        
        tint(0, 255, 0, 155-Brightness);
        image(Light, fingerMiddle.getPosition().x, fingerMiddle.getPosition().y);
        image(MLight, fingerMiddle.getPosition().x, fingerIndex.getPosition().y-B);
        image(SLight, fingerMiddle.getPosition().x+E, fingerIndex.getPosition().y-B+E);
        image(SLight, fingerMiddle.getPosition().x-D, fingerIndex.getPosition().y-B-E);
        image(SLight, fingerMiddle.getPosition().x-E, fingerIndex.getPosition().y-B+D);
        image(SLight, fingerMiddle.getPosition().x-D, fingerIndex.getPosition().y-B+E);
        
        tint(0, 0, 255, 155-Brightness);
        image(Light, fingerRing.getPosition().x, fingerRing.getPosition().y);
        if(handIsRight)
        {
        image(MLight, fingerRing.getPosition().x+C, fingerRing.getPosition().y-A);
        image(SLight, fingerRing.getPosition().x+C-E, fingerRing.getPosition().y);
        image(SLight, fingerRing.getPosition().x+C+D, fingerRing.getPosition().y-D);
        }
        if(handIsLeft)
        {
        image(MLight, fingerRing.getPosition().x-C, fingerRing.getPosition().y-A);
        image(SLight, fingerRing.getPosition().x-C, fingerRing.getPosition().y-A-D);
        image(SLight, fingerRing.getPosition().x-C-E, fingerRing.getPosition().y-A+E);
        image(SLight, fingerRing.getPosition().x-C-D, fingerRing.getPosition().y-A-D);
        }

        tint(255, 0, 255, 155-Brightness);
        image(Light, fingerPink.getPosition().x, fingerPink.getPosition().y);
        if(handIsRight)
        {
        image(MLight, fingerPink.getPosition().x+A+D, fingerPink.getPosition().y-A);
        image(SLight, fingerPink.getPosition().x+A, fingerPink.getPosition().y-A-E);
        image(SLight, fingerPink.getPosition().x+A, fingerPink.getPosition().y-A+D);
        image(SLight, fingerPink.getPosition().x+A-E, fingerPink.getPosition().y-A);
        image(SLight, fingerPink.getPosition().x+A+E, fingerPink.getPosition().y-A+D);
        }
        if(handIsLeft)
        {
        image(MLight, fingerPink.getPosition().x-A, fingerPink.getPosition().y-A);
        image(SLight, fingerPink.getPosition().x-A-D, fingerPink.getPosition().y-A+D);
        image(SLight, fingerPink.getPosition().x-A-E, fingerPink.getPosition().y-A+D);
        image(SLight, fingerPink.getPosition().x-A+E, fingerPink.getPosition().y-A);
        image(SLight, fingerPink.getPosition().x-A, fingerPink.getPosition().y-A-D);
        }
        
        
        
      




      switch(touchZone) 
      {
      case -1: 
        break;
      case 0: 
        break;
      case 1: 
        break;
      }
    }


    for (Tool tool : hand.getTools()) {
      int     toolId           = tool.getId();
      PVector toolPosition     = tool.getPosition();
      PVector toolStabilized   = tool.getStabilizedPosition();
      PVector toolVelocity     = tool.getVelocity();
      PVector toolDirection    = tool.getDirection();
      float   toolTime         = tool.getTimeVisible();

      int     touchZone        = tool.getTouchZone();
      float   touchDistance    = tool.getTouchDistance();

      switch(touchZone) 
      {
      case -1: 
        break;
      case 0: 
        break;
      case 1: 
        break;
      }
    }
  }



  for (Device device : leap.getDevices()) 
  {
    float deviceHorizontalViewAngle = device.getHorizontalViewAngle();
    float deviceVericalViewAngle = device.getVerticalViewAngle();
    float deviceRange = device.getRange();
  }
}