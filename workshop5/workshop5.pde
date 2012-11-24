//states that the board can be in.  either a piece is falling into place
//or it is stable waiting for input
int DROPPING = 1;
int STABLE = 2;
int WIN = 3;
color backgroundColour=color(0);
color boardColour=color(256,256,0);
int pieceSize=50;
int pieceWidth=70;
int pieceHeight=60;
ConnectFour c4;

void setup(){
	c4=new ConnectFour();
	size(600,500);
}
void draw(){

	c4.draw();
}

class ConnectFour{
	int [][] board_;     //board_[row][col]
	int numpiece_[7];    //number of pieces in each column
	int state_;
	int turn_;           //1 for p1, -1 for p2
	int recent_;         //most recently added column so that we can do "drop"
	int newY_;
	bool win_;
	ConnectFour(){
		board_=new int[7][7];
		for(int i=0;i<7;i++){
			for(int j=0;j<7;j++){
				board_[i][j]=0;
			}
		}
		numpiece_=new int[7];
		for(int i=0;i<7;i++){
			numpiece_[i]=0;
		}
		state_=STABLE;
		turn_=1;
	}
	//returns true if player was successfully added, false otherwise
	bool addPiece(int column){
		if(state_==STABLE && numpiece_[column]<7){
			state_=DROPPING;
			recent_=column
			newY_=pieceSize/2;
		}
	}
	void draw(){
		if(state_==STABLE){
			drawStable();
		}
		else if(state_==DROPPING){
			drawDropping();
		}
		else{
		
			drawWin();
		}

	}
	void drawWin(){
		drawStable();
		fill(color(255));
		textSize(24);
		if(turn_==-1)
			turn_=2;
		text("Player " + turn_ + " has Won!", width/2-100,height/2);

	}
	void drawStable(){
	    background(backgroundColour);
	    stroke(boardColour);
		for(int i=0;i<8;i++){
			line(i*70+10,50,i*70+10,490);
		}
		for(int i=0; i < 7; i++){
			for(int j=0;j< 7;j++){
				if(board_[i][j]==1){
					fill(color(255,0,0)); 
					ellipse(j*70+10+pieceWidth/2,(7-i)*60+pieceHeight/2,pieceSize,pieceSize);
				}
				else if(board_[i][j]==-1){
					fill(color(0,0,255));
					ellipse(j*70+10+pieceWidth/2,(7-i)*60+pieceHeight/2,pieceSize,pieceSize);

				}
			}
		}
	}
	void drawDropping(){

		if(newY_>=(7-numpiece_[recent_])*60+pieceHeight/2){
			board_[numpiece_[recent_]][recent_]=turn_;
			numpiece_[recent_]++;
			win_=checkWin(recent_,turn_);
			if(win_==false){	
				turn_=turn_*-1;                        //flip player
				state_=STABLE;
			}
			else{
				state_=WIN;
			}
		}
		else{

			drawStable();
			if(turn_ == 1){
				fill(color(255,0,0));
			}
			else{
				fill(color(0,0,255));	
			}
			ellipse(recent_*70+10+pieceWidth/2,newY_,pieceSize,pieceSize);
			newY_+=5;
		}
	}
	int numLeft(int col, int player){
	    int rc=0;
		for(int i=col-1;i>=0 && board_[numpiece_[col]-1][i]==player;i--){
			rc++;
		}
		return rc;
	}
	int numRight(int col, int player){
	    int rc=0;
		for(int i=col+1;i<7 && board_[numpiece_[col]-1][i]==player;i++){
			rc++;
		}
		return rc;
	}
	int numDown(int col, int player){
	    int rc=0;
		for(int i=numpiece_[col]-2;i>=0 && board_[i][col]==player;i--){
			rc++;
		}
		return rc;
	}
	int numDownLeft(int col, int player){
	    int rc=0;
	    int i,j;
		for(i=numpiece_[col]-2,j=col-1;i>=0 && j>=0 && board_[i][j]==player;i--,j--){
			rc++;
		}
		return rc;
	}
	int numDownRight(int col, int player){
	    int rc=0;
	    int i,j;
		for(i=numpiece_[col]-2,j=col+1;i>=0 && j<7 && board_[i][j]==player;i--,j++){
			rc++;
		}
		return rc;
	}
	int numUpLeft(int col, int player){
	    int rc=0;
	    int i,j;
		for(i=numpiece_[col],j=col-1;i<7 && j>=0 && board_[i][j]==player;i++,j--){
			rc++;
		}
		return rc;
	}
	int numUpRight(int col, int player){
	    int rc=0;
	    int i,j;

		for(i=numpiece_[col],j=col+1;i<7 && j<7 && board_[i][j]==player;i++,j++){
			rc++;
		}
		return rc;
	}	
	bool checkWin(int col, int player){
	    bool rc=false;
		if((numLeft(col,player)+numRight(col,player)+1 >= 4) ||
			(numUpLeft(col,player)+ numDownRight(col,player) +1 >=4) ||
			(numDownLeft(col,player)+ numUpRight(col,player)+1 >=4) ||
			(numDown(col,player)+1 >=4))
			{
				rc=true;
			}

		return rc;
	}

}
void doAdd(int col){
	c4.addPiece(col);
}
void mouseClicked(){
    int column;
	if(mouseX > 10 && mouseX < 500){
		column = floor((int(mouseX)-10)/pieceWidth);
		c4.addPiece(column);
	}

}