//Rhombic dodecahedron
class Dode {
	DodeTopA top;
	DodeTopA bottom;
	IVec dx, dy, dz;
	DodeMidA[] lower = new DodeMidA[4];
	DodeTopA[] middle = new DodeTopA[4];
	DodeMidA[] upper = new DodeMidA[4];
	DodeFrameA frame[] = new DodeFrameA[8];
	IVec pos;

	Dode (IVec p, double rad, double frameRad) {
		pos = p;
		dx = new IVec(rad, 0, 0);
		dy = new IVec(0, rad, 0);
		dz = new IVec(0, 0, rad);
		top = new DodeTopA(new IVec(0,0,0).add(dz).add(dz), frameRad);
		bottom = new DodeTopA(new IVec(0,0,0).sub(dz).sub(dz), frameRad);
		middle[0] = new DodeTopA(new IVec(0,0,0).add(dx).add(dx), frameRad);
		middle[1] = new DodeTopA(new IVec(0,0,0).add(dy).add(dy), frameRad);
		middle[2] = new DodeTopA(new IVec(0,0,0).sub(dx).sub(dx), frameRad);
		middle[3] = new DodeTopA(new IVec(0,0,0).sub(dy).sub(dy), frameRad);
		lower[0] = new DodeMidA(new IVec(0,0,0).add(dx).sub(dy).sub(dz), frameRad, 0);
		lower[1] = new DodeMidA(new IVec(0,0,0).add(dx).add(dy).sub(dz), frameRad, 1);
		lower[2] = new DodeMidA(new IVec(0,0,0).sub(dx).add(dy).sub(dz), frameRad, 0);
		lower[3] = new DodeMidA(new IVec(0,0,0).sub(dx).sub(dy).sub(dz), frameRad, 1);
		upper[0] = new DodeMidA(new IVec(0,0,0).add(dx).sub(dy).add(dz), frameRad, 0);
		upper[1] = new DodeMidA(new IVec(0,0,0).add(dx).add(dy).add(dz), frameRad, 1);
		upper[2] = new DodeMidA(new IVec(0,0,0).sub(dx).add(dy).add(dz), frameRad, 0);
		upper[3] = new DodeMidA(new IVec(0,0,0).sub(dx).sub(dy).add(dz), frameRad, 1);
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

	void displayFrameA(Dode[] list){
		frame[0] = new DodeFrameA(top, upper[1], 0, pos, pos);
		frame[1] = new DodeFrameA(top, upper[2], 1, pos, pos);
		frame[2] = new DodeFrameA(top, list[1].upper[1], 2, pos, list[1].pos);
		frame[3] = new DodeFrameA(top, list[0].upper[2], 3, pos, list[0].pos);
		frame[4] = new DodeFrameA(list[2].top, upper[1], 4, list[2].pos, pos);
		frame[5] = new DodeFrameA(list[4].top, upper[1], 5, list[4].pos, pos);
		frame[6] = new DodeFrameA(list[4].top, upper[2], 6, list[4].pos, pos);
		frame[7] = new DodeFrameA(list[3].top, upper[2], 7, list[3].pos, pos);
		for (int i=0;i<8;i++){
			frame[i].display();
		}
	}

	void awayXYFrom(IVec p) {
		top.pos = offXYFrom(top.pos, p);
		bottom.pos = offXYFrom(bottom.pos, p);
		for (int i=0;i<4;i++){
			lower[i].pos = offXYFrom(lower[i].pos,p);
			middle[i].pos = offXYFrom(middle[i].pos,p);
			upper[i].pos = offXYFrom(upper[i].pos,p);
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

	void awayFrom(IVec p) {
		top.pos = offFrom(top.pos, p);
		bottom.pos = offFrom(bottom.pos, p);
		for (int i=0;i<4;i++){
			lower[i].pos = offXYFrom(lower[i].pos,p);
			middle[i].pos = offXYFrom(middle[i].pos,p);
			upper[i].pos = offXYFrom(upper[i].pos,p);
		}
	}

	IVec offFrom(IVec original, IVec p) {
		original.add(pos);
		IVec sub = original.dup().sub(p);
		double dist = sub.len();
		IVec dir = sub.dup().div(dist);
		double offDist = frameLen*10/sqrt(sqrt((float)dist)); //Offset formula here
		dir.mul(offDist);
		original.add(dir);
		original.sub(pos);
		return original;
	}
}
