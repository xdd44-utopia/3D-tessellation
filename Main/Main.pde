import processing.opengl.*;
import igeo.*;

Dode h1;

void setup(){
	size(1280,720,IG.GL);
	h1 = new Dode(new IVec(0,0,0), 100);
	h1.displayVec();
	h1.display();
}
