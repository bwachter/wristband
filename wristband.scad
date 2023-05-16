// this bit is rather dirty, but works for now...
module bottom_arc(link_thickness){
  difference(){
    circle(d=link_thickness*2,$fn=20);
    circle(d=link_thickness*0.1,$fn=20);
    translate([link_thickness*-2,link_thickness*-2])
      square([link_thickness*2,link_thickness*4]);
    translate([0,link_thickness*-2])
      square([link_thickness*2,link_thickness*2]);
  }
}

module half_link(link_height=13, link_size=4, link_thickness=1, top_gap=0.2){
  // uncomment to check if the link isn't too big
  //square([link_size, link_size/2]);
  linear_extrude(height=link_height){
    translate([link_thickness/2,link_thickness/2+top_gap/2]) circle(d=link_thickness, $fn=20);
    translate([0, link_thickness/2+top_gap/2]){
      square([link_thickness, link_size/2-link_thickness/2-top_gap/2]);
    }
    polygon(points=[[link_thickness/2,top_gap/2],
                    [link_size-link_thickness,link_thickness/2+top_gap/2],
                    [link_size-link_thickness,link_thickness*1.5+top_gap/2],
                    [link_thickness/2,link_thickness+top_gap/2]]);
    translate([3,link_thickness*0.6]){
      bottom_arc(link_thickness);
    }
    translate([link_size-link_thickness,0])
      square([link_thickness, link_thickness/1.5]);
  }
}

module link(link_height){

  translate([0,-4,0]) half_link(link_height);
  mirror([0,1,0]) half_link(link_height);
}

module watch_link(link_height=13, link_size=4, link_thickness=1, rod_thickness=2){
  linear_extrude(height=link_height){
    translate([link_size/2,link_size/2])
      difference(){
      circle(d=link_size, $fn=20);
      circle(d=rod_thickness, $fn=20);
    }
    translate([3,link_thickness*0.6]){
      bottom_arc(link_thickness);
    }
    translate([link_size-link_thickness,0])
      square([link_thickness, link_thickness/1.5]);
  }
}

module wristband(links, height, rod_thickness=1.6){
  translate([0,-4,0]) mirror([0,1,0]) watch_link(link_height=height, rod_thickness=rod_thickness);
  for (i=[0:links]){
    translate([0,i*4,0])
      link(link_height=height);
  }

  translate([0,links*4,0]) watch_link(link_height=height, rod_thickness=rod_thickness);
}

wristband(links=23, height=14);
