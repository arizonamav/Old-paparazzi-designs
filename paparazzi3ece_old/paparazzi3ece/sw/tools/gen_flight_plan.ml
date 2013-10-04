(*
 * $Id: gen_flight_plan.ml,v 1.53 2007/01/31 15:52:54 hecto Exp $
 *
 * Flight plan preprocessing (from XML to C)
 *  
 * Copyright (C) 2004 CENA/ENAC, Pascal Brisset, Antoine Drouin
 *
 * This file is part of paparazzi.
 *
 * paparazzi is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * paparazzi is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with paparazzi; see the file COPYING.  If not, write to
 * the Free Software Foundation, 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA. 
 *
 *)

open Printf
open Latlong

module G2D = Geometry_2d

let sof = string_of_float
let soi = string_of_int

let check_expressions = ref true

let parse_expression = Fp_proc.parse_expression

let parse = fun s ->
  if !check_expressions then
    let e = parse_expression s in
    let unexpected = fun kind x ->
      fprintf stderr "Parsing error in '%s': unexpected %s: '%s' \n" s kind x;
      exit 1 in
    begin
      try
	Fp_syntax.check_expression e
      with
	Fp_syntax.Unknown_operator x -> unexpected "operator" x
      | Fp_syntax.Unknown_ident x -> unexpected "ident" x
      | Fp_syntax.Unknown_function x -> unexpected "function" x
    end;
    Fp_syntax.sprint_expression e
  else
    s

let parsed_attrib = fun xml a ->
  parse (ExtXml.attrib xml a)

let pi = atan 1. *. 4.

let deg_of_rad = fun r ->
  r /. pi *. 180.

let gen_label =
  let x = ref 0 in
  fun p -> incr x; sprintf "%s_%d" p !x

let margin = ref 0
let step = 2

let right () = margin := !margin + step
let left () = margin := !margin - step

let lprintf = fun f ->
  printf "%s" (String.make !margin ' ');
  printf f

let float_attrib = fun xml a -> float_of_string (Xml.attrib xml a)
let name_of = fun wp -> ExtXml.attrib wp "name"


let ground_alt = ref 0.
let security_height = ref 0.

let check_altitude = fun a x ->
  if a < !ground_alt +. !security_height then begin
    fprintf stderr "\nWARNING: low altitude (%.0f<%.0f+%.0f) in %s\n\n" a !ground_alt !security_height (Xml.to_string x)
  end


let print_waypoint = fun rel_utm_of_wgs84 default_alt waypoint ->
  let (x, y) =
    try
      rel_utm_of_wgs84 {posn_lat=(Deg>>Rad)(float_attrib waypoint "lat");
			posn_long=(Deg>>Rad)(float_attrib waypoint "lon") }
    with
      Xml.No_attribute "lat" | Xml.No_attribute "lon" ->
	(float_attrib waypoint "x", float_attrib waypoint "y")
  and alt = try Xml.attrib waypoint "alt" with _ -> default_alt in
  check_altitude (float_of_string alt) waypoint;
  printf " {%.1f, %.1f, %s},\\\n" x y alt


let index_of_blocks = ref []

let get_index_block = fun x ->
  try
    string_of_int (List.assoc x !index_of_blocks)
  with
    Not_found -> failwith (sprintf "Unknown block: '%s'" x)

let print_exception = fun x ->
  let i = get_index_block (ExtXml.attrib x "deroute") in
  let c = parsed_attrib x "cond" in
  lprintf "if ((nav_block!=%s) && %s) { GotoBlock(%s) }\n" i c i

let goto l = Xml.Element ("goto", ["name",l], [])
let exit_block = Xml.Element ("exit_block", [], [])
  
let stage = ref 0

let output_label l = lprintf "Label(%s)\n" l

let get_index_waypoint = fun x l ->
  try
    string_of_int (List.assoc x l)
  with
    Not_found -> failwith (sprintf "Unknown waypoint: %s" x)

