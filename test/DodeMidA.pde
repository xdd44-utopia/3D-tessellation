class DodeMidA extends DodePA{

	DodeMidA (IVec p, double r, int op) {
		super(p, r);
		op = op * 2 - 1;
		middle = new IVec[4];
		middle[0] = new IVec(sqrt(6)*radius/2, -sqrt(6)*radius/2, op*sqrt(6)*radius/2);
		middle[1] = new IVec(sqrt(6)*radius/2, sqrt(6)*radius/2, -op*sqrt(6)*radius/2);
		middle[2] = new IVec(-sqrt(6)*radius/2, sqrt(6)*radius/2, op*sqrt(6)*radius/2);
		middle[3] = new IVec(-sqrt(6)*radius/2, -sqrt(6)*radius/2, -op*sqrt(6)*radius/2);
	}

	void rotateTo(IVec from, IVec to) {
		pos = rotVec(pos,  from, to).dup();
		for (int i=0;i<4;i++) {
			middle[i] = rotVec(middle[i], from, to).dup();
		}
	}

	void display(IVec support) {
		IVec[][] controlPoints;
		for (int i=0;i<4;i++){
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = middle[i].dup().add(support);
			controlPoints[0][1] = middle[(i+1)%4].dup().add(support);
			controlPoints[1][0] = middle[(i+2)%4].dup().add(support);
			controlPoints[1][1] = middle[(i+2)%4].dup().add(support);
			new ISurface(controlPoints, 1, 1).clr(255);
		}
	}

}
