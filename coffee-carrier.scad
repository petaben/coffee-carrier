$fn=50;
holderOffset = 48;
hingeOffset = 7;

translate([0,-hingeOffset,0]){
    hinge();
}

translate([0,hingeOffset,0]){
    hinge();
}

translate([holderOffset,0,0]){
    rotate([0,180,0]){
        holder();
    }
}

translate([-holderOffset,0,0]){
    rotate([180,0,0]){
        holder();
    }
}

module holder(){
    thickness = 4;
    width = 30.6;
    outerDiameter = 68;
    innerDiameter = 60;

    linear_extrude(thickness){
        difference(){
            hull(){
                circle(d=outerDiameter);
                translate([38,0,0]){
                    square([10,width], center=true);
                }
            }
            circle(d=innerDiameter);
        }
    }
}

module hinge(){
    rotate([90,0,0]){
        verticalHinge();
    }
}

module verticalHinge(){
    pinRadius = 1.5;
    clearance = 0.3;
    knuckleOuterRadius = 3;
    knuckleInnerRadius = pinRadius + clearance;
    knuckleWidth = 10;
    pinSideWidth = 3;

    leafLength = 10;
    leafHeight = 4;

    pinLength = knuckleWidth+4;
    pinSideOffset = knuckleWidth/2+pinSideWidth/2+clearance;

    translate([0,clearance,0]){
        pin();
        knuckle();
        pinSide(pinSideOffset);
        pinSide(-pinSideOffset);
        centerSection();
    }

    module pin(){
        translate([0,0,-pinLength/2]){
            linear_extrude(pinLength){
                pinSection();
            }
        }
    }

    module knuckle(){
        translate([0,0,-knuckleWidth/2]){
            linear_extrude(knuckleWidth){
                knuckleSection();
            }
        }
    }

    module centerSection(){
        linear_extrude(12, center=true){
            translate([-clearance/2, -clearance, 0]){
                polygon([
                    [-leafLength, 0],
                    [-leafLength, -leafHeight],
                    [0, -leafHeight],
                    [-leafHeight,0]
                ]);
            }
        }
    }

    module pinSide(zMove){
        rotate([0,180,0]){
            translate([0,0,-pinSideWidth/2+zMove]){
                linear_extrude(pinSideWidth){
                    roundHead();
                }
            }
        }
    }

    module pinSection(){
        circle(pinRadius);
    }

    module knuckleSection(){
        difference(){
            roundHead();
            circle(knuckleInnerRadius);
        }
    }

    module roundHead(){
        offset = leafHeight/2+clearance;
        translate([leafLength/2+clearance/2,-offset,0]){
            square([leafLength,leafHeight], center=true);
        }
        hull(){
            translate([knuckleOuterRadius/2+clearance/2,-offset,0]){
                square([knuckleOuterRadius,leafHeight], center=true);
            }
            circle(knuckleOuterRadius);
        }
    }
}

