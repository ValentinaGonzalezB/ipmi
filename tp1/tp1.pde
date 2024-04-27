PImage playa; 

void setup() {
size(800,400);
playa = loadImage ("playa.jpg"); 
noStroke(); 
}

void draw() {
image(playa,0,0);
//cielo//
 fill(200, 206, 250);
 rect(400, 0, 400, 300);

 //sol// 
fill(255, 255, 0);
ellipse(650, 70, 80, 80);
  
  //nubes// 
fill(255, 255, 255);
ellipse(500, 100, 120, 60);
ellipse(580, 80, 80, 50);
ellipse(620, 120, 100, 40); 

//agua//
fill(56, 222, 242); 
rect(400, 275, 550, 160); 

//montañas//
  fill(139, 69, 19);

  beginShape();
  vertex(400, 150); 
  vertex(400, 125); 
  vertex(600, 300); 
  vertex(400, 300); 
  endShape(CLOSE);

  beginShape();
  vertex(450, 275); 
  vertex(600, 100);
  vertex(750, 275);
  vertex(600, 275); 
  endShape(CLOSE);

}
