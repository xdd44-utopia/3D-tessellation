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
	IVec direction = new IVec(0,0,1);

	Dode (Option op) {
		pos = op.pos;
		dx = new IVec(op.rad, 0, 0);
		dy = new IVec(0, op.rad, 0);
		dz = new IVec(0, 0, op.rad);
		top = new DodeTopA(new IVec(0,0,0).add(dz).add(dz), op.frameRad);
		bottom = new DodeTopA(new IVec(0,0,0).sub(dz).sub(dz), op.frameRad);
		middle[0] = new DodeTopA(new IVec(0,0,0).add(dx).add(dx), op.frameRad);
		middle[1] = new DodeTopA(new IVec(0,0,0).add(dy).add(dy), op.frameRad);
		middle[2] = new DodeTopA(new IVec(0,0,0).sub(dx).sub(dx), op.frameRad);
		middle[3] = new DodeTopA(new IVec(0,0,0).sub(dy).sub(dy), op.frameRad);
		lower[0] = new DodeMidA(new IVec(0,0,0).add(dx).sub(dy).sub(dz), op.frameRad, 0);
		lower[1] = new DodeMidA(new IVec(0,0,0).add(dx).add(dy).sub(dz), op.frameRad, 1);
		lower[2] = new DodeMidA(new IVec(0,0,0).sub(dx).add(dy).sub(dz), op.frameRad, 0);
		lower[3] = new DodeMidA(new IVec(0,0,0).sub(dx).sub(dy).sub(dz), op.frameRad, 1);
		upper[0] = new DodeMidA(new IVec(0,0,0).add(dx).sub(dy).add(dz), op.frameRad, 0);
		upper[1] = new DodeMidA(new IVec(0,0,0).add(dx).add(dy).add(dz), op.frameRad, 1);
		upper[2] = new DodeMidA(new IVec(0,0,0).sub(dx).add(dy).add(dz), op.frameRad, 0);
		upper[3] = new DodeMidA(new IVec(0,0,0).sub(dx).sub(dy).add(dz), op.frameRad, 1);
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
			lower[i].pos = offFrom(lower[i].pos,p);
			middle[i].pos = offFrom(middle[i].pos,p);
			upper[i].pos = offFrom(upper[i].pos,p);
		}
	}

	IVec offFrom(IVec original, IVec p) {
		original.add(pos);
		IVec sub = original.dup().sub(p);
		double dist = sub.len();
		IVec dir = sub.dup().div(dist);
		double offDist = frameLen*5/sqrt(sqrt((float)dist)); //Offset formula here
		dir.mul(offDist);
		original.add(dir);
		original.sub(pos);
		return original;
	}

	void rotateTo(IVec towards) {
		top.rotateTo(direction, towards);
		IG.p("from"+direction);
		IG.p("to"+towards);
		bottom.rotateTo(direction, towards);
		IG.p("from"+direction);
		IG.p("to"+towards);
		println();
		for (int i=0;i<4;i++) {
			lower[i].rotateTo(direction, towards);
			IG.p("from"+direction);
			IG.p("to"+towards);
			middle[i].rotateTo(direction, towards);
			IG.p("from"+direction);
			IG.p("to"+towards);
			upper[i].rotateTo(direction, towards);
			IG.p("from"+direction);
			IG.p("to"+towards);
		}
		println();
		direction = towards.dup();
	}
}
