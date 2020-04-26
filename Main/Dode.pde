//Rhombic dodecahedron
class Dode {
	//Independent attributes
	IVec pos;
	Double radius;
	Double frameRad;
	IVec direction = new IVec(0,0,1);
	IVec idx;
	//Depentent attributes
	DodeTopA top;
	DodeTopA bottom;
	DodeMidA[] lower = new DodeMidA[4];
	DodeTopA[] middle = new DodeTopA[4];
	DodeMidA[] upper = new DodeMidA[4];
	
	Dode (IVec p, double r, double fr, IVec i) {
		pos = p;
		radius = r;
		frameRad = fr;
		idx = i;
		top = null;
		bottom = null;
		for (int j=0;j<4;j++){
			lower[j] = null;
			middle[j] = null;
			upper[j] = null;
		}
	}

	void display() {
		IVec[][] controlPoints;
		for (int i=0;i<4;i++){
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = bottom.pos.dup().add(pos);
			controlPoints[0][1] = lower[i].pos.dup().add(pos);
			controlPoints[1][0] = lower[(i+1)%4].pos.dup().add(pos);
			controlPoints[1][1] = middle[i].pos.dup().add(pos);
			new ISurface(controlPoints, 1, 1).clr(255);
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = middle[i].pos.dup().add(pos);
			controlPoints[0][1] = lower[(i+1)%4].pos.dup().add(pos);
			controlPoints[1][0] = upper[(i+1)%4].pos.dup().add(pos);
			controlPoints[1][1] = middle[(i+1)%4].pos.dup().add(pos);
			new ISurface(controlPoints, 1, 1).clr(255);
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = upper[i].pos.dup().add(pos);
			controlPoints[0][1] = top.pos.dup().add(pos);
			controlPoints[1][0] = middle[i].pos.dup().add(pos);
			controlPoints[1][1] = upper[(i+1)%4].pos.dup().add(pos);
			new ISurface(controlPoints, 1, 1).clr(255);
		}
	}

	void displayFrameA() {
		IVec[][] controlPoints;
		for (int i=0;i<4;i++){
			if (top != null && upper[i] != null){
				controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
				controlPoints[0][0] = top.middle[i].dup().add(top.pos).add(pos);
				controlPoints[0][1] = top.middle[(i+1)%4].dup().add(top.pos).add(pos);
				controlPoints[1][0] = upper[i].middle[(i+3)%4].dup().add(upper[i].pos).add(pos);
				controlPoints[1][1] = upper[i].middle[(i+1)%4].dup().add(upper[i].pos).add(pos);
				new ISurface(controlPoints, 1, 1).clr(255);
				controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
				controlPoints[0][0] = top.middle[i].dup().add(top.pos).add(pos);
				controlPoints[0][1] = top.bottom.dup().add(top.pos).add(pos);
				controlPoints[1][0] = upper[i].middle[(i+3)%4].dup().add(upper[i].pos).add(pos);
				controlPoints[1][1] = upper[i].middle[(i+2)%4].dup().add(upper[i].pos).add(pos);
				new ISurface(controlPoints, 1, 1).clr(255);
				controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
				controlPoints[0][0] = top.bottom.dup().add(top.pos).add(pos);
				controlPoints[0][1] = top.middle[(i+1)%4].dup().add(top.pos).add(pos);
				controlPoints[1][0] = upper[i].middle[(i+2)%4].dup().add(upper[i].pos).add(pos);
				controlPoints[1][1] = upper[i].middle[(i+1)%4].dup().add(upper[i].pos).add(pos);
				new ISurface(controlPoints, 1, 1).clr(255);
			}
		}
		for (int i=0;i<2;i++){
			if (middle[i] != null && upper[i] != null){
				controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
				controlPoints[0][0] = middle[i].middle[(i+2)%4].dup().add(middle[i].pos).add(pos);
				controlPoints[0][1] = middle[i].middle[(i+1)%4].dup().add(middle[i].pos).add(pos);
				controlPoints[1][0] = upper[i].middle[(i+2)%4].dup().add(upper[i].pos).add(pos);
				controlPoints[1][1] = upper[i].middle[i].dup().add(upper[i].pos).add(pos);
				new ISurface(controlPoints, 1, 1).clr(255);
				controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
				controlPoints[0][0] = middle[i].top.dup().add(middle[i].pos).add(pos);
				controlPoints[0][1] = middle[i].middle[(i+2)%4].dup().add(middle[i].pos).add(pos);
				controlPoints[1][0] = upper[i].middle[(i+3)%4].dup().add(upper[i].pos).add(pos);
				controlPoints[1][1] = upper[i].middle[(i+2)%4].dup().add(upper[i].pos).add(pos);
				new ISurface(controlPoints, 1, 1).clr(255);
				controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
				controlPoints[0][0] = middle[i].top.dup().add(middle[i].pos).add(pos);
				controlPoints[0][1] = middle[i].middle[(i+1)%4].dup().add(middle[i].pos).add(pos);
				controlPoints[1][0] = upper[i].middle[(i+3)%4].dup().add(upper[i].pos).add(pos);
				controlPoints[1][1] = upper[i].middle[i].dup().add(upper[i].pos).add(pos);
				new ISurface(controlPoints, 1, 1).clr(255);
			}
		}
		for (int i=0;i<2;i++){
			if (middle[(i+1)%4] != null && upper[i] != null){
				controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
				controlPoints[0][0] = middle[(i+1)%4].middle[(i+3)%4].dup().add(middle[(i+1)%4].pos).add(pos);
				controlPoints[0][1] = middle[(i+1)%4].middle[i].dup().add(middle[(i+1)%4].pos).add(pos);
				controlPoints[1][0] = upper[i].middle[(i+2)%4].dup().add(upper[i].pos).add(pos);
				controlPoints[1][1] = upper[i].middle[i].dup().add(upper[i].pos).add(pos);
				new ISurface(controlPoints, 1, 1).clr(255);
				controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
				controlPoints[0][0] = middle[(i+1)%4].top.dup().add(middle[(i+1)%4].pos).add(pos);
				controlPoints[0][1] = middle[(i+1)%4].middle[(i+3)%4].dup().add(middle[(i+1)%4].pos).add(pos);
				controlPoints[1][0] = upper[i].middle[(i+1)%4].dup().add(upper[i].pos).add(pos);
				controlPoints[1][1] = upper[i].middle[(i+2)%4].dup().add(upper[i].pos).add(pos);
				new ISurface(controlPoints, 1, 1).clr(255);
				controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
				controlPoints[0][0] = middle[(i+1)%4].top.dup().add(middle[(i+1)%4].pos).add(pos);
				controlPoints[0][1] = middle[(i+1)%4].middle[i].dup().add(middle[(i+1)%4].pos).add(pos);
				controlPoints[1][0] = upper[i].middle[(i+1)%4].dup().add(upper[i].pos).add(pos);
				controlPoints[1][1] = upper[i].middle[i].dup().add(upper[i].pos).add(pos);
				new ISurface(controlPoints, 1, 1).clr(255);
			}
		}
	}
}
