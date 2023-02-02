public void drawHeart(int posx, int posy) {
  smooth();
  noStroke();
  fill(255,0,0);
  beginShape();
  vertex(20 + posx, 15 + posy);
  bezierVertex(20 + posx, -5 + posy, 60 + posx, 5 + posy, 20 + posx, 40 + posy);
  vertex(20 + posx, 15 + posy);
  bezierVertex(20 + posx, -5 + posy, -20 + posx, 5 + posy, 20 + posx, 40 + posy);
  endShape();
}
