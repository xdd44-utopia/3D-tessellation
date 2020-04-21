import processing.opengl.*;
import igeo.*;

double frameLen = 100;
int xcount = 40;
int ycount = xcount/2;
int zcount = 5;
double radius = frameLen/4;
double frameRad = 10;

void setup(){
	size(1280,720,IG.GL);
	IVec awayFromThis = new IVec(1000,1000,100);
	awayFromThis.show();

	Dode[][][] list = new Dode[xcount][ycount][zcount];

	for (int i=0;i<xcount;i++){
		for (int j=0;j<ycount;j++){
			for (int k=0;k<zcount;k++){
				list[i][j][k] = new Dode(new Option(new IVec(frameLen*i/2+(abs(k)%2)*frameLen/2,frameLen*j-(abs(i)%2)*frameLen/2,frameLen*k/2), radius, frameRad));
				list[i][j][k].awayFrom(awayFromThis);
			}
		}
	}
	for (int i=0;i<xcount;i++){
		for (int j=0;j<ycount;j++){
			for (int k=0;k<zcount;k++){
				if (i > 0 && i < xcount-1 && j > 0 && j < ycount-1){	
					IVec pp = list[i][j][k].pos.dup();
					IVec pl = list[i+1][j-(abs(i)%2)][k].pos.dup().sub(pp);
					IVec pr = list[i-1][j-(abs(i)%2)][k].pos.dup().sub(pp);
					IVec dir = new IVec(pr.y()*pl.z()-pr.z()*pl.y(), pr.z()*pl.x()-pr.x()*pl.z(), pr.x()*pl.y()-pr.y()*pl.x());
					list[i][j][k].rotateTo(dir);
				}
			}
		}
	}
	for (int i=0;i<xcount;i++){
		for (int j=0;j<ycount;j++){
			for (int k=0;k<zcount;k++){
				if (i > 1 && i < xcount-2 && j > 0 && j < ycount-1 && k > 0){	
					Dode[] involved = new Dode[]{
						list[i+1][j-(abs(i)%2)][k],
						list[i-1][j-(abs(i)%2)][k],
						list[i+2*(abs(k)%2)][j][k-1],
						list[i-2*(abs(k+1)%2)][j][k-1],
						list[i+1-2*(abs(k+1)%2)][j+(abs(i+1)%2)][k-1]
					};
					list[i][j][k].displayFrameA(involved);
				}
			}
		}
	}
}

IVec rotVec(IVec ori, IVec from, IVec to){
	double angle = acos((float)((from.x()*to.x()+from.y()*to.y()+from.z()*to.z())/(from.len()*to.len())));
	IVec axis = new IVec(from.y()*to.z()-from.z()*to.y(), from.z()*to.x()-from.x()*to.z(), from.x()*to.y()-from.y()*to.x());
	IVec newVec = ori.dup().rot(axis, angle);
	return newVec;
}
