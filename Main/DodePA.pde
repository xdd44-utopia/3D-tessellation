class DodePA {
	IVec pos;
	double radius;
	IVec[] middle;
	IVec top = new IVec(0,0,1);
	IVec bottom = new IVec(0,0,-1);

	DodePA (IVec p, double r) {
		pos = p;
		radius = r;
	}

	void transform (IVec p, IVec support) {
		IVec t = p.dup();
		radChangeFrom (t, support);
		t = p.dup();
		//offFrom(t, support);
	}

	void radChangeFrom (IVec p, IVec support) {
		double preRad = radius;
		pos.add(support);
		IVec sub = pos.dup().sub(p);
		double dist = sub.len();
		radius = radius - radius*15/sqrt((float)dist); //Radius change formula here

		top.mul(radius).div(preRad);
		bottom.mul(radius).div(preRad);
		for (int i=0;i<4;i++){
			middle[i].mul(radius).div(preRad);
		}

		pos.sub(support);
	}

	void offFrom(IVec p, IVec support) {
		pos.add(support);
		IVec sub = pos.dup().sub(p);
		double dist = sub.len();

		pos = new IVec(pos.x(), pos.y(), pos.z() + pos.z()*50/sqrt((float)dist)); //Offset formula here
		//IVec dir = sub.dup().div(dist);
		//double offDist = frameLen*10/sqrt(sqrt((float)dist)); //Offset formula here
		//dir.mul(offDist);
		//pos.add(dir);

		sub = pos.dup();
		pos.sub(support);
	}
	
	void rotateTo(IVec from, IVec to) {
		pos = rotVec(pos, from, to);
		top = rotVec(top, from, to);
		bottom = rotVec(bottom, from, to);
		for (int i=0;i<4;i++) {
			middle[i] = rotVec(middle[i], from, to);
		}
	}

}
