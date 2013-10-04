(*
* $Id: live.ml,v 1.27 2006/12/12 06:27:15 hecto Exp $
*
* Real time handling of flying A/Cs
*  
* Copyright (C) 2004-2006 ENAC, Pascal Brisset, Antoine Drouin
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

module G = MapCanvas
open Latlong
module LL = Latlong
open Printf

module Tele_Pprz = Pprz.Messages(struct let name = "telemetry" end)
module Ground_Pprz = Pprz.Messages(struct let name = "ground" end)
module Alert_Pprz = Pprz.Messages(struct let name = "alert" end)

let approaching_alert_time = 3.
let track_size = ref 500

let rotate = fun a (x, y) ->
  let cosa = cos a and sina = sin a in
  (cosa *.x +. sina *.y, -. sina*.x +. cosa *. y)

let rec list_casso x = function
    [] -> raise Not_found
  | (a,b)::abs -> if x = b then a else list_casso x abs

let rec list_iter3 = fun f l1 l2 l3 ->
  match l1, l2, l3 with
    [], [], [] -> ()
  | x1::x1s, x2::x2s, x3::x3s ->
      f x1 x2 x3;
      list_iter3 f x1s x2s x3s
  | _ -> invalid_arg "list_iter3"


type color = string
type aircraft = {
    ac_name : string;
    config : Pprz.values;
    track : MapTrack.track;
    color: color;
    fp_group : MapFP.flight_plan;
    fp : Xml.xml;
    blocks : (int * string) list;
    mutable last_ap_mode : string;
    mutable last_stage : int * int;
    ir_page : Pages.infrared;
    gps_page : Pages.gps;
    pfd_page : Pages.pfd;
    misc_page : Pages.misc;
    dl_settings_page : Pages.settings option;
    rc_settings_page : Pages.rc_settings option;
    pages : GObj.widget;
    notebook_label : GMisc.label;
    strip : Strip.t;
    mutable first_pos : bool;
    mutable last_block_name : string;
    mutable in_kill_mode : bool;
    mutable speed : float;
    mutable alt : float;
    mutable target_alt : float;
    mutable flight_time : int;
    mutable wind_speed : float;
    mutable wind_dir : float; (* Rad *)
    mutable ground_prox : bool;
  }

let aircrafts = Hashtbl.create 3
let active_ac = ref ""
let get_ac = fun vs ->
  let ac_id = Pprz.string_assoc "ac_id" vs in
  Hashtbl.find aircrafts ac_id

let select_ac = fun acs_notebook ac_id ->
  if !active_ac <> ac_id then
    let ac = Hashtbl.find aircrafts ac_id in

    (* Show the buttons in the active strip and hide the previous active one *)
    ac.strip#show_buttons ();
    if !active_ac <> "" then begin
      let ac' = Hashtbl.find aircrafts !active_ac in
      ac'.strip#hide_buttons ();
      ac'.notebook_label#set_width_chars (String.length ac'.notebook_label#text)  
    end;

    (* Set the new active *)
    active_ac := ac_id;

    (* Select and enlarge the label of the A/C notebook *)
    let n = acs_notebook#page_num ac.pages in
    acs_notebook#goto_page n;
    ac.notebook_label#set_width_chars 20;

module M = Map.Make (struct type t = string let compare = compare end)
let log = 
  let last = ref M.empty in
  fun ?(say = false) (a:Pages.alert) ac_id s ->
    if not (M.mem ac_id !last) || M.find ac_id !last <> s then begin
      last := M.add ac_id s (M.remove ac_id !last);
      if say then Speech.say s;
      a#add s
    end

let log_and_say = fun a ac_id s -> log ~say:true a ac_id s

let show_mission = fun ac on_off ->
  let a = Hashtbl.find aircrafts ac in
  if on_off then
    a.fp_group#show ()
  else
    a.fp_group#hide ()

let resize_track = fun ac track ->
  match
    GToolbox.input_string ~text:(string_of_int track#size) ~title:ac "Track size"
  with
    None -> ()
  | Some s -> track#resize (int_of_string s)


let send_move_waypoint_msg = fun ac i w ->
  let wgs84 = w#pos in
  let vs = ["ac_id", Pprz.String ac;
	    "wp_id", Pprz.Int i;
	    "lat", Pprz.Float ((Rad>>Deg)wgs84.posn_lat);
	    "long", Pprz.Float ((Rad>>Deg)wgs84.posn_long);
	    "alt", Pprz.Float w#alt
	  ] in
  Ground_Pprz.message_send "map2d" "MOVE_WAYPOINT" vs

let commit_changes = fun ac ->
  let a = Hashtbl.find aircrafts ac in
  List.iter 
    (fun w ->
      let (i, w) = a.fp_group#index w in
      if w#moved then 
	send_move_waypoint_msg ac i w)
    a.fp_group#waypoints

let center = fun geomap track () ->
  match track#last with
    None -> ()
  | Some geo ->
      geomap#center geo


let blocks_of_stages = fun stages ->
  let blocks = ref [] in
  List.iter (fun x ->
    let name = ExtXml.attrib x "block_name"
    and id = ExtXml.int_attrib x "block" in
    if not (List.mem_assoc id !blocks) then
      blocks := (id, name) :: !blocks)
    (Xml.children stages);
  List.sort compare !blocks

let jump_to_block = fun ac_id id ->
  Ground_Pprz.message_send "map2d" "JUMP_TO_BLOCK" 
    ["ac_id", Pprz.String ac_id; "block_id", Pprz.Int id]

let menu_entry_of_block = fun ac_id (id, name) ->
  let send_msg = fun () -> jump_to_block ac_id id in
  `I (name, send_msg)

let reset_waypoints = fun fp () ->
  List.iter (fun w ->
    let (_i, w) = fp#index w in
    w#reset_moved ())
    fp#waypoints

let icon = ref None
let show_snapshot = fun (geomap:G.widget) geo_FL geo_BR point pixbuf name ev ->
  match ev with
  | `BUTTON_PRESS _ev ->
      let image = GMisc.image ~pixbuf () in
      let icon = image#coerce in
      begin
	match GToolbox.question_box ~title:name ~buttons:["Delete"; "Close"] ~icon "" with
	  1  -> 
	    point#destroy ()
	| _ -> ()
      end;
      true
  | `LEAVE_NOTIFY _ev ->
      begin
	match !icon with
	  None -> ()
	| Some i -> i#destroy ()
      end;
      false
  | `ENTER_NOTIFY _ev ->
      let w = GdkPixbuf.get_width pixbuf
      and h = GdkPixbuf.get_height pixbuf in
      icon := Some (geomap#display_pixbuf ((0,0), geo_FL) ((w,h), geo_BR) pixbuf);
      point#raise_to_top ();
      false

  | _ -> false
	

let mark = fun (geomap:G.widget) ac_id track plugin_frame ->
  let i = ref 1 in fun () ->
    match track#last with
      Some geo ->
	begin
	  let group = geomap#background in
	  let point = geomap#circle ~group ~fill_color:"blue" geo 5. in
	  point#raise_to_top ();
	  let lat = (Rad>>Deg)geo.posn_lat
	  and long = (Rad>>Deg)geo.posn_long in
	  Tele_Pprz.message_send ac_id "MARK" 
	    ["ac_id", Pprz.String ac_id;
	     "lat", Pprz.Float lat;
	     "long", Pprz.Float long];
	  let frame =
	    match plugin_frame with
	      None -> geomap#canvas#coerce
	    | Some pf -> pf#coerce in
	  let width, height = Gdk.Drawable.get_size frame#misc#window in
	  let dest = GdkPixbuf.create width height() in
	  GdkPixbuf.get_from_drawable ~dest ~width ~height frame#misc#window;
	  let name = sprintf "Snapshot-%s-%d_%f_%f_%f.png" ac_id !i lat long (track#last_heading) in
	  let png = sprintf "%s/var/logs/%s" Env.paparazzi_home name in
	  GdkPixbuf.save png "png" dest;
	  incr i;
	  
	  (* Computing the footprint: front_left and back_right *)
	  let cam_aperture = 2.4/.1.9 in (* width over distance FIXME *)
	  let alt = track#last_altitude -. float (Srtm.of_wgs84 geo) in
	  let width = cam_aperture *. alt in
	  let height = width *. 3. /. 4. in
	  let utm = utm_of WGS84 geo in
	  let a = (Deg>>Rad)track#last_heading in
	  let (xfl,yfl) = rotate a (-.width/.2., height/.2.)
	  and (xbr,ybr) = rotate a (width/.2., -.height/.2.) in
	  let geo_FL = of_utm WGS84 (utm_add utm (xfl,yfl))
	  and geo_BR = of_utm WGS84 (utm_add utm (xbr,ybr)) in
	  ignore (point#connect#event (show_snapshot geomap geo_FL geo_BR point dest name))
	end
    | None -> ()


(** Light display of attributes in the flight plan. *)
let attributes_pretty_printer = fun attribs ->
  (* Remove the "no" an "strip_button" attributes�*)
  let valid = fun a ->
    let a = String.lowercase a in
    a <> "no" && a <> "strip_button" in

  let attribs = List.filter (fun (a, _) -> valid a) attribs in

  (* Don't print the name of the attribute if there is only one *)
  match attribs with
    [(_, v)] -> v
  | _        -> XmlEdit.string_of_attribs attribs


(** Load a mission. Returns the XML window *)
let load_mission = fun ?editable color geomap xml ->
  Map2d.set_georef_if_none geomap (MapFP.georef_of_xml xml);
  new MapFP.flight_plan ~format_attribs:attributes_pretty_printer ?editable ~show_moved:true geomap color Env.flight_plan_dtd xml



let create_ac = fun alert (geomap:G.widget) (acs_notebook:GPack.notebook) (ac_id:string) config ->
  let color = Pprz.string_assoc "default_gui_color" config
  and name = Pprz.string_assoc "ac_name" config in

  (** Get the flight plan **)
  let fp_url = Pprz.string_assoc "flight_plan" config in
  let fp_file = Http.file_of_url fp_url in
  let fp_xml_dump = ExtXml.parse_file ~noprovedtd:true fp_file in
  let stages = ExtXml.child fp_xml_dump "stages" in
  let blocks = blocks_of_stages stages in

  let label_box = GBin.event_box () in
  let label = GPack.hbox ~packing:label_box#add ~spacing:3 () in
  let eb = GBin.event_box ~width:10 ~height:10 ~packing:label#pack () in
  eb#coerce#misc#modify_bg [`NORMAL, `NAME color];
  let _ac_label = GMisc.label ~text:name ~packing:label#pack () in

  let ac_mi = GMenu.image_menu_item ~image:label_box ~packing:geomap#menubar#append () in
  let ac_menu = GMenu.menu () in
  ac_mi#set_submenu ac_menu;
  let ac_menu_fact = new GMenu.factory ac_menu in
  let fp = ac_menu_fact#add_check_item "Fligh Plan" ~active:true in
  ignore (fp#connect#toggled (fun () -> show_mission ac_id fp#active));
  
  let track = new MapTrack.track ~size: !track_size ~name ~color:color geomap in
  geomap#register_to_fit (track:>MapCanvas.geographic);

  let center_ac = center geomap track in
  ignore (ac_menu_fact#add_item "Center A/C" ~callback:center_ac);
  
  ignore (ac_menu_fact#add_item "Clear Track" ~callback:(fun () -> track#clear_map2D));
  ignore (ac_menu_fact#add_item "Resize Track" ~callback:(fun () -> resize_track ac_id track));
  let reset_wp_menu = ac_menu_fact#add_item "Reset Waypoints" in

  let jump_block_entries = List.map (menu_entry_of_block ac_id) blocks in
  
  let commit_moves = fun () ->
    commit_changes ac_id in
  let sm = ac_menu_fact#add_submenu "Datalink" in
  let dl_menu = [
    `M ("Jump to block", jump_block_entries);
    `I ("Commit Moves", commit_moves)] in

  GToolbox.build_menu sm ~entries:dl_menu;

  let cam = ac_menu_fact#add_check_item "Cam footprint" ~active:false in
  ignore (cam#connect#toggled (fun () -> track#set_cam_state cam#active));
  let params = ac_menu_fact#add_check_item "A/C label" ~active:false in
  ignore (params#connect#toggled (fun () -> track#set_params_state params#active));

  (** Add a new tab in the A/Cs notebook, with a colored label *)
  let eb = GBin.event_box () in
  let _label = GMisc.label ~text:name ~packing:eb#add () in
  eb#coerce#misc#modify_bg [`NORMAL, `NAME color;`ACTIVE, `NAME color];

  (** Put a notebook for this A/C *)
  let ac_frame = GBin.frame ~packing:(acs_notebook#append_page ~tab_label:eb#coerce) () in
  let ac_notebook = GPack.notebook ~packing: ac_frame#add () in
  let visible = fun w ->
    ac_notebook#page_num w#coerce = ac_notebook#current_page in      

  (** Add a strip *)
  let strip = Strip.add config color center_ac (mark geomap ac_id track !Plugin.frame) in
  strip#connect (fun () -> select_ac acs_notebook ac_id);

  (** Build the XML flight plan, connect then "jump_to_block" *)
  let fp_xml = ExtXml.child fp_xml_dump "flight_plan" in
  let fp = load_mission ~editable:false color geomap fp_xml in
  fp#connect_activated (fun node ->
    if XmlEdit.tag node = "block" then
      let block = XmlEdit.attrib node "name" in
      let id = list_casso block blocks in
      jump_to_block ac_id id);
  ignore (reset_wp_menu#connect#activate (reset_waypoints fp));

  (** Monitor waypoints changes *)
   List.iter 
    (fun w ->
      let (i, w) = fp#index w in
      w#set_commit_callback (fun () -> send_move_waypoint_msg ac_id i w))
    fp#waypoints;

  (** Add waypoints as geo references *)
   List.iter 
    (fun w ->
      let (i, w) = fp#index w in
      geomap#add_info_georef (sprintf "%s.%s" name w#name) (w :> < pos : geographic>))
    fp#waypoints;
  
  (** Add the short cut buttons in the strip *)
  List.iter (fun b ->
    try
      let label = ExtXml.attrib b "strip_button"
      and id = ExtXml.int_attrib b "no" in
      let  b = GButton.button ~label () in
      strip#add_widget b#coerce;
      ignore (b#connect#clicked (fun _ -> jump_to_block ac_id id))
    with
       _ -> ())
    (Xml.children (ExtXml.child (ExtXml.child fp_xml_dump "flight_plan") "blocks"));

  (** Insert the flight plan tab *)
  let fp_label = GMisc.label ~text: "Flight Plan" () in
  (ac_notebook:GPack.notebook)#append_page ~tab_label:fp_label#coerce fp#window#coerce;
  
  let infrared_label = GMisc.label ~text: "Infrared" () in
  let infrared_frame = GBin.frame ~shadow_type: `NONE
      ~packing: (ac_notebook#append_page ~tab_label: infrared_label#coerce) () in
  let ir_page = new Pages.infrared infrared_frame in
  
  let gps_label = GMisc.label ~text: "GPS" () in
  let gps_frame = GBin.frame ~shadow_type: `NONE
      ~packing: (ac_notebook#append_page ~tab_label: gps_label#coerce) () in
  let gps_page = new Pages.gps ~visible gps_frame in

  let pfd_label = GMisc.label ~text: "PFD" () in
  let pfd_frame = GBin.frame ~shadow_type: `NONE
      ~packing: (ac_notebook#append_page ~tab_label: pfd_label#coerce) () in
  let pfd_page = new Pages.pfd pfd_frame
  and _pfd_page_num = ac_notebook#page_num pfd_frame#coerce in

  let misc_label = GMisc.label ~text: "Misc" () in
  let misc_frame = GBin.frame ~shadow_type: `NONE
      ~packing: (ac_notebook#append_page ~tab_label:misc_label#coerce) () in
  let misc_page = new Pages.misc ~packing:misc_frame#add misc_frame in

  let settings_url = Pprz.string_assoc "settings" config in
  let settings_file = Http.file_of_url settings_url in
  let settings_xml = 
    try
      ExtXml.parse_file ~noprovedtd:true settings_file
    with exc ->
      prerr_endline (Printexc.to_string exc);
      Xml.Element("empty", [], [])
  in
  let dl_setting_callback = fun idx value -> 
    let vs = ["ac_id", Pprz.String ac_id; "index", Pprz.Int idx;"value", Pprz.Float value] in
    Ground_Pprz.message_send "dl" "DL_SETTING" vs in
  let dl_settings_page =
    try
      let xml_settings = Xml.children (ExtXml.child settings_xml "dl_settings") in
      let settings_tab = new Pages.settings ~visible xml_settings dl_setting_callback strip in

      let tab_label = (GMisc.label ~text:"Settings" ())#coerce in
      ac_notebook#append_page ~tab_label settings_tab#widget;
      Some settings_tab
    with exc ->
      log alert ac_id (Printexc.to_string exc);
      None in
  
  let rc_settings_page =
    try
      let xml_settings = Xml.children (ExtXml.child settings_xml "rc_settings") in
      let settings_tab = new Pages.rc_settings ~visible xml_settings in
      let tab_label = (GMisc.label ~text:"RC Settings" ())#coerce in
      ac_notebook#append_page ~tab_label settings_tab#widget;
      Some settings_tab
    with _ -> None in

    let ac = { track = track; color = color; 
	       fp_group = fp ; config = config ; 
	       fp = fp_xml; ac_name = name;
	       blocks = blocks; last_ap_mode= "";
	       last_stage = (-1,-1);
	       ir_page = ir_page; flight_time = 0;
	       gps_page = gps_page;
	       pfd_page = pfd_page;
	       misc_page = misc_page;
	       dl_settings_page = dl_settings_page;
	       rc_settings_page = rc_settings_page;
	       strip = strip; first_pos = true;
	       last_block_name = ""; alt = 0.; target_alt = 0.;
	       in_kill_mode = false; speed = 0.;
	       wind_dir = 42.; ground_prox = true;
	       wind_speed = 0.;
	       pages = ac_frame#coerce;
	       notebook_label = _label
	     } in
    Hashtbl.add aircrafts ac_id ac;
(* Printf.fprintf stdout "add airplane: %s\n" ac_id; flush stdout; *)
    select_ac acs_notebook ac_id;

  (** Periodically send the wind estimation through
      a WIND_INFO message packed into a RAW_DATALINK *)
  let send_wind = fun () ->
    if misc_page#periodic_send then begin
      (* FIXME: Disabling the timeout would be preferable *)
      try
	let a = (pi/.2. -. ac.wind_dir)
	and w =  ac.wind_speed in

	let wind_east = (sprintf "%.1f" (-. cos a *. w))
	and wind_north = (sprintf "%.1f" (-. sin a *. w)) in
	
	let msg_items = ["WIND_INFO"; "42"; wind_east; wind_north] in
	let value = String.concat ";" msg_items in
	let vs = ["ac_id", Pprz.String ac_id; "message", Pprz.String value] in
	Ground_Pprz.message_send "dl" "RAW_DATALINK" vs;
      with
	exc -> log alert ac_id (sprintf "send_wind (%s): %s" ac_id (Printexc.to_string exc))
    end;
    true
  in

  ignore (Glib.Timeout.add 10000 send_wind);

  (** Connect the shift altitude buttons *)
  begin
    match dl_settings_page with
      Some settings_tab ->
	let flight_altitude_id, _flight_altitude_label = 
	  try
	    settings_tab#assoc "flight_altitude"
	  with Not_found ->
	    failwith "flight_altitude not setable" in
	strip#connect_shift_alt
	  (fun x -> 
	    dl_setting_callback flight_altitude_id (ac.target_alt +. x));
    | None -> ()
  end
      




let ok_color = "green"
let warning_color = "orange"
let alert_color = "red"

(** Bind to message while catching all the esceptions of the callback *)
let safe_bind = fun msg cb ->
  let safe_cb = fun sender vs ->
    try cb sender vs with x -> prerr_endline (Printexc.to_string x) in
  ignore (Ground_Pprz.message_bind msg safe_cb)

let alert_bind = fun msg cb ->
  let safe_cb = fun sender vs ->
    try cb sender vs with _ -> () in
  ignore (Alert_Pprz.message_bind msg safe_cb)

let ask_config = fun alert geomap fp_notebook ac ->
  let get_config = fun _sender values ->
    if not (Hashtbl.mem aircrafts ac) then
      create_ac alert geomap fp_notebook ac values
  in
  Ground_Pprz.message_req "map2d" "CONFIG" ["ac_id", Pprz.String ac] get_config

    

let one_new_ac = fun alert (geomap:G.widget) fp_notebook ac ->
  if not (Hashtbl.mem aircrafts ac) then
    ask_config alert geomap fp_notebook ac
      

let get_wind_msg = fun (geomap:G.widget) _sender vs ->
  let ac = get_ac vs in
  let value = fun field_name -> Pprz.float_assoc field_name vs in
  ac.misc_page#set_mean_aspeed (sprintf "%.1f" (value "mean_aspeed"));
  ac.wind_speed <- value "wspeed";
  let deg_dir = value "dir" in
  ac.wind_dir <- (Deg>>Rad)deg_dir;
  ac.misc_page#set_wind_speed (sprintf "%.1f" ac.wind_speed);
  ac.misc_page#set_wind_dir (sprintf "%.1f" deg_dir)

let get_fbw_msg = fun _sender vs ->
  let ac = get_ac vs in
  let status = Pprz.string_assoc "rc_status" vs in
  ac.strip#set_label "RC" status;
  ac.strip#set_color "RC"
    (match status with
      "OK" -> ok_color 
    | _ -> warning_color)

    

let get_engine_status_msg = fun _sender vs ->
  let ac = get_ac vs in
  ac.strip#set_label "throttle" 
    (string_of_float (Pprz.float_assoc "throttle" vs));
  ac.strip#set_bat (Pprz.float_assoc "bat" vs)
    
let get_if_calib_msg = fun _sender vs ->
  let ac = get_ac vs in
  match ac.rc_settings_page with
    None -> ()
  | Some p ->
      p#set_rc_setting_mode (Pprz.string_assoc "if_mode" vs);
      p#set (Pprz.float_assoc "if_value1" vs) (Pprz.float_assoc "if_value2" vs)

let listen_wind_msg = fun (geomap:G.widget) ->
  safe_bind "WIND" (get_wind_msg geomap)

let listen_fbw_msg = fun () ->
  safe_bind "FLY_BY_WIRE" get_fbw_msg

let listen_engine_status_msg = fun () ->
  safe_bind "ENGINE_STATUS" get_engine_status_msg

let listen_if_calib_msg = fun () ->
  safe_bind "INFLIGH_CALIB" get_if_calib_msg

let list_separator = Str.regexp ","
    
let aircrafts_msg = fun alert (geomap:G.widget) fp_notebook acs ->
  let acs = Pprz.string_assoc "ac_list" acs in
  let acs = Str.split list_separator acs in
  List.iter (one_new_ac alert geomap fp_notebook) acs


let listen_dl_value = fun () ->
  let get_dl_value = fun _sender vs ->
    let ac_id = Pprz.string_assoc "ac_id" vs in
    let ac = Hashtbl.find aircrafts ac_id in
    match ac.dl_settings_page with
      Some settings ->
	let csv = Pprz.string_assoc "values" vs in
	let values = Array.of_list (Str.split list_separator csv) in
	for i = 0 to min (Array.length values) settings#length - 1 do
	  settings#set i (float_of_string values.(i))
	done
    | None -> () in
  safe_bind "DL_VALUES" get_dl_value


let highlight_fp = fun ac b s ->
  if (b, s) <> ac.last_stage then begin
    ac.last_stage <- (b, s);
    ac.fp_group#highlight_stage b s
  end


let check_approaching = fun ac geo alert ->
  match ac.track#last with
    None -> ()
  | Some ac_pos ->
      let d = LL.utm_distance (LL.utm_of WGS84 ac_pos) (LL.utm_of WGS84 geo) in
      if d < ac.speed *. approaching_alert_time then
	log_and_say alert ac.ac_name (sprintf "%s, approaching" ac.ac_name)


let listen_flight_params = fun geomap auto_center_new_ac alert ->
  let get_fp = fun _sender vs ->
    let ac = get_ac vs in
    let pfd_page = ac.pfd_page in
    let a = fun s -> Pprz.float_assoc s vs in
    let alt = a "alt"
    and climb = a "climb"
    and speed = a "speed" in
    pfd_page#set_attitude (a "roll") (a "pitch");
    pfd_page#set_alt alt;
    pfd_page#set_climb climb;
    pfd_page#set_speed speed;

    let wgs84 = { posn_lat=(Deg>>Rad)(a "lat"); posn_long = (Deg>>Rad)(a "long") } in
    ac.track#move_icon wgs84 (a "course") alt speed climb;
    ac.speed <- speed;

    if auto_center_new_ac && ac.first_pos then begin
      center geomap ac.track ();
      ac.first_pos <- false
    end;

    let set_label lbl_name value =
      let s = 
	if value < 0. 
	then sprintf "- %.1f" (abs_float value)
	else sprintf "%.1f" value
      in
      ac.strip#set_label lbl_name s
    in
    set_label "alt" alt;
    set_label "speed" speed;
    set_label "climb" climb;
    let agl = (a "agl") in
    ac.alt <- alt;
    ac.strip#set_agl agl;
    if not ac.ground_prox && ac.flight_time > 10 && agl < 20. then begin
      log_and_say alert ac.ac_name (sprintf "%s, %s" ac.ac_name "Ground Proximity Warning");
      ac.ground_prox <- true
    end else if agl > 25. then
      ac.ground_prox <- false

  in
  safe_bind "FLIGHT_PARAM" get_fp;

  let get_ns = fun _sender vs ->
    let ac = get_ac vs in
    let a = fun s -> Pprz.float_assoc s vs in
    let wgs84 = { posn_lat = (Deg>>Rad)(a "target_lat"); posn_long = (Deg>>Rad)(a "target_long") } in
    ac.track#move_carrot wgs84;
    let cur_block = Pprz.int_assoc "cur_block" vs
    and cur_stage = Pprz.int_assoc "cur_stage" vs in
    highlight_fp ac cur_block cur_stage;
    let set_label = fun l f ->
      ac.strip#set_label l (sprintf "%.1f" (Pprz.float_assoc f vs)) in
    set_label "->" "target_alt";
    set_label "/" "target_climb";
    let target_alt = Pprz.float_assoc "target_alt" vs in
    ac.strip#set_label "diff_target_alt" (sprintf "%+.0f" (ac.alt -. target_alt));
    ac.target_alt <- target_alt;
    let b = List.assoc cur_block ac.blocks in
    if b <> ac.last_block_name then begin
      log_and_say alert ac.ac_name (sprintf "%s, %s" ac.ac_name b);
      ac.last_block_name <- b;
      let b = String.sub b 0 (min 10 (String.length b)) in
      ac.strip#set_label "block_name" b
    end;
    let block_time = Int32.to_int (Pprz.int32_assoc "block_time" vs)
    and stage_time = Int32.to_int (Pprz.int32_assoc "stage_time" vs) in
    let bt = sprintf "%02d:%02d" (block_time / 60) (block_time mod 60) in
    ac.strip#set_label "block_time" bt;
    let st = sprintf "%02d:%02d" (stage_time / 60) (block_time mod 60) in
    ac.strip#set_label "stage_time" st
  in
  safe_bind "NAV_STATUS" get_ns;

  let get_cam_status = fun _sender vs ->
    let ac_id = Pprz.string_assoc "ac_id" vs in
    let ac = Hashtbl.find aircrafts ac_id in
    let a = fun s -> Pprz.float_assoc s vs in
    let cam_wgs84 = { posn_lat = (Deg>>Rad)(a "cam_lat"); posn_long = (Deg>>Rad)(a "cam_long") }
    and target_wgs84 = { posn_lat = (Deg>>Rad)(a "cam_target_lat"); posn_long = (Deg>>Rad)(a "cam_target_long") } in
    
    ac.track#move_cam cam_wgs84 target_wgs84
  in
  safe_bind "CAM_STATUS" get_cam_status;

  let get_circle_status = fun _sender vs ->
    let ac = get_ac vs in
    let a = fun s -> Pprz.float_assoc s vs in
    let wgs84 = { posn_lat = (Deg>>Rad)(a "circle_lat"); posn_long = (Deg>>Rad)(a "circle_long") } in
    ac.track#draw_circle wgs84 (float_of_string (Pprz.string_assoc "radius" vs)) 
  in
  safe_bind "CIRCLE_STATUS" get_circle_status;

  let get_segment_status = fun _sender vs ->
    let ac_id = Pprz.string_assoc "ac_id" vs in
    let ac = Hashtbl.find aircrafts ac_id in
    let a = fun s -> Pprz.float_assoc s vs in
    let geo1 = { posn_lat = (Deg>>Rad)(a "segment1_lat"); posn_long = (Deg>>Rad)(a "segment1_long") }
    and geo2 = { posn_lat = (Deg>>Rad)(a "segment2_lat"); posn_long = (Deg>>Rad)(a "segment2_long") } in
    ac.track#draw_segment geo1 geo2;
    
    (* Check if approaching the end of the segment *)
    check_approaching ac geo2 alert
  in
  safe_bind "SEGMENT_STATUS" get_segment_status;


  let get_survey_status = fun _sender vs ->
    let ac = get_ac vs in
    let a = fun s -> Pprz.float_assoc s vs in
    let geo1 = { posn_lat = (Deg>>Rad)(a "south_lat"); posn_long = (Deg>>Rad)(a "west_long") }
    and geo2 = { posn_lat = (Deg>>Rad)(a "north_lat"); posn_long = (Deg>>Rad)(a "east_long") } in
    ac.track#draw_zone geo1 geo2
  in
  safe_bind "SURVEY_STATUS" get_survey_status;


  let get_ap_status = fun _sender vs ->
    let ac = get_ac vs in
    let flight_time = Int32.to_int (Pprz.int32_assoc "flight_time" vs) in
    ac.track#update_ap_status (float_of_int flight_time);
    ac.flight_time <- flight_time;
    let ap_mode = Pprz.string_assoc "ap_mode" vs in
    if ap_mode <> ac.last_ap_mode then begin
      log_and_say alert ac.ac_name (sprintf "%s, %s" ac.ac_name ap_mode);
      ac.last_ap_mode <- ap_mode;
      ac.strip#set_label "AP" (Pprz.string_assoc "ap_mode" vs);
      ac.strip#set_color "AP" (if ap_mode="HOME" then alert_color else ok_color);
    end;
    let gps_mode = Pprz.string_assoc "gps_mode" vs in
    ac.strip#set_label "GPS" gps_mode;
    ac.strip#set_color "GPS" (if gps_mode<>"3D" then alert_color else ok_color);
    let ft = 
      sprintf "%02d:%02d:%02d" (flight_time / 3600) ((flight_time / 60) mod 60) (flight_time mod 60) in
    ac.strip#set_label "flight_time" ft;
    let kill_mode = Pprz.string_assoc "kill_mode" vs in
    if not ac.in_kill_mode then
      if kill_mode <> "OFF" then begin
	log_and_say alert ac.ac_name (sprintf "%s, mayday, kill mode" ac.ac_name);
	ac.in_kill_mode <- true
      end else
	ac.in_kill_mode <- false;
    match ac.rc_settings_page with
      None -> ()
    | Some p -> 
	p#set_rc_mode ap_mode
  in
  safe_bind "AP_STATUS" get_ap_status;

  listen_dl_value ()

let listen_waypoint_moved = fun () ->
  let get_values = fun _sender vs ->
    let ac = get_ac vs in
    let wp_id = Pprz.int_assoc "wp_id" vs in
    let a = fun s -> Pprz.float_assoc s vs in
    let geo = { posn_lat = (Deg>>Rad)(a "lat"); posn_long = (Deg>>Rad)(a "long") }
    and altitude = a "alt" in

    (** FIXME: No indexed access to waypoints: iter and compare: *)
    try
      List.iter (fun w ->
	let (i, w) = ac.fp_group#index w in
	if i = wp_id then begin
	  w#set ~if_not_moved:true ~altitude ~update:true geo;
	  raise Exit
	end)
	ac.fp_group#waypoints
    with
      Exit -> ()
  in
  safe_bind "WAYPOINT_MOVED" get_values
    
let get_alert_bat_low = fun a _sender vs -> 
  let ac = get_ac vs in
  let level = Pprz.string_assoc "level" vs in
  log_and_say a ac.ac_name (sprintf "%s %s %s" ac.ac_name "BAT LOW" level)

let listen_alert = fun a -> 
  alert_bind "BAT_LOW" (get_alert_bat_low a)
    

let get_infrared = fun _sender vs ->
  let ac_id = Pprz.string_assoc "ac_id" vs in
  let ac = Hashtbl.find aircrafts ac_id in
  let ir_page = ac.ir_page in
  let gps_hybrid_mode = Pprz.string_assoc "gps_hybrid_mode" vs in
  let gps_hybrid_factor = Pprz.float_assoc "gps_hybrid_factor" vs in
  let contrast_status = Pprz.string_assoc "contrast_status" vs in
  let contrast_value = Pprz.int_assoc "contrast_value" vs in

  ir_page#set_gps_hybrid_mode gps_hybrid_mode;
  ir_page#set_gps_hybrid_factor gps_hybrid_factor;
  ir_page#set_contrast_status contrast_status;
  ir_page#set_contrast_value contrast_value
    
let listen_infrared = fun () -> safe_bind "INFRARED" get_infrared

let get_svsinfo = fun _sender vs ->
  let ac_id = Pprz.string_assoc "ac_id" vs in
  let ac = Hashtbl.find aircrafts ac_id in
  let gps_page = ac.gps_page in
  let svid = Str.split list_separator (Pprz.string_assoc "svid" vs)
  and cn0 = Str.split list_separator (Pprz.string_assoc "cno" vs)
  and flags = Str.split list_separator (Pprz.string_assoc "flags" vs) in 
  
  list_iter3
    (fun id cno flags ->
      if id <> "0" then gps_page#svsinfo id cno (int_of_string flags))
    svid cn0 flags
    
let listen_svsinfo = fun () -> safe_bind "SVSINFO" get_svsinfo

let message_request = Ground_Pprz.message_req

let get_ts = fun _sender vs ->
  let ac = get_ac vs in
  let t = Pprz.float_assoc "time_since_last_bat_msg" vs in
  ac.strip#set_label "telemetry_status" (if t > 2. then sprintf "%.0f" t else "   ");
  ac.strip#set_color "telemetry_status" (if t > 5. then alert_color else ok_color)
  

let listen_telemetry_status = fun () ->
  safe_bind "TELEMETRY_STATUS" get_ts

let listen_error = fun a ->
  let get_error = fun _sender vs ->
    let msg = Pprz.string_assoc "message" vs in
    log_and_say a "gcs" msg in
  safe_bind "TELEMETRY_ERROR" get_error


let listen_acs_and_msgs = fun geomap ac_notebook my_alert auto_center_new_ac ->
  (** Probe live A/Cs *)
  let probe = fun () ->
    message_request "map2d" "AIRCRAFTS" [] (fun _sender vs -> aircrafts_msg my_alert geomap ac_notebook vs) in
  let _ = GMain.Idle.add (fun () -> probe (); false) in

  (** New aircraft message *)
  safe_bind "NEW_AIRCRAFT" (fun _sender vs -> one_new_ac my_alert geomap ac_notebook (Pprz.string_assoc "ac_id" vs));

  (** Listen for all messages on ivy *)
  listen_flight_params geomap auto_center_new_ac my_alert;
  listen_wind_msg geomap;
  listen_fbw_msg ();
  listen_engine_status_msg ();
  listen_if_calib_msg ();
  listen_waypoint_moved ();
  listen_infrared ();
  listen_svsinfo ();
  listen_telemetry_status ();
  listen_alert my_alert;
  listen_error my_alert;

  (** Select the active aircraft on notebook page selection *)
  let callback = fun i ->
    let ac_page = ac_notebook#get_nth_page i in
    Hashtbl.iter
      (fun ac_id ac -> 
	if ac.pages#get_oid = ac_page#get_oid
	then select_ac ac_notebook ac_id) 
      aircrafts in
  ignore (ac_notebook#connect#switch_page ~callback)
