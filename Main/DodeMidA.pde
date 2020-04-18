class DodeMidA {
	IVec[] middle;
	IVec pos;
	double radius;

	DodeMidA (IVec p, double r, int op) {
		pos = p;
		radius = r;
		op = op * 2 - 1;
		middle = new IVec[4];
		middle[0] = new IVec(sqrt(6)*radius/2, -sqrt(6)*radius/2, op*sqrt(6)*radius/2);
		middle[1] = new IVec(sqrt(6)*radius/2, sqrt(6)*radius/2, -op*sqrt(6)*radius/2);
		middle[2] = new IVec(-sqrt(6)*radius/2, sqrt(6)*radius/2, op*sqrt(6)*radius/2);
		middle[3] = new IVec(-sqrt(6)*radius/2, -sqrt(6)*radius/2, -op*sqrt(6)*radius/2);
	}
}
