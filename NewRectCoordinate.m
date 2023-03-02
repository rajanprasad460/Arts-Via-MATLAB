function out = NewRectCoordinate(in,lscale)

p1 = in.p1;
p2 = in.p2;
p3 = in.p3;
p4 = in.p4;

% starting line equations (Gives only the points)
L1 = @(x)(p1+(p2-p1)*x);
L2 = @(x)(p2+(p3-p2)*x);
L3 = @(x)(p3+(p4-p3)*x);
L4 = @(x)(p4+(p1-p4)*x);

% identify new line end points
out.p1 = L1(lscale);
out.p2 = L2(lscale);
out.p3 = L3(lscale);
out.p4 = L4(lscale);

end