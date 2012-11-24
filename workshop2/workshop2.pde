//Walk sequence animation
//Art work by "TheZakMan" at OpenGameArt.org
//http://opengameart.org/content/plataform-walk-jump-animation-side-view
//Licenced under CC-BY 3.0 license

/*@pjs preload="data/walk01.png, data/walk02.png, data/walk03.png,
                data/walk04.png, data/walk05.png, data/walk06.png,
                data/walk07.png, data/walk08.png, data/walk09.png,
                data/walk10.png, data/walk11.png, data/walk12.png,
                data/walk13.png, data/walk14.png, data/walk15.png,
                data/walk16.png, data/walk17.png, data/walk18.png,
                data/walk19.png, data/walk20.png, data/walk21.png,
                data/walk22.png, data/walk23.png, data/walk24.png,
                data/walk25.png, data/walk26.png, data/walk27.png,
                data/walk28.png, data/walk29.png, data/walk30.png,
                data/walk31.png"; */

PImage [] walk = new PImage[31];  //31 frames in the walk cycle
int sequenceid=0;

void setup(){
  size(500,500);
  for(int i=0;i<31;i++){
    walk[i]=loadImage("data/walk"+(i<9?"0":"") + (i+1) + ".png");
  }
  imageMode(CENTER);
}

void draw(){
  background(255);
  image(walk[sequenceid],width/2, height/2);
  sequenceid++;
  if(sequenceid==31)
    sequenceid=0;
}
