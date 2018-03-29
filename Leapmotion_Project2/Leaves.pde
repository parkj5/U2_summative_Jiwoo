class Leaves
{
  PImage Leaf;
  int LX;
  int LY;
  int LYspeed;
 
  
  Leaves()
  {
   Leaf= loadImage("RLeaf.png");
    Leaf.resize(10,10);
    LX=600;
    LY=300;
    LYspeed=0;
  }
  
  Leaves(int _LX, int _LY, int _LYspeed)
  {
   Leaf= loadImage("RLeaf.png");
    Leaf.resize(10,10);
    LX= _LX;
    LY= _LY;
    LYspeed= _LYspeed;
  }
  void Render()
  {
    image(Leaf,LX,LY);
    LY=LY+LYspeed;
  }
}