class Fallingleaves
{
  PImage Fallingleaf;
  int FLX;
  int FLY;
  int FLXspeed;
  int FLYspeed;
  
   Fallingleaves()
  {
    Fallingleaf = loadImage("Fallingleaf.png");
    Fallingleaf.resize(80,80);
    FLX=-100;
    FLY=200;
    FLXspeed= 2;
    FLYspeed=1;
  }
  Fallingleaves(int _FLX, int _FLY, int _FLXspeed, int _FLYspeed)
  {
    Fallingleaf = loadImage("Fallingleaf.png");
    Fallingleaf.resize(80,80);
    FLX= _FLX;
    FLY= _FLY;
    FLXspeed=_FLXspeed;
    FLYspeed= _FLYspeed;
  }
  void Render()
  {
    image(Fallingleaf,FLX,FLY);
    FLX= FLX+FLXspeed;
    FLY= FLY+FLYspeed;
  }
}
    
 