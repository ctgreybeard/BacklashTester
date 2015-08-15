pad = 0.05; // Padding to maintain manifold
smooth = 360; // Number of facets of rounding cylinder
baset=0.5;
wallh=2;
walll=10;
wallt=0.7;
margin=1;
basex=walll+margin*2;
basey=15;

module refwall(h=2,l=5,t=0.7) {
    linear_extrude(h)
        polygon([[0,0],[l,0],[l,t],[0,t]]);
}

module testwall(h=2,l=5,t=0.7,seg=3) {
    segl=l/seg;
    linear_extrude(h)
    for (s=[0:seg-1]) {
        x1=s*segl;
        x2=x1+segl;
        y1=(pow(-1,s)*t)/4;
        y2=y1+t;
        translate([-s*pad,0,0])
        polygon([[x1,y1],[x2,y1],[x2,y2],[x1,y2]]);
    }
}

color("paleGreen") 
linear_extrude(baset)
    polygon([[0,0],[basex,0],[basex,basey],[0,basey]],convexity=2);

color("lightPink",1)
for (n=[0:1]) {
    offset= n==0 ? 10 + wallt : basey - wallt - 10;
translate([margin,offset,baset-pad])
    scale([1,pow(-1,n),1])
        testwall(h=wallh,l=walll,h=wallh);
}

color("thistle")
for (n=[0:1]) {            
    translate([margin,n*(basey-wallt),baset-pad])
        refwall(h=wallh,l=walll,t=wallt);
}

