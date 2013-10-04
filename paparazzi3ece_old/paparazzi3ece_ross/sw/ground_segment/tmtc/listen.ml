(*
 * $Id: listen.ml,v 1.6 2005/09/03 07:53:20 hecto Exp $
 *
 * Multi aircrafts receiver, logger and broadcaster
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


let _ =
  let bus = ref "127.255.255.255:2010" in
  let class_name = ref "telemetry_fbw" in
  let serial_dev = ref "/dev/ttyUSB0" in
  Arg.parse
    [ "-b",  Arg.String (fun x -> bus := x), "Bus\tDefault is 127.255.255.25:2010";
      "-c",  Arg.String (fun x -> class_name := x), "Message class name\tDefault is telemetry_fbw";
      "-d",  Arg.String (fun x -> serial_dev := x), "Serial device\tDefault is /dev/ttyUSB0"]
    (fun _x -> prerr_endline ("WARNING: don't do anything with "))
    "Usage: ";
  
  let module Tele_Class = struct let name = !class_name end in
  let module Tele_Pprz = Pprz.Protocol(Tele_Class) in
  let module PprzTransport = Serial.Transport(Tele_Pprz) in

  let listen_tty = fun use_pprz_message tty ->
    let fd = Serial.opendev tty Serial.B38400 in

    let use_pprz_buf = fun buf ->
      use_pprz_message (Tele_Pprz.values_of_bin buf) in

    let scanner = Serial.input (PprzTransport.parse use_pprz_buf) in
    let cb = fun _ ->
      begin
	try
	  scanner fd
	with
	  e -> fprintf stderr "%s\n" (Printexc.to_string e)
      end;
      true in
  
    ignore (Glib.Io.add_watch [`IN] cb (Glib.Io.channel_of_descr fd)) in

  let handle_pprz_message = fun (msg_id, values) ->
    let msg = Tele_Pprz.message_of_id msg_id in
    let s = Tele_Pprz.string_of_message msg values in
    Ivy.send (sprintf "1234.567 %s" s) in

  listen_tty handle_pprz_message !serial_dev;
  Ivy.init "Paparazzi listen" "READY" (fun _ _ -> ());
  Ivy.start "127.255.255.255:2010";
  let loop = Glib.Main.create true in
  while Glib.Main.is_running loop do ignore (Glib.Main.iteration true) done

