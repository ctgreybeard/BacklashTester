pad = 0.1; // Padding to maintain manifold
smooth = 360; // Number of facets of rounding cylinder
polyl=15;
polyw=5;
polyscale=polyl/polyw;
baset=0.5;
wedgeh=2;
basex=polyl*2;
uh=5;   // Underhang
basey=polyw*2+uh;
wallt=0.7;

color("lightPink",1)
translate([polyw*polyscale,polyw+uh/2,baset-pad])
    linear_extrude(wedgeh)
        scale([polyscale,1,1]) 
            rotate(a=[0,0,30]) 
            difference() {
                circle(r=polyw,$fn=6);
                circle(r=polyw-wallt,$fn=6);
            }                

color("paleGreen") 
linear_extrude(baset)
    polygon([[0,0],[basex,0],[basex,basey],[0,basey]],convexity=2);

color("thistle")
for (n=[0:1]) {            
    translate([basex/3,n*(basey-wallt),baset])
        wall(h=wedgeh,l=basex/3,t=wallt);
}

module wall(h=2,l=5,t=0.7) {
    linear_extrude(h)
        polygon([[0,0],[l,0],[l,t],[0,t]]);
}