(*
 * $Id: pprz.mli,v 1.15 2006/08/29 06:51:10 hecto Exp $
 *
 * Downlink protocol (handling messages.xml)
 *  
 * Copyright (C) 2003 Pascal Brisset, Antoine Drouin
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

val messages_xml : unit -> Xml.xml

type class_name = string
type message_id = int
type ac_id = int
type format = string
type _type = 
    Scalar of string
  | ArrayType of string
type value = 
    Int of int | Float of float | String of string | Int32 of int32
  | Array of value array
type field = { _type : _type; fformat : format; }
type message = { name : string; fields : (string * field) list; }
(** Message specification *)

val separator : string
(** Separator in array values *)

val size_of_field : field -> int
val string_of_value : value -> string
type type_descr = {
    format : string ;
    glib_type : string;
    inttype : string;
    size : int;
    value : value
  }
val types : (string * type_descr) list
type values  = (string * value) list

val assoc : string -> values -> value
(** Safe assoc taking into accound characters case *)

val string_assoc : string -> values -> string
(** May raise Not_found *)

val float_assoc : string -> values -> float
val int_assoc : string -> values -> int
val int32_assoc : string -> values -> Int32.t
(** May raise Not_found or Invalid_argument *)

exception Unknown_msg_name of string * string
(** [Unknown_msg_name (name, class_name)] Raised if message [name] is not
found in class [class_name]. *)

module Transport : Serial.PROTOCOL

val offset_fields : int

module type CLASS = sig val name : string end
module Messages : functor (Class : CLASS) -> sig
  val message_of_id : message_id -> message
  val message_of_name : string ->  message_id * message
  val values_of_payload : Serial.payload -> message_id * ac_id * values
  (** [values_of_bin payload] Parses a raw payload, returns the
   message id, the A/C id and the list of (field_name, value) *)

  val payload_of_values : message_id -> ac_id -> values -> Serial.payload
  (** [payload_of_values id ac_id vs] Returns a payload *)

  val values_of_string : string -> message_id * values
  (** May raise [(Unknown_msg_name msg_name)] *)

  val string_of_message : ?sep:string -> message -> values -> string
  (** [string_of_message ?sep msg values] Default [sep] is space *)

  val message_send : string -> string -> values -> unit
  (** [message_send sender msg_name values] *)

  val message_bind : ?sender:string ->string -> (string -> values -> unit) -> Ivy.binding
  (** [message_bind ?sender msg_name callback] *)

  val message_answerer : string -> string -> (string -> values -> values) -> Ivy.binding
  (** [message_answerer sender msg_name callback] *)

  val message_req : string -> string -> values -> (string -> values -> unit) -> unit
  (** [message_answerer sender msg_name values receiver] Sends a request on the Ivy bus for the specified message. On reception, [receiver] will be applied on [sender_name] and expected values. *)
end