let output_cam_mode = fun x index_of_waypoints ->
  let m =  try Xml.attrib x "cam_mode" with _ -> "fix" in
  match m with
    "null" -> lprintf "CamNull();\n";
  | "fix" -> lprintf "CamFix();\n";
  | "manual" -> lprintf "cam_manual();\n"
  | "nadir" -> lprintf "cam_nadir();\n"
  | "target" ->
      if Xml.tag x = "xyz" then
	lprintf "cam_carrot();\n"
      else begin
	try 
	  let wp = Xml.attrib x "target" in
	  let i = get_index_waypoint wp index_of_waypoints in
	  lprintf "cam_waypoint_target(%s);\n" i
	with _ ->
	  lprintf "cam_manual_target();\n"
      end
  | "follow" ->
      let i = ExtXml.attrib x "cam_ac_target" in
      lprintf "cam_ac_target(%s);\n" i
  | _ -> failwith (sprintf "Error: unknown '%s' cam mode" m)

let pprz_throttle = fun s ->
  let g = float_of_string s in
  if g < 0. || g > 1. then
    failwith "throttle must be > 0 and < 1";
  g*. 9600.

let output_vmode x wp last_wp =
  let pitch = try Xml.attrib x "pitch" with _ -> "0.0" in
  if pitch = "auto"
  then begin
    lprintf "NavVerticalAutoPitchMode(%.0f);\n" (pprz_throttle (parsed_attrib x "throttle"))
  end else begin
    lprintf "NavVerticalAutoThrottleMode(%s);\n" (parse pitch);
  end;
  let vmode = try ExtXml.attrib x "vmode" with _ -> "alt" in
  begin
    match vmode with
      "climb" ->
	lprintf "NavVerticalClimbMode(%s);\n" (parsed_attrib x "climb")
    | "alt" ->
	let alt =
	  try
	    let a = parsed_attrib x "alt" in
	    begin
	      try
		check_altitude (float_of_string a) x
	      with
		(* Impossible to check the altitude on an expression: *)
		Failure "float_of_string" -> ()
	    end;
	    a
	  with _ ->
	    if wp = "" 
	    then failwith "alt or waypoint required in alt vmode" 
	    else sprintf "WaypointAlt(%s)" wp in
	lprintf "NavVerticalAltitudeMode(%s, 0.);\n" alt;
    | "xyz" -> () (** Handled in Goto3D() *)
    | "glide" ->
	lprintf "NavGlide(%s, %s);\n" last_wp wp
    | "throttle" ->
	if (pitch = "auto") then
	  failwith "auto pich mode not compatible with vmode=throttle";
	lprintf "NavVerticalThrottleMode(%.0f);\n" (pprz_throttle (parsed_attrib x "throttle"))
    | x -> failwith (sprintf "Unknown vmode '%s'" x)
  end;
  vmode
	  
let output_hmode x wp last_wp =
  try
    let hmode = ExtXml.attrib x "hmode" in
    begin
      match hmode with
	"route" ->
	  if last_wp = "last_wp" then
	    fprintf stderr "WARNING: Deprecated use of 'route' using last waypoint in %s\n"(Xml.to_string x);
	  lprintf "NavSegment(%s, %s);\n" last_wp wp
      | "direct" -> lprintf "NavGotoWaypoint(%s);\n" wp
      | x -> failwith (sprintf "Unknown hmode '%s'" x)
    end;
    hmode
  with
    ExtXml.Error _ -> lprintf "NavGotoWaypoint(%s);\n" wp; "direct" (* Default behaviour *)
	  


	
let rec index_stage = fun x ->
  begin
    match Xml.tag x with
     "for" ->
       incr stage; (* Init of i *)
       incr stage;
       let n = !stage in
       let l = List.map index_stage (Xml.children x) in
       incr stage; (* To count the loop stage *)
       Xml.Element (Xml.tag x, Xml.attribs x@["no", soi n], l)
    | "while" ->
       incr stage;
       let n = !stage in
       let l = List.map index_stage (Xml.children x) in
       incr stage; (* To count the loop stage *)
       Xml.Element (Xml.tag x, Xml.attribs x@["no", soi n], l)
    | "return" | "goto"  | "deroute" | "exit_block" | "follow" | "call"
    | "heading" | "attitude" | "go" | "stay" | "xyz" | "set" | "circle" ->
	incr stage;
	Xml.Element (Xml.tag x, Xml.attribs x@["no", soi !stage], Xml.children x)
    | "survey_rectangle" | "eight" | "oval"->
	incr stage; incr stage;
	Xml.Element (Xml.tag x, Xml.attribs x@["no", soi !stage], Xml.children x)
    | "exception" ->
	x
    | s -> failwith (sprintf "Unknown stage: %s\n" s)
  end


