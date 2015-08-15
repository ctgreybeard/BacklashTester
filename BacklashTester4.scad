// The easiest way to change the size is to adjust the scaling below.
scalex=1.0;
scaley=1.0;
scalez=1.0; // NOTE: The Z scaling is not applied to the baseplate

wallh=2.5;              // Wall height
walll=15;               // Wall length
wallt=0.7;              // Wall thickness (should be 2 * nozzle diameter)
margin=1;               // Distance from base edge
testoffset=12;          // Testing distance (enough for caliper to use)
mingap=2;               // Minimum reasonable gap to fit caliper in
basex=walll+margin*2;   // Base X length
basey=testoffset+4*wallt+mingap*2;  // Base Y distance
baset=0.5;              // Base thickness
pad = 0.05;             // Padding to maintain manifold

// Reference wall (straight)
module refwall(h=2,l=5,t=0.7) {
    linear_extrude(h)
        polygon([[0,0],[l,0],[l,t],[0,t]]);
}

// Test Wall (has a bump)
module testwall(h=2,l=5,t=0.7) {
    testlen=5;
    x1=0;           // origin
    x2=x1+testlen;  // left side test landing
    x3=x2+3;        // middle downramp
    x4=x3+1.1;      // middle upramp
    x5=x4+testlen;  // right side testlanding
    x6=x5+1;        // upramp
    
    y1=0;           // origin
    y2=y1+t/2;      // wall thickness
    y3=y2+t;        // test landings
    y4=y3+t;        // Ramp peak

    linear_extrude(h)
        polygon([[x1,y1],[x6,y1],[x6,y2],[x5,y3],[x4,y3],[x3,y4],[x2,y3],[x1,y3]],convexity=4);
}

// The widget
scale([scalex,scaley,1.0])  // Apply X and Y scales
union() {
    // base
    color("paleGreen") 
    linear_extrude(baset)
        difference() {
            polygon([[0,0],[basex,0],[basex,basey],[0,basey]],convexity=2);
            polygon([[0,0],[margin,0],[0,margin]]);
        }
    
    // Test walls
    union() {
        color("lightPink",1)
        for (n=[0:1]) {
            offset= n==1 ? testoffset + wallt*2 : basey - wallt*2 - testoffset;
            translate([margin+n*walll,offset,baset-pad])
                scale([pow(-1,n),pow(-1,n),1])
                    testwall(h=wallh*scalez,l=walll,t=wallt);
        }
        
        // Reference walls
        color("thistle")
        for (n=[0:1]) {
            translate([margin,n*(basey-wallt),baset-pad])
                refwall(h=wallh*scalez,l=walll,t=wallt);
        }
    }
}