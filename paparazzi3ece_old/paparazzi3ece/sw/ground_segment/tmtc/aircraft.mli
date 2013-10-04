(*
 * $Id: aircraft.mli,v 1.11 2006/10/27 16:13:00 hecto Exp $
 *
 * Copyright (C) ENAC
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

(** State of an A/C handled by the server *)

type ac_cam = {
    mutable phi : float; (* Rad, right = >0 *)
    mutable theta : float; (* Rad, front = >0 *)
    mutable target : (float * float) (* meter*meter relative *)
  }

type inflight_calib = {
  mutable if_mode : int;
  mutable if_val1 : float;
  mutable if_val2 : float;
}
type contrast_status = string
type infrared = {
  mutable gps_hybrid_mode : int;
  mutable gps_hybrid_factor : float;
  mutable contrast_status : contrast_status;
  mutable contrast_value : int;
}
type rc_status = string
type rc_mode = string
type fbw = { mutable rc_status : rc_status; mutable rc_mode : rc_mode; }
val gps_nb_channels : int
type svinfo = {
  svid : int;
  flags : int;
  qi : int;
  cno : int;
  elev : int;
  azim : int;
}
val svinfo_init : svinfo
type horiz_mode =
    Circle of Latlong.utm * int
  | Segment of Latlong.utm * Latlong.utm
  | UnknownHorizMode

type waypoint = { altitude : float; wp_utm : Latlong.utm }

type aircraft = {
    id : string;
    mutable pos : Latlong.utm;
    mutable roll : float;
    mutable pitch : float;
    mutable nav_ref : Latlong.utm option;
    mutable desired_east : float;
    mutable desired_north : float;
    mutable desired_altitude : float;
    mutable desired_course : float;
    mutable desired_climb : float;
    mutable gspeed : float; (* m/s *)
    mutable course : float; (* rad *)
    mutable alt : float;
    mutable agl : float; (* m *)
    mutable climb : float;
    mutable cur_block : int;
    mutable cur_stage : int;
    mutable throttle : float;
    mutable kill_mode : bool;
    mutable throttle_accu : float;
    mutable rpm : float;
    mutable temp : float;
    mutable bat : float;
    mutable amp : float;
    mutable energy : int;
    mutable ap_mode : int;
    mutable gaz_mode : int;
    mutable lateral_mode : int;
    mutable horizontal_mode : int;
    mutable periodic_callbacks : Glib.Timeout.id list;
    cam : ac_cam;
    mutable gps_mode : int;
    inflight_calib : inflight_calib;
    infrared : infrared;
    fbw : fbw;
    svinfo : svinfo array;
    waypoints : (int, waypoint) Hashtbl.t;
    mutable flight_time : int;
    mutable stage_time : int;
    mutable block_time : int;
    mutable horiz_mode : horiz_mode;
    dl_setting_values : float array;
    mutable nb_dl_setting_values : int;
    mutable survey : (Latlong.geographic * Latlong.geographic) option;
    mutable last_bat_msg_date : float
}