let inside_function = fun name -> "Inside" ^ String.capitalize name

let rec print_stage = fun index_of_waypoints x ->
  let stage () = incr stage;lprintf "Stage(%d)\n" !stage; right () in
  begin
    match String.lowercase (Xml.tag x) with
      "return" ->
	stage ();
	lprintf "Return()\n"
    | "goto" ->
	stage ();
	lprintf "Goto(%s)\n" (name_of x)
    | "deroute" ->
	stage ();
	lprintf "GotoBlock(%s)\n" (get_index_block (ExtXml.attrib x "block"))
    | "exit_block" ->
	stage ();
	lprintf "NextBlock()\n"
    | "while" ->
	let w = gen_label "while" in
	let e = gen_label "endwhile" in
	output_label w;
	stage ();
	let c = try parsed_attrib x "cond" with _ -> "TRUE" in
	lprintf "if (! (%s)) Goto(%s) else NextStage();\n" c e;
	List.iter (print_stage index_of_waypoints) (Xml.children x);
	print_stage index_of_waypoints (goto w);
	output_label e
    | "for" ->
	let f = gen_label "for" in
	let e = gen_label "endfor" in
	let v = Fp_syntax.c_var_of_ident (ExtXml.attrib x "var")
	and from_ = parsed_attrib x "from" 
	and to_expr = parsed_attrib x "to"  in
	let to_var = v ^ "_to" in
	lprintf "static int8_t %s;\n" v;
	lprintf "static int8_t %s;\n" to_var;
	
	(* init *)
	stage ();
	lprintf "%s = %s - 1;\n" v from_;
	lprintf "%s = %s;\n" to_var to_expr;
	left ();

	output_label f;
	stage ();
	lprintf "if (++%s > %s) Goto(%s) else NextStage();\n" v to_var e;
	List.iter (print_stage index_of_waypoints) (Xml.children x);
	print_stage index_of_waypoints (goto f);
	output_label e
    | "heading" ->
	stage ();
	let until = parsed_attrib x "until" in
	lprintf "if (%s) NextStage() else {\n" until;
	right (); 
	lprintf "h_ctl_course_setpoint = RadOfDeg(%s);\n" (parsed_attrib x "course");
	ignore (output_vmode x "" "");
	output_cam_mode x index_of_waypoints;
	left (); lprintf "}\n";
	lprintf "return;\n"
    | "follow" ->
	stage ();
	let id = ExtXml.attrib x "ac_id"
	and d = ExtXml.attrib x "distance"
	and h = ExtXml.attrib x "height" in
	lprintf "NavFollow(%s, %s, %s);\n" id d h;
	output_cam_mode x index_of_waypoints;
	lprintf "return;\n"
    | "attitude" ->
	stage ();
	begin
	  try
	    let until = parsed_attrib x "until" in
	    lprintf "if (%s) NextStage() else {\n" until;
	  with ExtXml.Error _ ->
	    lprintf "{\n"
	end;
	right ();
	lprintf "lateral_mode = LATERAL_MODE_ROLL;\n";
	lprintf "h_ctl_roll_setpoint = RadOfDeg(%s);\n" (parsed_attrib x "roll");
	ignore (output_vmode x "" "");
	output_cam_mode x index_of_waypoints;
	left (); lprintf "}\n";
	lprintf "return;\n"
    | "go" ->
	stage ();
	let wp = 
	  try
	    get_index_waypoint (ExtXml.attrib x "wp") index_of_waypoints
	  with
	    ExtXml.Error _ ->
	      lprintf "waypoints[0].x = %s;\n" (parsed_attrib x "x");
	      lprintf "waypoints[0].y = %s;\n" (parsed_attrib x "y");
	      "0"
	in
	let at = try ExtXml.attrib x "approaching_time" with _ -> "CARROT" in
	lprintf "if (NavApproaching(%s,%s)) NextStageFrom(%s) else {\n" wp at wp;
	right ();
	let last_wp =
	  try
	    get_index_waypoint (ExtXml.attrib x "from") index_of_waypoints
	  with _ -> "last_wp" in
	let hmode = output_hmode x wp last_wp in
	let vmode = output_vmode x wp last_wp in
	if vmode = "glide" && hmode <> "route" then
	  failwith "glide vmode requires route hmode";
	output_cam_mode x index_of_waypoints;
	left (); lprintf "}\n";
	lprintf "return;\n"
    | "stay" ->
	stage ();
	begin
	  try
	    let wp = get_index_waypoint (ExtXml.attrib x "wp") index_of_waypoints in
	    ignore (output_hmode x wp "");
	    ignore (output_vmode x wp "");
	  with
	    Xml2h.Error _ ->
	      lprintf "NavGotoXY(last_x, last_y);\n";
		ignore(output_vmode x "" "")
	end;
	lprintf "return;\n"
    | "xyz" ->
	stage ();
	let r = try parsed_attrib  x "radius" with _ -> "100" in
	lprintf "Goto3D(%s)\n" r;
	let x = ExtXml.subst_attrib "vmode" "xyz" x in
	ignore (output_vmode x "" ""); (** To handle "pitch" *)
	output_cam_mode x index_of_waypoints;
	lprintf "return;\n"
    | "circle" ->
	stage ();
	let wp = get_index_waypoint (ExtXml.attrib x "wp") index_of_waypoints in
	let r = parsed_attrib  x "radius" in
	let _vmode = output_vmode x wp "" in
	lprintf "NavCircleWaypoint(%s, %s);\n" wp r;
	begin
	  try
	    let c = parsed_attrib x "until" in
	    lprintf "if (%s) NextStage();\n" c
	  with
	    ExtXml.Error _ -> ()
	end;
	output_cam_mode x index_of_waypoints;
	lprintf "return;\n"
    | "eight" ->
	stage ();
	lprintf "nav_eight_init();\n";
	lprintf "NextStage();\n";
	left ();
	stage ();
	let center = get_index_waypoint (ExtXml.attrib x "center") index_of_waypoints
	and turn_about = get_index_waypoint (ExtXml.attrib x "turn_around") index_of_waypoints in
	let r = parsed_attrib  x "radius" in
	let _vmode = output_vmode x center "" in
	lprintf "Eight(%s, %s, %s);\n" center turn_about r;
	output_cam_mode x index_of_waypoints;
	lprintf "return;\n"
    | "oval" ->
	stage ();
	lprintf "nav_oval_init();\n";
	lprintf "NextStage();\n";
	left ();
	stage ();
	let p1 = get_index_waypoint (ExtXml.attrib x "p1") index_of_waypoints
	and p2 = get_index_waypoint (ExtXml.attrib x "p2") index_of_waypoints in
	let r = parsed_attrib  x "radius" in
	let _vmode = output_vmode x p1 "" in
	lprintf "Oval(%s, %s, %s);\n" p1 p2 r;
	output_cam_mode x index_of_waypoints;
	lprintf "return;\n"
    | "set" ->
	stage ();
	let var = ExtXml.attrib  x "var"
	and value = ExtXml.attrib  x "value" in
	lprintf "%s = %s;\n" var value;
	lprintf "NextStage();\n";
	lprintf "return;\n"
    | "call" ->
	stage ();
	let statement = ExtXml.attrib  x "fun" in
	lprintf "if (! (%s))\n" statement;
	lprintf "  NextStage();\n";
	lprintf "return;\n"
    | "survey_rectangle" ->
	let grid = parsed_attrib x "grid"
	and wp1 = get_index_waypoint (ExtXml.attrib x "wp1") index_of_waypoints
	and wp2 = get_index_waypoint (ExtXml.attrib x "wp2") index_of_waypoints in
	stage ();
	lprintf "NavSurveyRectangleInit(%s, %s, %s);\n" wp1 wp2 grid;
	lprintf "NextStage();\n";
	left ();
	stage ();
	lprintf "NavSurveyRectangle(%s, %s);\n" wp1 wp2;
	lprintf "return;\n"
    | _s -> failwith "Unreachable"
  end;
  left ()


