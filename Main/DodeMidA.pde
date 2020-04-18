class DodeMidA {
	IVec top;
	IVec bottom;
	Ivec[] middle;
	IVec pos;
	double radius;

	DodeMidA (IVec p, double r) {
		pos = p;
		radius = r;
		top = new IVec(0,0,sqrt(6)*radius);
		bottom = new IVec(0,0,-sqrt(6)*radius);
		middle = new IVec[4];
		middle[0] = new IVec(sqrt(6)*radius, 0, 0);
		middle[1] = new IVec(0, sqrt(6)*radius, 0);
		middle[2] = new IVec(-sqrt(6)*radius, 0, 0);
		middle[3] = new IVec(0, -sqrt(6)*radius, 0);
	}
}