
int PADDING = -30;
int X_SPACING = 60;
int X_INTERVAL_OFFSET = X_SPACING / 2;
int Y_SPACING = 30;
float BASE_SIZE = 10;
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
  float focalXInfluence = (float) focalX / width * 500;
  float focalYInfluence = (float) focalY / height * 500;
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
      int deltaX = (int) focalX - x;
      int deltaY = (int) focalY - y;
      float distance = (float) Math.sqrt(deltaX * deltaX + deltaY * deltaY);

      float normalizedDistance = distance / 500;
      int posX = x + intervalOffset - (int)(normalizedDistance * 2 * Math.sqrt(Math.abs(deltaX) * 10) * sign(deltaX));
      int posY = y - (int) (normalizedDistance * 2 * Math.sqrt(Math.abs(deltaY) * 10) * sign(deltaY));
      float distanceMultiplier = 1 + normalizedDistance;
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
        normalizedDistance + rotationOffset,
        BASE_SIZE * distanceMultiplier
      );
    }
  }
}

void scale(int x, int y, float rotation, float size) {
  pushMatrix();
  translate(x, y);
  rotate(rotation);
  beginShape();
  vertex(0, 15 * size);
  vertex(-3 * size, 5 * size);
  vertex(-5 * size, -10 * size);
  vertex(0, 0);
  vertex(5 * size, -10 * size);
  vertex(3 * size, 5 * size);
  vertex(0, 15 * size);
  // ellipse(0, 0, size * 10, size * 15);
  //vertex(-10 * size, -10 * size);
  //quadraticVertex(0, 0, 10, -10 * size);
  //vertex(10 * size, 10 * size);
  //quadraticVertex(0, 0, -10, 10 * size);
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
  endShape(CLOSE);
  popMatrix();
}

int sign(int n) {
  if (n == 0) {
    return 0;
  }
  return n / Math.abs(n);
}
