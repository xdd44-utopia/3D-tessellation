import processing.opengl.*;
import igeo.*;

double frameLen = 100;
int xcount = 40;
int ycount = xcount/2;
int zcount = 8;
double radius = frameLen/4;
double frameRad = 5;

void setup(){
	new IPoint(0,0,0);
	size(1280,720,IG.GL);
	IVec t1 = new IVec(0,0,100);
	t1 = rotVec(t1, new IVec(0,0,1), new IVec(1,0,0)).dup();
	t1.show().clr(255,0,255);
	t1 = rotVec(t1, new IVec(1,0,0), new IVec(0,1,0)).dup();
	t1.show().clr(0,255,255);
	Dode dd = new Dode(method1(new IVec(0,0,0)));
	/*
	dd.displayFrameA(new Dode[]{
    	new Dode(method1(new IVec(frameLen/2, -frameLen/2, 0))),
    	new Dode(method1(new IVec(-frameLen/2, -frameLen/2, 0))),
    	new Dode(method1(new IVec(frameLen/2, 0, -frameLen/2))),
    	new Dode(method1(new IVec(-frameLen/2, 0, -frameLen/2))),
    	new Dode(method1(new IVec(0, frameLen/2, -frameLen/2)))
	});*/
	IVec newDir = new IVec(10,100,50);
	new ICurve(0,0,0,10,100,50);
	Dode[] involved = new Dode[]{
    	new Dode(method1(rotVec(new IVec(frameLen/2, -frameLen/2, 0), new IVec(0,0,1), newDir))),
    	new Dode(method1(rotVec(new IVec(-frameLen/2, -frameLen/2, 0), new IVec(0,0,1), newDir))),
    	new Dode(method1(rotVec(new IVec(frameLen/2, 0, -frameLen/2), new IVec(0,0,1), newDir))),
    	new Dode(method1(rotVec(new IVec(-frameLen/2, 0, -frameLen/2), new IVec(0,0,1), newDir))),
    	new Dode(method1(rotVec(new IVec(0, frameLen/2, -frameLen/2), new IVec(0,0,1), newDir)))
	};
	for (int i=0;i<5;i++){
		involved[i].rotateTo(newDir);
	}
	dd.rotateTo(newDir);
	dd.displayFrameA(involved);
}

IVec rotVec(IVec ori, IVec from, IVec to){
	double angle = acos((float)((from.x()*to.x()+from.y()*to.y()+from.z()*to.z())/(from.len()*to.len())));
	IVec axis = new IVec(from.y()*to.z()-from.z()*to.y(), from.z()*to.x()-from.x()*to.z(), from.x()*to.y()-from.y()*to.x());
	IVec newVec = ori.dup().rot(axis, angle);
	return newVec;
}
