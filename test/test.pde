import processing.opengl.*;
import igeo.*;

double frameLen = 100;
int xcount = 40;
int ycount = xcount/2;
int zcount = 8;
double radius = frameLen/4;
double frameRad = 5;

void setup(){
  size(1280,720,IG.GL);
	new IPoint(0,0,0);
	IG.save("233.obj");
}

IVec rotVec(IVec ori, IVec from, IVec to){
	double angle = acos((float)((from.x()*to.x()+from.y()*to.y()+from.z()*to.z())/(from.len()*to.len())));
	IVec axis = new IVec(from.y()*to.z()-from.z()*to.y(), from.z()*to.x()-from.x()*to.z(), from.x()*to.y()-from.y()*to.x());
	IVec newVec = ori.dup().rot(axis, angle);
	return newVec;
}
