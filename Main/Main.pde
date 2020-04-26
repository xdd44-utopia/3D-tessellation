import processing.opengl.*;
import igeo.*;

double frameLen = 100;
int xcount = 10;
int ycount = 10;
int zcount = 4;
double radius = frameLen/4;
double frameRad = 5;

void setup(){
	size(1920,1000,IG.GL);
	IVec xarrow = new IVec(1000,0,0);
	xarrow.show().clr(255,0,0);
	IVec yarrow = new IVec(0,1000,0);
	yarrow.show().clr(0,255,0);
	IVec zarrow = new IVec(0,0,1000);
	zarrow.show().clr(0,0,255);

	Dode[][][] list = new Dode[xcount][ycount][zcount];
	generateIndept(list);
	generateDept(list);
	
	for (int i=0;i<xcount;i++){
		for (int j=0;j<ycount;j++){
			for (int k=0;k<zcount;k++){
				list[i][j][k].displayFrameA();
			}
		}
	}
	
	IG.save("Dode.obj");
}

void generateIndept(Dode[][][] list) {
	for (int i=0;i<xcount;i++){
		for (int j=0;j<ycount;j++){
			for (int k=0;k<zcount;k++){
				list[i][j][k] = new Dode(new IVec(frameLen*i+frameLen*(k%2)/2,frameLen*j+frameLen*(k%2)/2,frameLen*k*sqrt(2)/2), radius, frameRad, new IVec(i,j,k));
			}
		}
	}
}

