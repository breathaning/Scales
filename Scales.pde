int PADDING = -20;
int X_SPACING = 40;
int X_INTERVAL_OFFSET = X_SPACING / 2;
int Y_SPACING = 20;
float BASE_SIZE = 5;
float FOCAL_SMOOTH = 10;

float focalX = 0;
float focalY = 0;

void setup() {
  size(500, 500);
}

void draw() {
 background(128, 128, 128);
 focalX += (mouseX - focalX) / FOCAL_SMOOTH;
 focalY += (mouseY - focalY) / FOCAL_SMOOTH;
 float focalXInfluence = (float)focalX / width * 500;
 float focalYInfluence = (float)focalY / height * 500;
 float rotationalInfluenceLayerOne = (float)(Math.sin((float)(millis()) / 1000)) / 8;
 float rotationalInfluenceLayerTwo = (float)(Math.sin((float)(millis()) / 1000 + (PI / 4))) / 8;
 for (int y = PADDING; y <= height - PADDING; y += Y_SPACING) {
   int intervalOffset;
   boolean isOffset = ((y - PADDING) % (Y_SPACING * 2) == 0);
   if (isOffset) {
     intervalOffset = X_INTERVAL_OFFSET;
   } else {
     intervalOffset = 0;
   }
   for (int x = PADDING; x <= width - PADDING; x += X_SPACING) {
     fill(
       (x + y) / 2.5 - 250 + focalXInfluence, 
       (2 * y - x) / 2.5 - 250 + focalYInfluence, 
       (width - y - x) / 2.5 - 250 + focalYInfluence
     );
     int deltaX = (int)focalX - x;
     int deltaY = (int)focalY - y;
     float distance = (float)Math.sqrt(deltaX * deltaX + deltaY * deltaY);
     
     int posX = x + intervalOffset - (int)(distance / 250 * Math.sqrt(Math.abs(deltaX) * 10) * Math.signum(deltaX));
     int posY = y - (int)(distance / 250 * Math.sqrt(Math.abs(deltaY) * 10) * Math.signum(deltaY));
     float distanceMultiplier = (1 + distance / 500);
     float rotationOffset;
     if (isOffset == true) {
       rotationOffset = rotationalInfluenceLayerTwo;
     } else {
       rotationOffset = rotationalInfluenceLayerOne;
     }
     rotationOffset *= distanceMultiplier;
     scale(
       posX, 
       posY, 
       PI / 3 + distance / 500 + rotationOffset, 
       BASE_SIZE * distanceMultiplier
     );
   }
 }
}

void scale(int x, int y, float rotation, float size) {
  translate(x, y);
  rotate(rotation);
  ellipse(0, 0, size * 10, size * 15);
  //beginShape();
  //vertex(-10 * size, -10 * size);
  //quadraticVertex(0, 0, 10, -10 * size);
  //vertex(10 * size, 10 * size);
  //quadraticVertex(0,  0, -10, 10 * size);
  //vertex(-10 * size, -10 * size);
  //curveVertex(-10 * size, -10 * size);
  //curveVertex(-9 * size, -10 * size);
  //curveVertex(0 * size, -5 * size);
  //curveVertex(9 * size, -10 * size);
  //curveVertex(10 * size, -10 * size);
  //curveVertex(10 * size, 10 * size);
  //curveVertex(9 * size, 10 * size);
  //curveVertex(0 * size, 5 * size);
  //curveVertex(-9 * size, 10 * size);
  //curveVertex(-10 * size, 10 * size);
  //curveVertex(-10 * size, -10 * size);
  //vertex(-10 * size, -10 * size);
  //endShape(CLOSE);
  rotate(-rotation);
  translate(-x, -y);
}

