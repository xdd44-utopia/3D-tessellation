import processing.opengl.*;
import igeo.*;

double frameLen = 100;
double radius = frameLen/4;

void setup(){
	size(1280,720,IG.GL);
	IVec awayFromThis = new IVec(0,0,0);
	awayFromThis.show();
	for (int i=-10;i<=10;i++){
		for (int j=-20;j<=20;j++){
			if (i > -1 && i < 1 && j > -1 && j < 1){
				continue;
			}
			Dode h = new Dode(new IVec(frameLen*i-(abs(j)%2)*frameLen/2,frameLen*j/2,0), radius);
			h.awayFrom(awayFromThis);
			h.display();
		}
		//h.rotateMiddle(PI/10*i);
	}
}
