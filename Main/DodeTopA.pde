class DodeTopA extends DodePA{

	DodeTopA (IVec p, IVec dir, double r) {
		super(p, r);
		top = new IVec(0,0,sqrt(6)*radius);
		bottom = new IVec(0,0,-sqrt(6)*radius);
		middle = new IVec[4];
		middle[0] = new IVec(sqrt(3)*radius, -sqrt(3)*radius, 0);
		middle[1] = new IVec(sqrt(3)*radius, sqrt(3)*radius, 0);
		middle[2] = new IVec(-sqrt(3)*radius, sqrt(3)*radius, 0);
		middle[3] = new IVec(-sqrt(3)*radius, -sqrt(3)*radius, 0);
		/*
		top=rotVec(top,new IVec(0,0,1), dir);
		bottom=rotVec(bottom,new IVec(0,0,1), dir);
		for (int i=0;i<4;i++){
			middle[i]=rotVec(middle[i],new IVec(0,0,1), dir);
		}
		*/
	}

	void display(IVec support) {
		IVec[][] controlPoints;
		for (int i=0;i<4;i++){
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = top.dup().add(support);
			controlPoints[0][1] = middle[i].dup().add(support);
			controlPoints[1][0] = middle[(i+1)%4].dup().add(support);
			controlPoints[1][1] = middle[(i+1)%4].dup().add(support);
			new ISurface(controlPoints, 1, 1).clr(255);
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = bottom.dup().add(support);
			controlPoints[0][1] = middle[i].dup().add(support);
			controlPoints[1][0] = middle[(i+1)%4].dup().add(support);
			controlPoints[1][1] = middle[(i+1)%4].dup().add(support);
			new ISurface(controlPoints, 1, 1).clr(255);
		}
	}
}
