(*
 * $Id: serial.ml,v 1.9 2006/10/18 05:57:43 hecto Exp $
 *
 * Serial Port handling
 *  
 * Copyright (C) 2004 CENA/ENAC, Pascal Brisset
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

type speed = 
    B0
  | B50
  | B75
  | B110
  | B134
  | B150
  | B200
  | B300
  | B600
  | B1200
  | B1800
  | B2400
  | B4800
  | B9600
  | B19200
  | B38400
  | B57600
  | B115200
  | B230400

let speed_of_baudrate = fun baudrate ->
  match baudrate with
    "0" -> B0
  | "50" -> B50
  | "75" -> B75
  | "110" -> B110
  | "134" -> B134
  | "150" -> B150
  | "200" -> B200
  | "300" -> B300
  | "600" -> B600
  | "1200" -> B1200
  | "1800" -> B1800
  | "2400" -> B2400
  | "4800" -> B4800
  | "9600" -> B9600
  | "19200" -> B19200
  | "38400" -> B38400
  | "57600" -> B57600
  | "115200" -> B115200
  | "230400" -> B230400
  | _ -> invalid_arg "Serial.speed_of_baudrate"


type payload = string

let string_of_payload = fun x -> x
let payload_of_string = fun x -> x


external init_serial : string -> speed -> Unix.file_descr = "c_init_serial"
external set_dtr : Unix.file_descr -> bool -> unit = "c_set_dtr"
external set_speed : Unix.file_descr -> speed -> unit = "c_serial_set_baudrate"

let opendev device speed =
  try
    init_serial device speed
  with
    Failure x ->
      failwith (Printf.sprintf "%s (%s)" x device)

let close = Unix.close

type 'a closure = Closure of 'a

let buffer_len = 256
let input = fun f ->
  let buffer = String.create buffer_len
  and index = ref 0 in

  let wait = fun start n ->
    String.blit buffer start buffer 0 n;
    index := n in

  Closure (fun fd ->
    let n = !index + Unix.read fd buffer !index (buffer_len - !index) in
    Debug.call 'T' (fun f -> fprintf f "input: %d %d\n" !index n);
    let rec parse = fun start n -> 
      Debug.call 'T' (fun f -> fprintf f "input parse: %d %d\n" start n);
      let nb_used = f (String.sub buffer start n) in
(* 	Printf.fprintf stderr "n'=%d\n" nb_used; flush stderr; *)
      if nb_used > 0 then
	parse (start + nb_used) (n - nb_used)
      else if n = buffer_len then
	(* The buffer is full and the user does not consume any. We have to
	   discard one char to avoid a dead lock *)
        parse (start + 1) (n - 1)
      else
	wait start n in
    parse 0 n)


exception Not_enough

module type PROTOCOL = sig
  val index_start : string -> int (* raise Not_found *)
  val length : string -> int -> int (* raise Not_enough *)
  val checksum : string -> bool
  val payload : string -> payload
  val packet : payload -> string
end

module Transport(Protocol:PROTOCOL) = struct
  let nb_err = ref 0
  let discarded_bytes = ref 0
  let rec parse = fun use buf ->
    Debug.call 'T' (fun f -> fprintf f "Transport.parse: %s\n" (Debug.xprint buf));
    (** ref required due to Not_enough exception raised by Protocol.length *)
    let start = ref 0
    and n = String.length buf in
    try
      start := Protocol.index_start buf;
      discarded_bytes := !discarded_bytes + !start;
(*      Printf.fprintf stdout "start: %d, discarded_bytes: %d\n" !start !discarded_bytes; flush stdout;
      Printf.fprintf stdout "length: %d\n" (Protocol.length buf !start); flush stdout; *)
 
      let length = Protocol.length buf !start in
      let end_ = !start + length in
      if n < end_ || n=0 then
	raise Not_enough;
      let msg = String.sub buf !start length in
      if Protocol.checksum msg then begin
	use (Protocol.payload msg)
      end else begin
	incr nb_err;
	discarded_bytes := !discarded_bytes + length;
	Debug.call 'T' (fun f -> fprintf f "Transport.chk: %s\n" (Debug.xprint msg))
      end;
      end_ + parse use (String.sub buf end_ (String.length buf - end_))
    with
      Not_found -> String.length buf
    | Not_enough -> !start
end