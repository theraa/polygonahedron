//import ddf.minim.*;
import com.leapmotion.leap.*; 
PFont vida;
int width = 1440;
int height = 900;
color canvasColor = #000000;
float turns = radians(360);
float xRotation = 0;
float yRotation = 0;
float zRotation = 0;
Controller leap = new Controller();

void setup()
{
  frameRate(120);
  size(width, height, P3D);
  background(canvasColor);
  vida = createFont("DINCondensed", 14);
  textFont(vida);
}


void draw() {   
  Frame frame = leap.frame();
  Hand hand = frame.hands().frontmost();
  if ( hand.isValid() )
  {
    InteractionBox box = frame.interactionBox();
    Vector controlPosition = hand.palmPosition();
    Vector normalizedPosition = box.normalizePoint(controlPosition, false);
    xRotation = turns * normalizedPosition.getX();
    yRotation = turns * (1 - normalizedPosition.getY());
    zRotation = turns * normalizedPosition.getZ();
  }
  background(canvasColor);
  hud(); 
  translate(width/2, height/2);
  rotateZ(xRotation*.618);
  rotateX(yRotation*.618);
  rotateY(-zRotation*.618);
  stroke(#777777);
  strokeWeight(1);
  noFill();
  sphere(300);
  sphereDetail(10*round(yRotation)/4, 20*round(yRotation)/4);
}

// zRotation = ot sebja / na sebja
// yRotation = vyshe / nizhe
// xRotation = vlevo / vpravo

void hud() {
  text("X "+round(xRotation), width/2-width/3, height-15);
  text("Y "+round(yRotation), width/2, height-15);
  text("Z "+round(zRotation), width/2+width/3, height-15);
  fill(#777777);
}
