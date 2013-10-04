(*
 * $Id: ocaml_tools.mli,v 1.1.1.1 2005/01/25 10:57:55 poine Exp $
 *
 * Utilities
 *
 * Copyright (C) 2004 CENA/ENAC, Yann Le Fablec
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

(** Version de la librairie Ocaml_tools sous la forme d'une chaine *)
val ocaml_tools_version : string


(** {6 Fonctions de comparaison} *)


(** [cmp_string entier1 entier2] compare les 2 entiers (pour un List.sort) *)
val cmp_int : int -> int -> int

(** [cmp_float float1 float2] compare les 2 flottants (pour un List.sort) *)
val cmp_float : 'a -> 'a -> int

(** [cmp_string chaine1 chaine2] compare les 2 chaines (pour un List.sort) *)
val cmp_string : 'a -> 'a -> int


(** {6 Manipulation de chaines de caract�res} *)


(** [split caractere chaine] d�coupe [chaine] suivant [caractere] et renvoie la
   liste des mots decoup�s. Toutes les lignes commencant par '#' sont supprim�es *)
val split : char -> string -> string list

(** [split2 caractere chaine] d�coupe [chaine] suivant [caractere] et renvoie la
   liste des mots decoup�s. Toutes les lignes commencant par '#' sont supprim�es.
   Ici, on d�coupe apr�s chaque occurence de [caractere], il peut donc y avoir
   des mots vides renvoy�s *)
val split2 : char -> string -> string list

(** [split_multiple lst_caracteres chaine] d�coupe [chaine] suivant les
   caract�res pr�cis�s comme la fonction [split] sauf qu'ici on peut pr�ciser
   plusieurs caract�res de d�coupage *)
val split_multiple : char list -> string -> string list

(** [split_multiple2 lst_caracteres chaine] d�coupe [chaine] suivant les
   caract�res pr�cis�s comme la fonction [split] sauf qu'ici on peut pr�ciser
   plusieurs caract�res de d�coupage. On d�coupe apr�s chaque occurence d'un des
   caract�res indiqu�s comme avec {!Ocaml_tools.split2} *)
val split_multiple2 : char list -> string -> string list

(** [add_spaces longueur chaine] ajoute des espaces � [chaine] pour qu'elle fasse
   [longueur] caract�res *)
val add_spaces : int -> string -> string

(** [delete_trailing_spaces chaine] supprime les espaces �ventuels � la fin de
   [chaine] *)
val delete_trailing_spaces : string -> string

(** [string_replace_char chaine caractere1 caractere2] remplace toutes les
   occurences de [caractere1] par [caractere2] dans [chaine] *)
val string_replace_char : string -> char -> char -> unit

(** [string_dos2unix chaine] supprime l'eventuel caract�re CTRL-M en fin
   de chaine (transformation d'un fichier DOS vers Unix). *)
val string_dos2unix : string -> string

(** [string_match pattern chaine] indique si le d�but de [chaine] est identique
   � [pattern] *)
val string_match : string -> string -> bool

(** [string_exact_match pattern chaine] indique si [chaine] est identique
   � [pattern] (i.e chaine=pattern) *)
val string_exact_match : 'a -> 'a -> bool

(** [string_match_no_case pattern chaine] identique � {!Ocaml_tools.string_match}
   except� que le test ne tient pas compte de la case des caract�res *)
val string_match_no_case : string -> string -> bool

(** [string_exact_match_no_case pattern chaine] identique �
   {!Ocaml_tools.string_exact_match}
   except& que le test ne tient pas compte de la case des caract�res *)
val string_exact_match_no_case : string -> string -> bool

(** [string_match_in pattern chaine] teste si la chaine contient [pattern] *)
val string_match_in : string -> string -> bool

(** [string_match_in_no_case pattern chaine] teste si la chaine contient
   [pattern]. Le test ne tient pas compte de la case des caract�res *)
val string_match_in_no_case : string -> string -> bool

(** [string_of_string_list liste_de_chaines] construit une chaine � partir
   d'une liste de chaines de caract�res *)
val string_of_string_list : string list -> string

(** [eval_string chaine_base n feminin premier_char_capital] construit une chaine
   de caract�res � partir d'un nombre :
   - [chaine_base] indique le nom
   - [n] indique le nombre
   - [feminin] indique si le nom est f�minin
   - [premier_char_capital] indique si le premier caract�re de la chaine doit etre
   en majuscule

   ex :
   - [eval_string "secteur" 0 false true] donne "Aucun secteur"
   - [eval_string "secteur" 1 false true] donne "Un secteur"
   - [eval_string "secteur" 2 false true] donne "2 secteurs"
 *)
val eval_string : string -> int -> bool -> bool -> string

(** [do_parse_string chaine numero_ligne parser_main lexer_token end_func] parse
   une chaine de caract�res au lieu d'un fichier*)
val do_parse_string :
  string ->
  int ref -> ('a -> Lexing.lexbuf -> unit) -> 'a -> (unit -> 'b) -> 'b

(** [parse_config_file fichier spec_list anofun usage_msg] parse un fichier de configuration
   comme si c'�tait des options pass�es sur la ligne de commandes *)
val parse_config_file : string ->
  (string * Arg.spec * string) list -> (string -> unit) -> string -> unit

(** {6 Listes} *)


(** [supprime_dbl_list liste] supprime les doublons dans une liste d'entiers
   tri�e *)
val supprime_dbl_list : 'a list -> 'a list

(** [del_elt_lst liste index] supprime l'�l�ment d'index [index] dans la liste *)
val del_elt_lst : 'a list -> int -> 'a list


(** {6 Ouverture/fermeture de fichiers compress�s} *)


(** [open_compress fichier] ouvre [fichier] qui peut etre non compress�,
   compress� avec gzip (se terminant par .gz ou .Z), avec bzip2 (se terminant par .bz2)
   ou avec zip (extension en .zip ou .ZIP). Dans ce dernier cas, seuls les fichiers
   zipp�s contenant UN seul fichier sont pris en compte *)
val open_compress : string -> in_channel

(** [close_compress fichier channel] ferme un fichier ouvert
   avec {!Ocaml_tools.open_compress} *)
val close_compress : string -> in_channel -> unit

(** [find_file path file] Search for [file] or a compressed extension of it in
[path]. Returns the first occurence found. Checked extensions are .gz, .Z, .bz2, .zip
and , ZIP *)
val find_file : string list -> string -> string

(** [open_gzip fichier] ouvre un fichier non compress� ou compress� avec gzip
   (.gz ou .Z) *)
val open_gzip : string -> in_channel

(** [close_gzip fichier channel] ferme un fichier non compress� ou
   compress� avec gzip (.gz ou .Z) *)
val close_gzip : string -> in_channel -> unit

(** [open_bzip fichier] ouvre un fichier non compress� ou compress� avec bzip2
   (.bz2) *)
val open_bzip : string -> in_channel

(** [close_bzip fichier channel] ferme un fichier non compress� ou
   compress� avec bzip2 (.bz2) *)
val close_bzip : string -> in_channel -> unit

(** [open_zip fichier] ouvre un fichier non compress� ou compress� avec zip
   (.zip ou .ZIP) *)
val open_zip : string -> in_channel

(** [close_zip fichier channel] ferme un fichier non compress� ou
   compress� avec zip *)
val close_zip : string -> in_channel -> unit

(** [do_compress_file fichier extension] effectue la compression du fichier avec
   gzip si [extension] vaut ".gz" ou bzip2 si [extension] vaut ".bz2" *)
val do_compress_file : string -> string -> unit


(** {6 Lecture/parsing de fichiers} *)


(** [string_of_file fichier] lit le fichier (�ventuellement compress�) et renvoie
   une chaine de caract�res correspondant � son contenu *)
val string_of_file : string -> string

(** [do_read_file_with_separators fichier match_func end_func separateurs] lit
   un fichier et decoupe chacune de ses lignes suivant les caract�res [separateurs].
   Les lignes ainsi decoup�es sont pass�es � la fonction utilisateur [match_func]
   qui les traite. Cette fonction re�oit comme arguments la liste des mots de
   la ligne decoup�e ainsi qu'une fonction d'erreur � appeler si la ligne
   n'est pas au format voulu.
   En fin de lecture, la fonction [end_func] est appel�e *)
val do_read_file_with_separators :
  string ->
  (string list -> (unit -> unit) -> unit) -> (unit -> unit) -> char list -> unit

(** [do_read_file_with_separator fichier match_func end_func separateur] lit
   un fichier et decoupe chacune de ses lignes suivant le caract�re [separateur].
   Les lignes ainsi decoup�es sont pass�es � la fonction utilisateur [match_func]
   qui les traite. Cette fonction re�oit comme arguments la liste des mots de
   la ligne decoup�e ainsi qu'une fonction d'erreur � appeler si la ligne
   n'est pas au format voulu.
   En fin de lecture, la fonction [end_func] est appel�e *)
val do_read_file_with_separator :
  string ->
  (string list -> (unit -> unit) -> unit) -> (unit -> unit) -> char -> unit

(** [do_read_file fichier match_func end_func] : meme chose que
   {!Ocaml_tools.do_read_file_with_separator} sauf que le caract�re s�parateur
   est implicitement l'espace *)
val do_read_file :
  string -> (string list -> (unit -> unit) -> unit) -> (unit -> unit) -> unit

(** [do_read_file_with_separators2 fichier match_func end_func separateurs] :
   identique � {!Ocaml_tools.do_read_file_with_separators} sauf qu'on d�coupe
   apr�s chaque occurence des caract�res de s�paration *)
val do_read_file_with_separators2 :
  string ->
  (string list -> (unit -> unit) -> unit) -> (unit -> unit) -> char list -> unit

(** [do_read_file_with_separator2 fichier match_func end_func separateur] :
   identique � {!Ocaml_tools.do_read_file_with_separator} sauf qu'on d�coupe
   apr�s chaque occurence du caract�re de s�paration *)
val do_read_file_with_separator2 :
  string ->
  (string list -> (unit -> unit) -> unit) -> (unit -> unit) -> char -> unit

(** [do_read_file2 fichier match_func end_func] : meme chose que
   {!Ocaml_tools.do_read_file} sauf qu'on d�coupe
   apr�s chaque occurence du caract�re de s�paration *)
val do_read_file2 :
  string -> (string list -> (unit -> unit) -> unit) -> (unit -> unit) -> unit

(** [do_parse_file fichier numero_ligne parser_main lexer_token end_func] lit
   un fichier qui est analys� par un parser. Les arguments utilis�s sont :
   - [fichier] : le nom du fichier � traiter
   - [numero_ligne] : r�f�rence sur un entier contenant le num�ro de la ligne
   en cours de lecture
   - [parser_main] : la fonction [main] du parser
   - [lexer_token] : la fonction [token] du lexer
   - [end_func] : fonction utilisateur appel�e en fin de lecture du fichier
 *)
val do_parse_file :
  string ->
  int ref -> ('a -> Lexing.lexbuf -> unit) -> 'a -> (unit -> unit) -> unit


(** {6 R�pertoires/Noms de fichiers} *)


(** [is_directory nom] test si [nom] est un r�pertoire *)
val is_directory : string -> bool

(** [get_files_from_dir repertoire] renvoie une liste de chaines de caract�res
   contenant les r�pertoires et fichiers contenus dans [repertoire] *)
val get_files_from_dir : string -> string list

(** [get_dirs_only_from_dir repertoire] renvoie une liste de chaines de caract�res
   contenant les r�pertoires contenus dans [repertoire] (sans "." et "..") *)
val get_dirs_only_from_dir : string -> string list

(** [get_files_only_from_dir repertoire] renvoie une liste de chaines de caract�res
   contenant les fichiers contenus dans [repertoire] *)
val get_files_only_from_dir : string -> string list

(** [del_path_in_filename fichier] supprime l'�ventuel chemin contenu dans
   la chaine [fichier] *)
val del_path_in_filename : string -> string


(** {6 Manipulation de dates} *)


(** [decompose_date date] decompose une [date] de la forme 20020114 en un triplet
   contenant le jour, le mois et l'ann�e (ici (14, 01, 2002)) *)
val decompose_date : int -> int * int * int

(** [compose_date (jour, mois, annee)] effectue l'operation inversion de
   {!Ocaml_tools.decompose_date} *)
val compose_date : int * int * int -> int

(** [get_month_of_num numero_du_mois] renvoie une chaine de caract�res contenant
   le mois donn� par son num�ro. 1 -> "Janvier" *)
val get_month_of_num : int -> string

(** [get_day_of_date (jour, mois, annee)] renvoie une chaine indiquant le jour
   de la semaine correspondant � la date donn�e *)
val get_day_of_date : int * int * int -> string

(** [get_day_of_date2 date] renvoie une chaine indiquant le jour
   de la semaine correspondant � la date donn�e *)
val get_day_of_date2 : int -> string

(** [is_year_bis annee] indique si l'ann�e donn�e est bissextile ou pas *)
val is_year_bis : int -> bool

(** [get_nb_days_in_month mois annee] indique le nombre de jour du mois de l'ann�e
   indiqu�e ([mois]=1 correspond a Janvier) *)
val get_nb_days_in_month : int -> int -> int

(** [get_delta_date (jour, mois, annee) delta_jours] renvoie un triplet contenant
   la date augment�e de [delta_jours]. [delta_jours] peut etre n�gatif *)
val get_delta_date : int * int * int -> int -> int * int * int

(** [get_delta_date date delta_jours] renvoie une date enti�re correspondant �
   [date] augment�e de [delta_jours]. [delta_jours] peut etre n�gatif *)
val get_delta_date2 : int -> int -> int

(** [get_next_date (jour, mois, annee)] renvoie un triplet correspondant � la date
   augment�e de 1 jour *)
val get_next_date : int * int * int -> int * int * int

(** [get_next_date2 date] renvoie une date correspondant � [date]
   augment�e de 1 jour *)
val get_next_date2 : int -> int

(** [get_prev_date (jour, mois, annee)] renvoie un triplet correspondant � la date
   diminu�e de 1 jour *)
val get_prev_date : int * int * int -> int * int * int

(** [get_prev_date2 date] renvoie une date correspondant � [date] diminu�e de
   1 jour *)
val get_prev_date2 : int -> int

(** [get_diff_date (jour1, mois1, annee1) (jour2, mois2, annee2)] renvoie le nombre de jours (sign�) s�parant la premi�re date de la seconde (d2-d1) *)
val get_diff_date : int * int * int -> int * int * int -> int

(** [get_diff_date2 date1 date2] idem � la fonction pr�c�dente avec des dates en entiers sous la forme AAAAMMJJ *)
val get_diff_date2 : int -> int -> int

(** [string_of_date (jour, mois, annee)] fournit une chaine correspondant � la date
   sous la forme JJ/MM/AAAA *)
val string_of_date : int * int * int -> string

(** [string_of_date2 date] fournit une chaine correspondant � la date
   sous la forme JJ/MM/AAAA *)
val string_of_date2 : int -> string


(** {6 Manipulation de temps} *)


(** [string_of_time temps] transforme un [temps] en secondes en une chaine
   au format hh:mm:ss *)
val string_of_time : int -> string

(** [string_of_time_without_seconds temps] transforme un [temps] en
   secondes en une chaine au format hh:mm *)
val string_of_time_without_seconds : int -> string

(** [time_of_string chaine] transforme une chaine au format hh:mm:ss en secondes *)
val time_of_string : string -> int

(** renvoie l'heure actuelle *)
val timer_get_time : unit -> Unix.tm

(** [timer_string_of_time heure] renvoie une chaine sous la forme hh:mm:ss *)
val timer_string_of_time : Unix.tm -> string

(** [timer_string_of_date heure] renvoie une chaine au format JJ/MM/AAAA *)
val timer_string_of_date : Unix.tm -> string

(** [timer_sub heure1 heure2] renvoie le nombre de secondes ecoul�es entre
   [heure1] et [heure2] *)
val timer_sub : Unix.tm -> Unix.tm -> int

(** [timer_string_of_secondes secondes] renvoie une chaine � partir du temps donn�
   en secondes. La chaine est au format h:mm:ss *)
val timer_string_of_secondes : int -> string


(** {6 Tirages al�atoires} *)

(** [tirage_aleatoire_lst liste] effectue un tirage al�atoire d'un des �l�ments de la
   liste et renvoie cet �l�ment *)
val tirage_aleatoire_lst : 'a list -> 'a
