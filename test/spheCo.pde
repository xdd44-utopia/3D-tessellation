class spheCo {
	float len;
	float theta;
	float phi;
	float alpha; //x-axis, y to z
	float beta; //y-axis, x to z
	spheCo(IVec v) {
		len = (float)v.len();
		theta = acos((float)v.z() / (float)len);
		if (v.x() != 0){
			phi = atan((float)v.y() / (float)v.x());
		}
		else {
			if (v.y() > 0) {
				phi = PI/2;
			}
			else if (v.y() < 0) {
				phi = -PI/2;
			}
			else {
				phi = 0;
			}
		}
		if (v.y() != 0){
			alpha = atan((float)v.z() / (float)v.y());
		}
		else {
			if (v.z() > 0) {
				alpha = PI/2;
			}
			else if (v.z() < 0) {
				alpha = -PI/2;
			}
			else {
				alpha = 0;
			}
		}
		if (v.x() != 0){
			alpha = atan((float)v.z() / (float)v.x());
		}
		else {
			if (v.z() > 0) {
				alpha = PI/2;
			}
			else if (v.z() < 0) {
				alpha = -PI/2;
			}
			else {
				alpha = 0;
			}
		}
	}

	IVec getVec() {
		return new IVec(len*sin(theta)*cos(phi), len*sin(theta)*sin(phi), len*cos(theta));
	}
}