let indexed_stages = fun blocks ->
  let lstages = ref [] in
  List.iter
    (fun b ->
      let block_name = name_of b
      and block_no = ExtXml.attrib b "no" in
      let rec f = fun stage ->
	try
	  let stage_no = Xml.attrib stage "no" in
	  lstages :=
	    Xml.Element ("stage", [ "block", block_no;
				    "block_name", block_name;
				    "stage", stage_no], [stage]):: !lstages;
	  if (ExtXml.tag_is stage "for" || ExtXml.tag_is stage "while") then
	    List.iter f (Xml.children stage)
	with Xml.No_attribute "no" ->
	  assert (ExtXml.tag_is stage "exception")
      in
      List.iter f (Xml.children b))
    blocks;
  !lstages
    



let index_blocks = fun xml ->
  let block = ref (-1) in
  let indexed_blocks =
    List.map
      (fun b ->
	incr block;
	let name = name_of b in
	if List.mem_assoc name !index_of_blocks then
	  failwith (Printf.sprintf "Error in flight plan: Block '%s' defined twice" name);
	index_of_blocks := (name, !block) :: !index_of_blocks;
	stage := -1;
	let indexed_stages = List.map index_stage (Xml.children b) in
	Xml.Element (Xml.tag b, Xml.attribs b@["no", soi !block], indexed_stages))
      (Xml.children xml) in
  Xml.Element (Xml.tag xml, Xml.attribs xml, indexed_blocks)
  


