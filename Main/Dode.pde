//Rhombic dodecahedron
class Dode {
	IVec top;
	IVec bottom;
	IVec[] lower = new IVec[4];
	IVec[] middle = new IVec[4];
	IVec[] upper = new IVec[4];

	Dode (IVec pos, double rad) {
		IVec dx = new IVec(rad, 0, 0);
		IVec dy = new IVec(0, rad, 0);
		IVec dz = new IVec(0, 0, rad);
		top = pos.dup().add(dz).add(dz);
		bottom = pos.dup().sub(dz).sub(dz);
		middle[0] = pos.dup().add(dx).add(dx);
		middle[1] = pos.dup().add(dy).add(dy);
		middle[2] = pos.dup().sub(dx).sub(dx);
		middle[3] = pos.dup().sub(dy).sub(dy);
		lower[0] = pos.dup().add(dx).sub(dy).sub(dz);
		lower[1] = pos.dup().add(dx).add(dy).sub(dz);
		lower[2] = pos.dup().sub(dx).add(dy).sub(dz);
		lower[3] = pos.dup().sub(dx).sub(dy).sub(dz);
		upper[0] = pos.dup().add(dx).sub(dy).add(dz);
		upper[1] = pos.dup().add(dx).add(dy).add(dz);
		upper[2] = pos.dup().sub(dx).add(dy).add(dz);
		upper[3] = pos.dup().sub(dx).sub(dy).add(dz);
	}

	void displayVec() {
		top.show().clr(0,0,255);
		bottom.show().clr(255,0,0);
		for (int i=0;i<4;i++){
			lower[i].show();
			middle[i].show();
			upper[i].show();
		}
	}

	void display() {
		IVec[][] controlPoints;
		for (int i=0;i<4;i++){
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = bottom.dup();
			controlPoints[0][1] = lower[i].dup();
			controlPoints[1][0] = lower[(i+1)%4].dup();
			controlPoints[1][1] = middle[i].dup();
			new ISurface(controlPoints, 1, 1).clr(255);
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = middle[i].dup();
			controlPoints[0][1] = lower[(i+1)%4].dup();
			controlPoints[1][0] = upper[(i+1)%4].dup();
			controlPoints[1][1] = middle[(i+1)%4].dup();
			new ISurface(controlPoints, 1, 1).clr(255);
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = upper[i].dup();
			controlPoints[0][1] = top.dup();
			controlPoints[1][0] = middle[i].dup();
			controlPoints[1][1] = upper[(i+1)%4].dup();
			new ISurface(controlPoints, 1, 1).clr(255);
		}
	}
}
