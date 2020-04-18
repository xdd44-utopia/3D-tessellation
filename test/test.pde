import processing.opengl.*;
import igeo.*;

size( 480, 360, IG.GL );
/*
IVec[] controlPoints1 = new IVec[4];
controlPoints1[0] = new IVec(0, 0, 0);
controlPoints1[1] = new IVec(20, 30, 30);
controlPoints1[2] = new IVec(40, -30, -30);
controlPoints1[3] = new IVec(60, 0, 0);

int deg1 = 3;
new ICurve(controlPoints1, deg1).clr(0);

IVec4[] controlPoints2 = new IVec4[4];
controlPoints2[0] = new IVec4(0, 0, 0, 1);
controlPoints2[1] = new IVec4(20, 30, 30, 0.5);
controlPoints2[2] = new IVec4(40, -30, -30, 0.5);
controlPoints2[3] = new IVec4(60, 0, 0, 1);

int deg2 = 3;
new ICurve(controlPoints2, deg2).clr(1.,0,0);
*/
IVec[][] controlPoints3 = new IVec[][]{
  new IVec[]{ new IVec(-70,0,0), new IVec(-70,20,30), new IVec(-70,40,0) },
  new IVec[]{ new IVec(-50,30,30), new IVec(-50,50,60), new IVec(-50,70,30) },
  new IVec[]{ new IVec(-30,-30,-30), new IVec(-30,-10,0), new IVec(-30,10,-30) },
  new IVec[]{ new IVec(-10,0,30), new IVec(-10,20,60), new IVec(-10,40,30) }
};

int udeg3 = 3, vdeg3 = 2;
new ISurface(controlPoints3, udeg3, vdeg3).clr(0);

IVec[][] controlPoints = new IVec[][]{
  new IVec[]{new IVec(0,0,0), new IVec(0,100,0)},
  new IVec[]{new IVec(100,0,0), new IVec(100,100,0)}
};
new ISurface(controlPoints, 1, 1).clr(0);
/*
IVec4[][] controlPoints4 = new IVec4[][]{
  new IVec4[]{ new IVec4(-70,0,0,1), new IVec4(-70,20,30,.5), new IVec4(-70,40,0,1) },
  new IVec4[]{ new IVec4(-50,30,30,.5), new IVec4(-50,50,60,.5), new IVec4(-50,70,30,.5) },
  new IVec4[]{ new IVec4(-30,-30,-30,.5), new IVec4(-30,-10,0,.5), new IVec4(-30,10,-30,.5) },
  new IVec4[]{ new IVec4(-10,0,30,1), new IVec4(-10,20,60,.5), new IVec4(-10,40,30,1) }
};

int udeg4 = 3, vdeg4 = 2;
new ISurface(controlPoints4, udeg4, vdeg4).clr(1,.5,1);*/