let print_block = fun index_of_waypoints (b:Xml.xml) block_num ->
  let n = name_of b in
  lprintf "Block(%d) // %s\n" block_num n;

  let excpts, stages =
    List.partition (fun x -> Xml.tag x = "exception") (Xml.children b) in

  List.iter print_exception excpts;

  lprintf "switch(nav_stage) {\n";
  right ();
  stage := (-1);
  List.iter (print_stage index_of_waypoints) stages;

  print_stage index_of_waypoints exit_block;

  left (); lprintf "}\n\n"



let print_blocks = fun index_of_waypoints bs ->
  let block = ref (-1) in
  List.iter (fun b -> incr block; print_block index_of_waypoints b !block) bs

let c_suffix =
  let r = Str.regexp "^[a-zA-Z0-9_]*$" in
  fun s -> Str.string_match r s 0

let define_waypoints_indices = fun wpts ->
  let i = ref 0 in
  List.iter (fun w ->
    let n = name_of w in
    if c_suffix n then
      Xml2h.define (sprintf "WP_%s" n) (string_of_int !i);
    incr i)
    wpts

let home = fun waypoints ->
  let rec loop i = function
      [] -> failwith "Waypoint 'HOME' required"
    | w::ws ->
	if name_of w = "HOME" then
	  (float_attrib w "x", float_attrib w "y")
	else
	  loop (i+1) ws in
  loop 0 waypoints


let check_distance = fun (hx, hy) max_d wp ->
  let x = float_attrib wp "x"
  and y = float_attrib wp "y" in
  let d = sqrt ((x-.hx)**2. +. (y-.hy)**2.) in
  if d > max_d then
    fprintf stderr "\nWARNING: Waypoint '%s' too far from HOME (%.0f>%.0f)\n\n" (name_of wp) d max_d
  

(* Check coherence between global ref and waypoints ref *)
(* Returns a patched xml with utm_x0 and utm_y0 set *)
let check_geo_ref = fun xml ->
  let get_float = fun x -> float_attrib xml x in
  let lat0_deg = get_float "lat0"
  and lon0_deg = get_float "lon0" in
  let utm0 = utm_of WGS84 { posn_lat=(Deg>>Rad)lat0_deg;
			    posn_long=(Deg>>Rad)lon0_deg } in

  let max_d = get_float "max_dist_from_home" in
  let check_zone = fun u ->
    if (utm_of WGS84 (of_utm WGS84 u)).utm_zone <> utm0.utm_zone then
      failwith "Fatal error: You are too close (less than twice the max distance) to an UTM zone border !" in
  check_zone { utm0 with utm_x = utm0.utm_x +. 2.*.max_d };
  check_zone { utm0 with utm_x = utm0.utm_x -. 2.*.max_d };

  let wpts = ExtXml.child xml "waypoints" in
  let wpts = ExtXml.subst_attrib "utm_x0" (sof utm0.utm_x) wpts in
  let wpts = ExtXml.subst_attrib "utm_y0" (sof utm0.utm_y) wpts in
  let x = ExtXml.subst_child "waypoints" wpts xml in
  x

