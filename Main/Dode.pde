//Rhombic dodecahedron
class Dode {
	IVec top;
	IVec bottom;
	IVec dx, dy, dz;
	IVec[] lower = new IVec[4];
	IVec[] middle = new IVec[4];
	IVec[] upper = new IVec[4];
	IVec pos;

	Dode (IVec p, double rad) {
		pos = p;
		dx = new IVec(rad, 0, 0);
		dy = new IVec(0, rad, 0);
		dz = new IVec(0, 0, rad);
		top = new IVec(0,0,0).add(dz).add(dz);
		bottom = new IVec(0,0,0).sub(dz).sub(dz);
		middle[0] = new IVec(0,0,0).add(dx).add(dx);
		middle[1] = new IVec(0,0,0).add(dy).add(dy);
		middle[2] = new IVec(0,0,0).sub(dx).sub(dx);
		middle[3] = new IVec(0,0,0).sub(dy).sub(dy);
		lower[0] = new IVec(0,0,0).add(dx).sub(dy).sub(dz);
		lower[1] = new IVec(0,0,0).add(dx).add(dy).sub(dz);
		lower[2] = new IVec(0,0,0).sub(dx).add(dy).sub(dz);
		lower[3] = new IVec(0,0,0).sub(dx).sub(dy).sub(dz);
		upper[0] = new IVec(0,0,0).add(dx).sub(dy).add(dz);
		upper[1] = new IVec(0,0,0).add(dx).add(dy).add(dz);
		upper[2] = new IVec(0,0,0).sub(dx).add(dy).add(dz);
		upper[3] = new IVec(0,0,0).sub(dx).sub(dy).add(dz);
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
			controlPoints[0][0] = bottom.dup().add(pos);
			controlPoints[0][1] = lower[i].dup().add(pos);
			controlPoints[1][0] = lower[(i+1)%4].dup().add(pos);
			controlPoints[1][1] = middle[i].dup().add(pos);
			new ISurface(controlPoints, 1, 1).clr(255);
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = middle[i].dup().add(pos);
			controlPoints[0][1] = lower[(i+1)%4].dup().add(pos);
			controlPoints[1][0] = upper[(i+1)%4].dup().add(pos);
			controlPoints[1][1] = middle[(i+1)%4].dup().add(pos);
			new ISurface(controlPoints, 1, 1).clr(255);
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = upper[i].dup().add(pos);
			controlPoints[0][1] = top.dup().add(pos);
			controlPoints[1][0] = middle[i].dup().add(pos);
			controlPoints[1][1] = upper[(i+1)%4].dup().add(pos);
			new ISurface(controlPoints, 1, 1).clr(255);
		}
	}

	void rotateMiddle(double angle) {
		for (int i=0;i<4;i++) {
			middle[i].rot(dz, angle);
		}
	}

	void awayXYFrom(IVec p) {
		top = offXYFrom(top, p);
		bottom = offXYFrom(bottom, p);
		for (int i=0;i<4;i++){
			lower[i] = offXYFrom(lower[i],p);
			middle[i] = offXYFrom(middle[i],p);
			upper[i] = offXYFrom(upper[i],p);
		}
	}

	IVec offXYFrom(IVec original, IVec p) {
		original.add(pos);
		IVec sub = original.dup().sub(p);
		sub.sub(new IVec(0,0,sub.z()));
		double dist = sub.len();
		IVec dir = sub.dup().div(dist);
		double offDist = frameLen*10/sqrt(sqrt((float)dist)); //Offset formula here
		dir.mul(offDist);
		original.add(dir);
		original.sub(pos);
		return original;
	}
}
