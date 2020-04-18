//Rhombic dodecahedron
import processing.opengl.*;
import igeo.*;

class Ddh {
	IVec top;
	Ivec bottom;
	IVec[] lower = new IVec[4];
	IVec[] middle = new IVec[4];
	IVec[] upper = new IVec[4];

	Ddh (Ivec pos, double rad) {
		IVec dx = new IVec(rad, 0, 0);
		IVec dy = new IVec(0, rad, 0);
		IVec dz = new IVec(0, 0, rad);
		top = pos.dup().add(dz.mul(2));
		bottom = pos.dup().sub(dz.mul(2));
		middle[0] = pos.dup().add(dx.mul(2));
		middle[1] = pos.dup().add(dy.mul(2));
		middle[2] = pos.dup().sub(dx.mul(2));
		middle[3] = pos.dup().sub(dy.mul(2));
		lower[0] = pos.dup().add(dx).sub(dy).sub(dz);
		lower[1] = pos.dup().add(dx).add(dy).sub(dz);
		lower[2] = pos.dup().sub(dx).add(dy).sub(dz);
		lower[3] = pos.dup().sub(dx).sub(dy).sub(dz);
		upper[0] = pos.dup().add(dx).sub(dy).add(dz);
		upper[1] = pos.dup().add(dx).add(dy).add(dz);
		upper[2] = pos.dup().sub(dx).add(dy).add(dz);
		upper[3] = pos.dup().sub(dx).sub(dy).add(dz);
	}

	void display() {
		
	}
}