let dummy_waypoint = 
  Xml.Element ("waypoint", 
	       ["name", "dummy"; 
		"x", "42."; 
		"y", "42." ], 
	       [])



let print_inside_polygon = fun pts ->
  let layers = Geometry_2d.slice_polygon (Array.of_list pts) in
  let rec f = fun i j ->
    if i = j then
      let {G2D.top=yl; left_side=(xg, ag); right_side=(xd, ad)} = layers.(i) in
      if xg > xd then begin
	lprintf "return FALSE;\n"
      end else begin
      lprintf "float dy = _y - %.1f;\n" yl;
      lprintf "return (%.1f+dy*%.1f <= _x && _x <= %.1f+dy*%f);\n" xg ag xd ad
      end
    else
      let ij2 = (i+j) / 2 in
      let yl = layers.(ij2).G2D.top in
      lprintf "if (_y <= %.1f) {\n" yl;
      right (); f i ij2; left ();
      lprintf "} else {\n";
      right (); f (ij2+1) j; left ();
      lprintf "}\n"
  in
  f 0 (Array.length layers - 1);;



let print_inside_sector = fun (s, pts) ->
  lprintf "static inline bool_t %s(float _x, float _y) { \\\n" (inside_function s);
  right ();
  print_inside_polygon pts;
  left ();
  lprintf "}\n"


let parse_sector = fun rel_utm_of_wgs84 x ->
  let xml = ExtXml.child x "0" in
  match String.lowercase (Xml.tag xml) with
    "polygon" ->
      let p2D_of = fun x ->
	let geo = Latlong.of_string (ExtXml.attrib x "pos") in
	let (x, y) = rel_utm_of_wgs84 geo in
	{G2D.x2D = x; G2D.y2D = y } in
      let pts =  List.map p2D_of (Xml.children xml) in
      (ExtXml.attrib x "name", pts)
  | s -> failwith (sprintf "sector: %s not yet" s)


