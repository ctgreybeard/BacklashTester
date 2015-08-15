pad = 0.05; // Padding to maintain manifold
baset=0.5;
wallh=2.5;
walll=15;
wallt=0.7;
margin=1;
basex=walll+margin*2;
basey=20;

module refwall(h=2,l=5,t=0.7) {
    linear_extrude(h)
        polygon([[0,0],[l,0],[l,t],[0,t]]);
}

module testwall(h=2,l=5,t=0.7) {
    x1=0;           // origin
    x2=x1+l;        // far end
    x3=x2-l/4;      // quarter way back
    x4=x3-l/4;      // half back
    x5=x4-l/4;      // three quarters back
    
    y1=0;           // origin
    y2=y1+t;        // wall thickness
    y3=y2+t*1.5;    // extra for the "bump"

    linear_extrude(h)
        polygon([[x1,y1],[x2,y1],[x2,y2],[x3,y2],[x4,y3],[x5,y2],[x1,y2]]);
}

// base
color("paleGreen") 
linear_extrude(baset)
    polygon([[0,0],[basex,0],[basex,basey],[0,basey]],convexity=2);

// Test walls
color("lightPink",1)
for (n=[0:1]) {
    offset= n==1 ? 12 + wallt*2 : basey - wallt*2 - 12;
    translate([margin,offset,baset-pad])
        scale([1,pow(-1,n),1])
            testwall(h=wallh,l=walll,h=wallh);
}

// Reference walls
color("thistle")
for (n=[0:1]) {            
    translate([margin,n*(basey-wallt),baset-pad])
        refwall(h=wallh,l=walll,t=wallt);
}

// Origin marker
cube([margin+pad,margin,baset+wallh-pad]);