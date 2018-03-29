class Sky
{
  PImage Star;
  int SX;
  int SY;
  int SXspeed;
  int SYspeed;

  
  Sky()
  {
    Star= loadImage("Star.png");
    Star.resize(50,400);

    SX=400;
    SY=-200;
    SXspeed=0;
    SYspeed=50;
  }
  Sky(int _SX, int _SY, int _SXspeed, int _SYspeed)
  {
    Star= loadImage("Star.png");
    Star.resize(100,400);
    SX= _SX;
    SY= _SY;
    SXspeed= _SXspeed;
    SYspeed= _SYspeed;
  }
  
  void Render()
  {
   image(Star,SX,SY);
    SX=SX+SXspeed;
    SY=SY+SYspeed;
    if (SY>1200)
        {
          SX=(int)random(0,900);
          SY=(int)random(-400,-100);
          SXspeed=0;
          SYspeed=(int)random(30,40);
        }
      
  }
}