let _ =
  let xml_file = ref "fligh_plan.xml"
  and dump = ref false
  and gen_sectors = ref false in
  Arg.parse [("-dump", Arg.Set dump, "Dump compile result");
	     ("-sectors", Arg.Set gen_sectors, "Generatess inside functions for sectors.xml");
	     ("-nocheck", Arg.Clear check_expressions, "Disable expression checking")]
    (fun f -> xml_file := f)
    "Usage:";
  if !xml_file = "" then
    failwith (sprintf "Usage: %s <xml-flight-plan-file>" Sys.argv.(0));
  try
    let xml = Xml.parse_file !xml_file in
    
    let xml = check_geo_ref xml in

    let dir = Filename.dirname !xml_file in
    let xml = Fp_proc.process_includes dir xml in
    let xml = Fp_proc.process_paths xml in
    let xml = Fp_proc.process_relative_waypoints xml in
    let xml = ExtXml.subst_child "blocks" (index_blocks (ExtXml.child xml "blocks")) xml in
    let waypoints = ExtXml.child xml "waypoints"
    and blocks = Xml.children (ExtXml.child xml "blocks")
    and global_exceptions = try Xml.children (ExtXml.child xml "exceptions") with _ -> [] in

    if !dump then
      let xml_stages = Xml.Element ("stages", [], indexed_stages blocks) in
      let dump_xml = Xml.Element ("dump", [], [xml; xml_stages]) in
      printf "%s\n" (ExtXml.to_string_fmt dump_xml)
    else begin
      let h_name = "FLIGHT_PLAN_H" in
      printf "/* This file has been generated from %s */\n" !xml_file;
      printf "/* Please DO NOT EDIT */\n\n";
      
      printf "#ifndef %s\n" h_name;
      Xml2h.define h_name "";
      printf "\n";
      
      printf "#include \"std.h\"\n";

      begin
	try
	  let header = ExtXml.child (ExtXml.child xml "header") "0" in
	  printf "%s\n" (Xml.pcdata header)
	with _ -> ()
      end;

      let name = ExtXml.attrib xml "name" in
      Xml2h.warning ("FLIGHT PLAN: "^name);
      Xml2h.define_string "FLIGHT_PLAN_NAME" name;
      
      let get_float = fun x -> float_attrib xml x in
      let lat0_deg = get_float "lat0"
      and lon0_deg = get_float "lon0"
      and qfu = get_float "qfu"
      and mdfh = get_float "max_dist_from_home"
      and alt = ExtXml.attrib xml "alt" in
      security_height := get_float "security_height";
      ground_alt := get_float "ground_alt";

      check_altitude (float_of_string alt) xml;

      let wgs84 = {posn_lat=(Deg>>Rad)lat0_deg;posn_long=(Deg>>Rad)lon0_deg } in
      let utm0 = utm_of WGS84 wgs84 in
      let rel_utm_of_wgs84 = fun wgs84 ->
	let utm = utm_of WGS84 wgs84 in
	(utm.utm_x -. utm0.utm_x, utm.utm_y -. utm0.utm_y) in

      Xml2h.define "NAV_UTM_EAST0" (sprintf "%.0f" utm0.utm_x);
      Xml2h.define "NAV_UTM_NORTH0" (sprintf "%.0f" utm0.utm_y);
      Xml2h.define "NAV_UTM_ZONE0" (sprintf "%d" utm0.utm_zone);
      Xml2h.define "QFU" (sprintf "%.1f" qfu);

      
      let waypoints = dummy_waypoint :: Xml.children waypoints in
      let (hx, hy) = home waypoints in
      List.iter (check_distance (hx, hy) mdfh) waypoints;
      define_waypoints_indices waypoints;

      Xml2h.define "WAYPOINTS" "{ \\";
      List.iter (print_waypoint rel_utm_of_wgs84 alt) waypoints;
      lprintf "};\n";
      Xml2h.define "NB_WAYPOINT" (string_of_int (List.length waypoints));

      Xml2h.define "GROUND_ALT" (sof !ground_alt);
      Xml2h.define "SECURITY_HEIGHT" (sof !security_height);
      Xml2h.define "SECURITY_ALT" (sof (!security_height +. !ground_alt));
      Xml2h.define "MAX_DIST_FROM_HOME" (sof mdfh);
      
      let index_of_waypoints =
	let i = ref (-1) in
	List.map (fun w -> incr i; (name_of w, !i)) waypoints in

      if !gen_sectors then begin
	let sectors_filename = Filename.concat dir "sectors.xml" in (** FIXME **)
	let sectors_xml = Xml.parse_file sectors_filename in
	let sectors = List.map (parse_sector rel_utm_of_wgs84) (Xml.children sectors_xml) in
	List.iter print_inside_sector sectors
      end;

      lprintf "#ifdef NAV_C\n";
      lprintf "\nstatic inline void auto_nav(void) {\n";
      right ();
      List.iter print_exception global_exceptions;
      lprintf "switch (nav_block) {\n";
      right ();
      print_blocks index_of_waypoints blocks;
      left (); lprintf "}\n";
      left (); lprintf "}\n";
      lprintf "#endif // NAV_C\n";

      begin
	try
	  let airspace = Xml.attrib xml "airspace" in
	  lprintf "#define InAirspace(_x, _y) %s(_x, _y)\n" (inside_function airspace)
	with
	  _ -> ()
      end;

      Xml2h.finish h_name
    end
  with
    Xml.Error e -> fprintf stderr "%s: XML error:%s\n" !xml_file (Xml.error e); exit 1
  | Dtd.Prove_error e -> fprintf stderr "%s: DTD error:%s\n%!" !xml_file (Dtd.prove_error e); exit 1
  | Dtd.Check_error e -> fprintf stderr "%s: DTD error:%s\n%!" !xml_file (Dtd.check_error e); exit 1
  | Dtd.Parse_error e -> fprintf stderr "%s: DTD error:%s\n%!" !xml_file (Dtd.parse_error e); exit 1
  | Failure x -> fprintf stderr "%s: %s\n" !xml_file x; exit 1

