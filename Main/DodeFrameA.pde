class DodeFrameA {
	IVec[] top;
	IVec[] end;
	DodeFrameA (DodeTopA tp, DodeMidA ed, int op, IVec tSupport, IVec eSupport) {
		top = new IVec[3];
		end = new IVec[3];
		if (op < 4) {
			top[0] = tp.middle[op].dup().add(tp.pos);
			top[1] = tp.middle[(op+1)%4].dup().add(tp.pos);
			top[2] = tp.bottom.dup().add(tp.pos);
			end[0] = ed.middle[op].dup().add(ed.pos);
			end[1] = ed.middle[(op+2)%4].dup().add(ed.pos);
			end[2] = ed.middle[(op+3)%4].dup().add(ed.pos);
		}
		else {
			op -= 4;
			top[0] = tp.top.dup().add(tp.pos);
			switch (op) {
				case 0:
					top[1] = tp.middle[1].dup().add(tp.pos);
					top[2] = tp.middle[2].dup().add(tp.pos);
					end[0] = ed.middle[0].dup().add(ed.pos);
					end[1] = ed.middle[1].dup().add(ed.pos);
					end[2] = ed.middle[3].dup().add(ed.pos);
					break;
				case 1:
					top[1] = tp.middle[0].dup().add(tp.pos);
					top[2] = tp.middle[3].dup().add(tp.pos);
					end[0] = ed.middle[2].dup().add(ed.pos);
					end[1] = ed.middle[1].dup().add(ed.pos);
					end[2] = ed.middle[3].dup().add(ed.pos);
					break;
				case 2:
					top[1] = tp.middle[2].dup().add(tp.pos);
					top[2] = tp.middle[3].dup().add(tp.pos);
					end[0] = ed.middle[1].dup().add(ed.pos);
					end[1] = ed.middle[2].dup().add(ed.pos);
					end[2] = ed.middle[0].dup().add(ed.pos);
					break;
				case 3:
					top[1] = tp.middle[1].dup().add(tp.pos);
					top[2] = tp.middle[0].dup().add(tp.pos);
					end[0] = ed.middle[3].dup().add(ed.pos);
					end[1] = ed.middle[2].dup().add(ed.pos);
					end[2] = ed.middle[0].dup().add(ed.pos);
					break;
			}
		}
		for (int i=0;i<3;i++){
			top[i].add(tSupport);
			end[i].add(eSupport);
		}
	}

	void display() {
		IVec[][] controlPoints;
		for (int i=0;i<3;i++){
			controlPoints = new IVec[][]{new IVec[2], new IVec[2]};
			controlPoints[0][0] = top[i].dup();
			controlPoints[0][1] = top[(i+1)%3].dup();
			controlPoints[1][0] = end[i].dup();
			controlPoints[1][1] = end[(i+1)%3].dup();
			new ISurface(controlPoints, 1, 1).clr(255);
		}
	}
}
