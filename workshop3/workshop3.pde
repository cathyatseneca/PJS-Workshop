boolean spawnCircle=false;
class Circle{
  float x_, y_;
  float radius_;

  Circle(float x,float y, float r){
    x_=x;
    y_=y;
    radius_=r;
  }
  void draw(){
    ellipse(x_,y_,radius_,radius_);
  }
}

Circle [] circleList=new Circle[50];
int numCircles=0;
void setup(){
  size(500,500);
}
void draw(){
  background(0);
  if(spawnCircle==true){
    if(numCircles<50){
      circleList[numCircles]=new Circle(random(10,490),random(10,490),random(50,100));
      numCircles++;
    }
    spawnCircle=false;
  }
  for(int i=0;i<numCircles;i++){
    circleList[i].draw();
  }

}
/*
  Function gets called once, as soon as the
  mouse button is pressed.
*/
void mousePressed(){
  spawnCircle=true;
}
