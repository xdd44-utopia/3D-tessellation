import processing.opengl.*;
import igeo.*;

double frameLen = 100;
int xcount = 20;
int ycount = xcount/2;
int zcount = 4;
double radius = frameLen/4;
double frameRad = 5;

void setup(){
	size(1280,720,IG.GL);
	IVec awayFromThis = new IVec(0,0,0);
	IVec X = new IVec(100,0,0);
	X.show().clr(255,0,0);
	IVec Y = new IVec(0,100,0);
	Y.show().clr(0,0,255);
	awayFromThis.show();

	Dode[][][] list = new Dode[20][10][4];

	for (int i=0;i<xcount;i++){
		for (int j=0;j<ycount;j++){
			for (int k=0;k<zcount;k++){
				list[i][j][k] = new Dode(new IVec(frameLen*i/2+(abs(k)%2)*frameLen/2,frameLen*j-(abs(i)%2)*frameLen/2,frameLen*k/2), radius, frameRad);
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