void generateDept(Dode[][][] list) {
	for (int i=0;i<xcount;i++){
		for (int j=0;j<ycount;j++){
			for (int k=0;k<zcount;k++){
				try {
					IVec pt = new IVec(
						(list[i-1+(k%2)][j-1+(k%2)][k+1].pos.x()+list[i+(k%2)][j-1+(k%2)][k+1].pos.x()+list[i-1+(k%2)][j+(k%2)][k+1].pos.x()+list[i+(k%2)][j+(k%2)][k+1].pos.x())/4,
						(list[i-1+(k%2)][j-1+(k%2)][k+1].pos.y()+list[i+(k%2)][j-1+(k%2)][k+1].pos.y()+list[i-1+(k%2)][j+(k%2)][k+1].pos.y()+list[i+(k%2)][j+(k%2)][k+1].pos.y())/4,
						(list[i-1+(k%2)][j-1+(k%2)][k+1].pos.z()+list[i+(k%2)][j-1+(k%2)][k+1].pos.z()+list[i-1+(k%2)][j+(k%2)][k+1].pos.z()+list[i+(k%2)][j+(k%2)][k+1].pos.z())/4
					);
					IVec dirt = new IVec(
						(list[i-1+(k%2)][j-1+(k%2)][k+1].direction.x()+list[i+(k%2)][j-1+(k%2)][k+1].direction.x()+list[i-1+(k%2)][j+(k%2)][k+1].direction.x()
						+list[i+(k%2)][j+(k%2)][k+1].direction.x())/4,
						(list[i-1+(k%2)][j-1+(k%2)][k+1].direction.y()+list[i+(k%2)][j-1+(k%2)][k+1].direction.y()+list[i-1+(k%2)][j+(k%2)][k+1].direction.y()
						+list[i+(k%2)][j+(k%2)][k+1].direction.y())/4,
						(list[i-1+(k%2)][j-1+(k%2)][k+1].direction.z()+list[i+(k%2)][j-1+(k%2)][k+1].direction.z()+list[i-1+(k%2)][j+(k%2)][k+1].direction.z()
						+list[i+(k%2)][j+(k%2)][k+1].direction.z())/4
					);
					double frt = (list[i-1+(k%2)][j-1+(k%2)][k+1].frameRad+list[i+(k%2)][j-1+(k%2)][k+1].frameRad+list[i-1+(k%2)][j+(k%2)][k+1].frameRad+list[i+(k%2)][j+(k%2)][k+1].frameRad)/4;
					list[i][j][k].top = new DodeTopA(pt.dup().sub(list[i][j][k].pos), dirt.dup(), frt);
					list[i][j][k+2].bottom = new DodeTopA(pt.dup().sub(list[i][j][k+2].pos), dirt.dup(), frt);
					list[i-1+(k%2)][j-1+(k%2)][k+1].middle[1] = new DodeTopA(pt.dup().sub(list[i-1+(k%2)][j-1+(k%2)][k+1].pos), dirt.dup(), frt);
					list[i+(k%2)][j-1+(k%2)][k+1].middle[2] = new DodeTopA(pt.dup().sub(list[i+(k%2)][j-1+(k%2)][k+1].pos), dirt.dup(), frt);
					list[i-1+(k%2)][j+(k%2)][k+1].middle[0] = new DodeTopA(pt.dup().sub(list[i-1+(k%2)][j+(k%2)][k+1].pos), dirt.dup(), frt);
					list[i+(k%2)][j+(k%2)][k+1].middle[3] = new DodeTopA(pt.dup().sub(list[i+(k%2)][j+(k%2)][k+1].pos), dirt.dup(), frt);
				}
				catch (ArrayIndexOutOfBoundsException exception){}
				try {
					IVec pm1 = new IVec(
						(list[i][j][k].pos.x()+list[i+(k%2)][j-1+(k%2)][k+1].pos.x()+list[i+(k%2)][j+(k%2)][k+1].pos.x()+list[i+1][j][k].pos.x())/4,
						(list[i][j][k].pos.y()+list[i+(k%2)][j-1+(k%2)][k+1].pos.y()+list[i+(k%2)][j+(k%2)][k+1].pos.y()+list[i+1][j][k].pos.y())/4,
						(list[i][j][k].pos.z()+list[i+(k%2)][j-1+(k%2)][k+1].pos.z()+list[i+(k%2)][j+(k%2)][k+1].pos.z()+list[i+1][j][k].pos.z())/4
					);
					IVec dirm1 = new IVec(
						(list[i][j][k].direction.x()+list[i+(k%2)][j-1+(k%2)][k+1].direction.x()+list[i+(k%2)][j+(k%2)][k+1].direction.x()
						+list[i+1][j][k].direction.x())/4,
						(list[i][j][k].direction.y()+list[i+(k%2)][j-1+(k%2)][k+1].direction.y()+list[i+(k%2)][j+(k%2)][k+1].direction.y()
						+list[i+1][j][k].direction.y())/4,
						(list[i][j][k].direction.z()+list[i+(k%2)][j-1+(k%2)][k+1].direction.z()+list[i+(k%2)][j+(k%2)][k+1].direction.z()
						+list[i+1][j][k].direction.z())/4
					);
					double frm1 = (list[i][j][k].frameRad+list[i+(k%2)][j-1+(k%2)][k+1].frameRad+list[i+(k%2)][j+(k%2)][k+1].frameRad+list[i+1][j][k].frameRad)/4;
					list[i][j][k].upper[0] = new DodeMidA(pm1.dup().sub(list[i][j][k].pos), dirm1.dup(), frm1, 1);
					list[i+(k%2)][j-1+(k%2)][k+1].lower[1] = new DodeMidA(pm1.dup().sub(list[i+(k%2)][j-1+(k%2)][k+1].pos), dirm1.dup(), frm1, 1);
					list[i+(k%2)][j+(k%2)][k+1].lower[3] = new DodeMidA(pm1.dup().sub(list[i+(k%2)][j+(k%2)][k+1].pos), dirm1.dup(), frm1, 1);
					list[i+1][j][k].upper[2] = new DodeMidA(pm1.dup().sub(list[i+1][j][k].pos), dirm1.dup(), frm1, 1);
				}
				catch (ArrayIndexOutOfBoundsException exception){}
				try {
					IVec pm2 = new IVec(
						(list[i][j][k].pos.x()+list[i+(k%2)][j+(k%2)][k+1].pos.x()+list[i-1+(k%2)][j+(k%2)][k+1].pos.x()+list[i][j+1][k].pos.x())/4,
						(list[i][j][k].pos.y()+list[i+(k%2)][j+(k%2)][k+1].pos.y()+list[i-1+(k%2)][j+(k%2)][k+1].pos.y()+list[i][j+1][k].pos.y())/4,
						(list[i][j][k].pos.z()+list[i+(k%2)][j+(k%2)][k+1].pos.z()+list[i-1+(k%2)][j+(k%2)][k+1].pos.z()+list[i][j+1][k].pos.z())/4
					);
					IVec dirm2 = new IVec(
						(list[i][j][k].direction.x()+list[i+(k%2)][j+(k%2)][k+1].direction.x()+list[i-1+(k%2)][j+(k%2)][k+1].direction.x()
						+list[i][j+1][k].direction.x())/4,
						(list[i][j][k].direction.y()+list[i+(k%2)][j+(k%2)][k+1].direction.y()+list[i-1+(k%2)][j+(k%2)][k+1].direction.y()
						+list[i][j+1][k].direction.y())/4,
						(list[i][j][k].direction.z()+list[i+(k%2)][j+(k%2)][k+1].direction.z()+list[i-1+(k%2)][j+(k%2)][k+1].direction.z()
						+list[i][j+1][k].direction.z())/4
					);
					double frm2 = (list[i][j][k].frameRad+list[i+(k%2)][j+(k%2)][k+1].frameRad+list[i-1+(k%2)][j+(k%2)][k+1].frameRad+list[i][j+1][k].frameRad)/4;
					list[i][j][k].upper[1] = new DodeMidA(pm2.dup().sub(list[i][j][k].pos), dirm2.dup(), frm2, 2);
					list[i+(k%2)][j+(k%2)][k+1].lower[2] = new DodeMidA(pm2.dup().sub(list[i+(k%2)][j+(k%2)][k+1].pos), dirm2.dup(), frm2, 2);
					list[i-1+(k%2)][j+(k%2)][k+1].lower[0] = new DodeMidA(pm2.dup().sub(list[i-1+(k%2)][j+(k%2)][k+1].pos), dirm2.dup(), frm2, 2);
					list[i][j+1][k].upper[3] = new DodeMidA(pm2.dup().sub(list[i][j+1][k].pos), dirm2.dup(), frm2, 2);
				
				}
				catch (ArrayIndexOutOfBoundsException exception){}
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
