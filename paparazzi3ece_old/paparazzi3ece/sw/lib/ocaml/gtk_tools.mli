(*
 * $Id: gtk_tools.mli,v 1.3 2006/05/28 09:12:31 hecto Exp $
 *
 * Lablgtk2 utils
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
(** Module outils pour lablgtk-2.4.0

   Nouveaux widgets et encapsulation de fonctions GTK pour faciliter
   l'utilisation de la bibliotheque lablgtk

   {b D�pendences : Platform, Ocaml_Tools}

   {e Yann Le Fablec, version 4.10, 26/08/2004}
 *)

(** Chaine indiquant la version de la librairie *)
val version : string


(** {6 Fonctions principales} *)


(** force la mise � jour de l'interface *)
val force_update_interface : unit -> unit

(** initialise les couleurs *)
val init_colors : unit -> unit

(** lance la mainloop de l'interface *)
val main_loop : unit -> unit

(** initialise le systeme d'aide contextuelle et renvoie l'objet correspondant *)
val init_tooltips : unit -> GData.tooltips

(** [gtk_tools_add_tooltips tooltips widget texte] ajoute une aide contextuelle
   � un widget *)
val add_tooltips :
  GData.tooltips -> < coerce : GObj.widget; .. > -> string -> unit

(** renvoie la largeur et la hauteur de l'�cran en pixels *)
val get_screen_size : unit -> int * int

(** [gtk_tools_disconnect wid id] d�connecte le signal [id] du widget [wid] *)
val disconnect :
  < misc : < disconnect : 'a -> 'b; .. >; .. > -> 'a -> 'b

(** [gtk_tools_set_sensitive widget sensitive] active/d�sactive un widget *)
val set_sensitive :
  < misc : < set_sensitive : 'a -> 'b; .. >; .. > -> 'a -> unit

(** [gtk_tools_set_sensitive_list widgets sensitive] active/d�sactive une liste
   de widgets *)
val set_sensitive_list :
  < misc : < set_sensitive : 'a -> 'b; .. >; .. > list -> 'a -> unit

(** [gtk_tools_set_cursor window cursor] met � jour la forme du curseur dans la
   fenetre indiqu�e *)
val set_cursor : Gdk.window -> Gdk.cursor -> unit

(** [gtk_tools_get_widget_size widget] renvoie un couple donnant la largeur et
   la hauteur du widget indiqu� *)
val get_widget_size :
  < misc : < allocation : Gtk.rectangle; .. >; .. > -> int * int

(** [gtk_tools_set_widget_back_color widget couleur] modifie la couleur de fond
   d'un widget. Marche avec les widgets cr�ant une fenetre (les boutons
   par exemple), �a ne fonctionne donc pas avec les labels pour lesquels il faut
   une event_box...*)
val set_widget_back_color :
    < misc : < set_style : (< set_bg : ([> `NORMAL] * GDraw.color) list ->
                                       'c;
                              .. > as 'a) ->
                           'd;
               style : < copy : 'a; .. >; .. >;
      .. > -> GDraw.color -> unit

(** [gtk_tools_set_widget_front_color w color] modifie la couleur du texte d'un widget
   (du type label) *)
val set_widget_front_color :
    < misc : < set_style : (< set_fg : ([> `NORMAL] * GDraw.color) list ->
	  'b; .. > as 'a) -> 'c; style : < copy : 'a; .. >; .. >; .. > ->
		GDraw.color -> unit

(** [gtk_tools_set_button_front_color bouton color] modifie la couleur du texte d'un
   bouton (la fonction pr�c�dente ne marche pas avec un bouton car le texte d'un bouton
   ne se trouve pas directement dans le bouton mais dans un label fils de ce bouton *)
val set_button_front_color : GButton.button -> GDraw.color -> unit

(** [gtk_tools_set_button_back_color bouton color] modifie la couleur de fond d'un bouton. *)
val set_button_back_color : GButton.button -> GDraw.color -> unit

(** [gtk_tools_set_entry_front_color entry color] modifie la couleur du texte dans une entry *)
val set_entry_front_color : GEdit.entry -> GDraw.color -> unit

(** [gtk_tools_set_entry_back_color entry color] modifie la couleur de fond d'une entry *)
val set_entry_back_color : GEdit.entry -> GDraw.color -> unit

(** [gtk_tools_set_entry_outline_color entry color] modifie la couleur du contour d'une entry *)
val set_entry_outline_color : GEdit.entry -> GDraw.color -> unit


(** [gtk_tools_scroll_adjustment adj scroll_up delta] effectue le scrolling d'un
   adjustment [adj] (d'une scrollbar par exemple) vers le haut si [scroll_up] est vrai
   et vers le bas sinon. [delta] d�signe la valeur absolue du deplacement *)
val scroll_adjustment : GData.adjustment -> bool -> float -> unit

(** [gtk_tools_connect_mouse_wheel_scroll widget scrollbar delta] connecte
   un scroll de valeur absolue [delta] de la scrollbar [scrollbar]
   lors de l'utilisation de la molette souris dans le widget [widget] *)
val connect_mouse_wheel_scroll :
	< event : < connect : < button_press : callback:(GdkEvent.Button.t ->
      bool) -> 'a; scroll : callback:(GdkEvent.Scroll.t -> bool) -> 'a; .. >; .. >; .. >
		-> GRange.range -> float -> unit

(** {6 Ev�nements souris} *)


(** Boutons souris *)
type bouton_souris = B_GAUCHE | B_DROIT | B_MILIEU | B_NONE

(** [gtk_tools_test_mouse_but event] renvoie un element de type
   {!Gtk_tools.gtk_tools_bouton_souris} indiquant le bouton de souris press� lors
   d'un click souris *)
val test_mouse_but : GdkEvent.Button.t -> bouton_souris

(** [gtk_tools_get_mouse_pos_click event] renvoie un couple d'entiers donnant
   la position de la souris lors d'un click *)
val get_mouse_pos_click : GdkEvent.Button.t -> int * int

(** [gtk_tools_get_mouse_pos_move event] renvoie un element de type
   {!Gtk_tools.gtk_tools_bouton_souris} indiquant le bouton de souris press�
   pendant un deplacement de la souris *)
val get_mouse_pos_move : GdkEvent.Motion.t -> int * int

(** [gtk_tools_check_dbl_click event] teste le double click souris *)
val check_dbl_click : [> `TWO_BUTTON_PRESS] Gdk.event -> bool


(** {6 Fontes/Texte} *)


(** renvoie la fonte 'fixed' 8 points *)
val get_fixed_font : unit -> Gdk.font

(** renvoie la fonte 'fixed' 13 points *)
val get_fixed_font2 : unit -> Gdk.font

(** [gtk_tools_set_widget_font widget font] modifie la fonte d'un widget *)
val set_widget_font :
  < misc : < set_style : (< set_font : 'b -> 'c; .. > as 'a) -> 'd;
             style : < copy : 'a; .. >; .. >;
    .. > ->
  'b -> unit

(** [gtk_tools_string_width_height font string] indique la largeur et la hauteur,
   en pixels, du texte donn� par [string] affich� dans la fonte [font] *)
val string_width_height : Gdk.font -> string -> int * int


(** {6 Boites} *)


(** {0 Boites de widgets} *)

(** [gtk_tools_create_bbox pack_method] cr�e une boite de boutons *)
val create_bbox : (GObj.widget -> unit) -> GPack.button_box

(** [gtk_tools_create_hbox pack_method] cr�ation d'une boite horizontale *)
val create_hbox : (GObj.widget -> unit) -> GPack.box

(** [gtk_tools_create_hom_hbox pack_method] cr�ation d'une boite horizontale o�
   la taille des widgets est homog�ne *)
val create_hom_hbox : (GObj.widget -> unit) -> GPack.box

(** [gtk_tools_create_spaced_hbox pack_method] cr�ation d'une boite horizontale
 avec espacement des widgets de 5 pixels *)
val create_spaced_hbox : (GObj.widget -> unit) -> GPack.box

(** [gtk_tools_create_hom_spaced_hbox pack_method] cr�ation d'une boite horizontale
   avec espacement des widgets de 5 pixels. Les widgets ont en plus une taille
   homog�ne *)
val create_hom_spaced_hbox : (GObj.widget -> unit) -> GPack.box

(** [gtk_tools_create_vbox pack_method] cr�ation d'une boite verticale *)
val create_vbox : (GObj.widget -> unit) -> GPack.box

(** [gtk_tools_create_hom_vbox pack_method] cr�ation d'une boite verticale o�
   la taille des widgets est homog�ne *)
val create_hom_vbox : (GObj.widget -> unit) -> GPack.box

(** [gtk_tools_create_spaced_vbox pack_method] cr�ation d'une boite verticale
 avec espacement des widgets de 5 pixels *)
val create_spaced_vbox : (GObj.widget -> unit) -> GPack.box

(** [gtk_tools_create_hom_spaced_vbox pack_method] cr�ation d'une boite verticale
   avec espacement des widgets de 5 pixels. Les widgets ont en plus une taille
   homog�ne *)
val create_hom_spaced_vbox : (GObj.widget -> unit) -> GPack.box


(** {0 Frames} *)


(** [gtk_tools_create_vframe title pack_method] cr�e une frame contenant une vbox*)
val create_vframe :
  string -> (GObj.widget -> unit) -> GBin.frame * GPack.box

(** [gtk_tools_create_spaced_vframe title pack_method] cr�e une frame contenant une vbox
   avec espaces *)
val create_spaced_vframe :
  string -> (GObj.widget -> unit) -> GBin.frame * GPack.box

(** [gtk_tools_create_hframe title pack_method] cr�e une frame contenant une hbox*)
val create_hframe :
  string -> (GObj.widget -> unit) -> GBin.frame * GPack.box

(** [gtk_tools_create_spaced_hframe title pack_method] cr�e une frame contenant une hbox
   avec espaces *)
val create_spaced_hframe :
  string -> (GObj.widget -> unit) -> GBin.frame * GPack.box


(** {0 Boites scrollables} *)


(** [gtk_tools_create_scrolled_box pack_method] cr�e une zone scrollable contenant
   une vbox. Renvoie la zone et la vbox *)
val create_scrolled_box :
  (GObj.widget -> unit) -> GBin.scrolled_window * GPack.box

(** [gtk_tools_change_scrolled_box scrolled_window old_box] d�truit puis recr�e
   la vbox dans une zone scrollable. Renvoie la nouvelle vbox *)
val change_scrolled_box :
  < add_with_viewport : GObj.widget -> unit; .. > ->
  < destroy : unit -> 'a; .. > -> GPack.box


(** {0 Notebooks} *)


(** [gtk_tools_create_notebook pack_method] cr�e un notebook (widget contenant
   diff�rentes pages *)
val create_notebook : (GObj.widget -> unit) -> GPack.notebook

(** [gtk_tools_notebook_add_page notebook page_label] ajoute une page nomm�e
   [page_label] au notebook indiqu�. En retour un couple contenant une frame
   et une boite verticale dans cette frame est retourn� *)
val notebook_add_page :
  GPack.notebook -> string -> GBin.frame * GPack.box


(** {0 Paned windows} *)


(** [gtk_tools_create_hpaned pack_method] cr�ation d'une zone avec division
   mobile horizontale *)
val create_hpaned : (GObj.widget -> unit) -> GPack.paned

(** [gtk_tools_create_vpaned pack_method] cr�ation d'une zone avec division
   mobile verticale *)
val create_vpaned : (GObj.widget -> unit) -> GPack.paned


(** {6 Boutons} *)


(** [gtk_tools_create_button label pack_method] cr�ation d'un bouton *)
val create_button :
  string -> (GObj.widget -> unit) -> GButton.button

(** [gtk_tools_create_sized_button label width pack_method] cr�ation d'un bouton
   ayant une taille fix�e *)
val create_sized_button :
  string -> int -> (GObj.widget -> unit) -> GButton.button

(** [gtk_tools_but_connect but func] connecte le callback [func] au bouton [but] *)
val but_connect :
  < connect : < clicked : callback:'a -> 'b; .. >; .. > -> 'a -> unit

(** [gtk_tools_but_set_label but label] change le texte dans le bouton pour le
   remplacer par [label] *)
val but_set_label :
	< children : < as_widget : 'a Gtk.obj; .. > list; .. > -> string -> unit

(** [gtk_tools_set_button_align but pos] change l'alignement du texte
   d'un bouton *)
val set_button_align :
	< children : < as_widget : 'a Gtk.obj; .. > list; .. > -> float -> unit

(** [gtk_tools_set_button_align_left but] alignement du texte
   du bouton � gauche*)
val set_button_align_left :
	< children : < as_widget : 'a Gtk.obj; .. > list; .. > -> unit

(** [gtk_tools_set_button_align_right but] idem � droite *)
val set_button_align_right :
	< children : < as_widget : 'a Gtk.obj; .. > list; .. > -> unit

(** [gtk_tools_set_button_align_center but] idem au milieu *)
val set_button_align_center :
	< children : < as_widget : 'a Gtk.obj; .. > list; .. > -> unit

(** [gtk_tools_set_button_padding but xpad] met a jour la position du texte dans le bouton *)
val set_button_padding :
	< children : < as_widget : 'a Gtk.obj; .. > list; .. > -> int -> unit

(** [gtk_tools_but_set_width but width] met a jour la largeur d'un bouton *)
val but_set_width : GButton.button -> int -> unit

(** [gtk_tools_but_set_height but height] met a jour la hauteur d'un bouton *)
val but_set_height : GButton.button -> int -> unit

(** [gtk_tools_create_buttons lst_buts tooltips pack_method] cr�e une rang�e de
   boutons plac�s dans une {!Gtk_tools.gtk_tools_create_bbox}. Le param�tre
   [lst_buts] est une liste de couples du type [(nom du bouton, aide)] *)
val create_buttons :
  (string * string) list ->
  GData.tooltips -> (GObj.widget -> unit) -> GButton.button list

(** [gtk_tools_create_buttons_connect lst_buts lst_callbacks] connecte une liste
   de callbacks � une liste de boutons *)
val create_buttons_connect :
  < connect : < clicked : callback:'a -> 'b; .. >; .. > list ->
  'a list -> unit

(** [gtk_tools_create_checkbutton_simple active label pack_method tip tooltips]
 cr�e un check button sans callback mais avec une aide contextuelle si [tip]<>""*)
val create_checkbutton_simple :
  bool ->
  string ->
  (GObj.widget -> unit) -> string -> GData.tooltips -> GButton.toggle_button

(** [gtk_tools_create_checkbutton active label pack_method tip tooltips callback]
   cr�e un check button avec callback et une aide contextuelle (si [tip]<>"") *)
val create_checkbutton :
  bool ->
  string ->
  (GObj.widget -> unit) ->
  string -> GData.tooltips -> (bool -> unit) -> GButton.toggle_button

(** [gtk_tools_create_radiobuttons_simple lst_names func_active pack_method] cr�e
   une liste de radio boutons :
   - [lst_names] est une liste contenant des couples [(nom_bouton, type_associe)]
   - [func_active] indique quel est le bouton actif au depart
   - [pack_method] indique o� mettre les boutons
 *)
val create_radiobuttons_simple :
  (string * 'a) list ->
  ('a -> bool) -> (GObj.widget -> unit) -> GButton.radio_button list

(** [gtk_tools_radiobuttons_connect lst_names lst_but func_select] connecte
   un callback li� � la modification du radiobutton selectionn�. Le callback
   re�oit en param�tre le type correspondant � ce bouton *)
val radiobuttons_connect :
  ('a * 'b) list -> GButton.radio_button list -> ('b -> unit) -> unit

(** [gtk_tools_create_radiobuttons lst_names func_active func_select pack_method]
   cr�e des radiobuttons avec callback *)
val create_radiobuttons :
  (string * 'a) list ->
  ('a -> bool) ->
  ('a -> unit) -> (GObj.widget -> unit) -> GButton.radio_button list

(** [gtk_tools_create_togglebutton label active pack_method] cr�e un togglebutton*)
val create_togglebutton :
  string -> bool -> (GObj.widget -> unit) -> GButton.toggle_button

(** [gtk_tools_create_pixbutton pixmap pack_method] cr�ation d'un bouton contenant
   une pixmap *)
val create_pixbutton :
  GDraw.pixmap -> (GObj.widget -> unit) -> GButton.button


(** {6 Labels} *)


(** [gtk_tools_create_label label pack_method] cr�ation d'un label *)
val create_label : string -> (GObj.widget -> unit) -> GMisc.label

(** [gtk_tools_create_sized_label label width pack_method] cr�ation d'un label
   avec une taille fix�e *)
val create_sized_label :
  string -> int -> (GObj.widget -> unit) -> GMisc.label

(** {0 Alignement des labels} *)

(** [gtk_tools_create_sized_label_align label width pos pack_method] cr�ation d'un label
   avec une taille fix�e. Le texte est positionn� suivant [pos] qui est compris entre
   0.0 et 1.0 (0.0 = � gauche et 1.0 = � droite) *)
val create_sized_label_align :
  string -> int -> float -> (GObj.widget -> unit) -> GMisc.label

(** [gtk_tools_create_sized_label_align_left label width pack_method] cr�ation d'un label
   avec une taille fix�e. Le texte est positionn� � gauche dans le label *)
val create_sized_label_align_left :
  string -> int -> (GObj.widget -> unit) -> GMisc.label

(** [gtk_tools_create_sized_label_align_right label width pack_method] cr�ation d'un label
   avec une taille fix�e. Le texte est positionn� � droite dans le label *)
val create_sized_label_align_right :
  string -> int -> (GObj.widget -> unit) -> GMisc.label

(** [gtk_tools_set_label_align label pos] fixe l'alignement du texte dans un label.
   [pos] indique o� se fait l'alignement : 0.0 = � gauche et 1.0 = � droite *)
val set_label_align : GMisc.label -> float -> unit

(** [gtk_tools_set_label_align_left label] fixe l'alignement du texte dans un label
   � gauche *)
val set_label_align_left : GMisc.label -> unit

(** [gtk_tools_set_label_align_right label] fixe l'alignement du texte dans un label
   � droite *)
val set_label_align_right : GMisc.label -> unit

(** [gtk_tools_set_label_align_center label] fixe l'alignement du texte dans un label
   au centre de ce dernier *)
val set_label_align_center : GMisc.label -> unit

(** [gtk_tools_set_label_padding label xpad] fixe la position gauche du texte
   dans un label *)
val set_label_padding : GMisc.label -> int -> unit

(** {6 Boites de dialogue} *)


(** [gtk_tools_question_box window title question_msg default_is_cancel] cr�e une
   fenetre posant une question � l'utilisateur :
   - [window] d�signe la fenetre m�re
   - [title] le titre � donner � la fenetre
   - [question_msg] le message � afficher
   - [defaut_is_cancel] indique si par defaut c'est le bouton Annuler qui est
   selectionn�

   Renvoie vrai si OK a �t� choisi, faux sinon
 *)
val question_box :
  < misc : #GDraw.misc_ops; .. > -> string -> string -> bool -> bool

(** [gtk_tools_error_box window title error_msg] affiche une boite contenant un
   message d'erreur *)
val error_box :
  < misc : #GDraw.misc_ops; .. > -> string -> string -> unit

(** [gtk_tools_animated_msg_box title msg lst_pixmaps] cr�e une boite de message
   contenant un icone anim� dont [lst_pixmaps] d�signe les noms des diff�rentes
   images (pixmaps) de l'animation *)
val animated_msg_box : string -> string -> string list -> unit

(** [gtk_tools_open_file_dlg title read_func update_func default_filename
   check_overwrite] cr�e une boite de selection de fichier :
   - [title] indique le titre � donner � la fenetre
   - [read_func] fonction appel�e pour traiter le fichier selectionn�
   - [update_func] : [None] ou [Some f] fonction optionnelle appel�e apr�s
   le traitement du fichier par la fonction pr�c�dente
   - [default_filename] nom de fichier/r�pertoire par defaut
   - [check_overwrite] indique si on doit tester l'existence du fichier (pour
   eviter un �crasement
 *)
val open_file_dlg :
  string -> (string -> 'a) -> (unit -> unit) option -> string -> bool -> unit

(** [gtk_tools_select_font_dlg tooltips fonte_init selection_func] ouvre une fenetre
   de selection de fonte. Si une fonte est choisie, [selection_func] est
   appel�e avec son nom. [fonte_init] d�signe le nom de la fonte s�lectionn�e par
   d�faut ("" pour rien). *)
val select_font_dlg : GData.tooltips -> string -> (string -> unit)
  -> GMisc.font_selection

(** {6 Timers} *)


(** Type de timer *)
type timer_type =
	TIMER_TIME          (** Heure uniquement *)
  | TIMER_DATE          (** Date uniquement  *)
  | TIMER_TIME_AND_DATE (** Affichage de l'heure et de la date *)

(** [gtk_tools_insert_timer label timer_type force_beginning] place un timer
   de type [timer_type] dans le widget [label]. Si [force_beginning] est vrai
   alors l'affichage commence d�s la creation du timer *)
val insert_timer :
  GMisc.label -> timer_type -> bool -> unit


(** {6 Menus} *)

(** [gtk_tools_popup menus_entries] affiche un popup menu *)
val popup : GToolbox.menu_entry list -> unit

(** [gtk_tools_connect_popup_menu wid button test_cond_func menu_entries] connecte
   un popup menu � un widget :
   - [wid] d�signe le widget concern�
   - [button] le bouton � presser pour afficher le popup menu
   - [test_cond_func] fonction de test indiquant si le menu doit etre affich�
   - [menu_entries] contient la liste des �l�ments du menu
*)
val connect_popup_menu :
  < event : < connect : < button_press : callback:(GdkEvent.Button.t -> bool) ->
                                         'a; .. >; .. >; .. > ->
  bouton_souris ->
  (unit -> bool) -> GToolbox.menu_entry list -> unit

(** [gtk_tools_connect_func_popup_menu wid button test_cond_func get_menu_entries]
   connecte un popup menu construit de mani�re dynamique � un widget :
   - [wid] d�signe le widget concern�
   - [button] le bouton � presser pour afficher le popup menu
   - [test_cond_func] fonction de test indiquant si le menu doit etre affich�
   - [get_menu_entries] d�signe la fonction appel�e au moment de l'appui sur
   le bouton et qui renvoie la liste des �l�ments du menu *)
val connect_func_popup_menu :
  < event : < connect : < button_press : callback:(GdkEvent.Button.t -> bool) ->
                                         'a; .. >; .. >; .. > ->
  bouton_souris ->
  (unit -> bool) -> (unit -> GToolbox.menu_entry list) -> unit

(** [gtk_tools_create_popup_menu title event data] cr�e un popup menu la o� se
   trouve la souris. [data] est une liste d'�l�ments indiquant le contenu du menu
   sous la forme [(texte, Some fonction, parametre fonction, sous menu)].
   [titre] d�signe le titre du menu, peut etre egal � "" pour ne pas mettre
   de titre *)
val create_popup_menu :
  string ->
  GdkEvent.Button.t ->
  (string * ('a -> unit) option * 'a *
   (string * ('b -> unit) option * 'b) list)
  list -> unit

(** [gtk_tools_create_optionmenu lst_names func_active func_select pack_method]
   creation d'un menu � options :
   - [lst_names] contient la liste des options avec leur type sous la forme
   [(nom, type)]
   - [func_active] indique quelle est l'option active par defaut
   - [func_select] appel�e lors de la modification de l'option
   - [pack_method] d�signe l'endroit o� mettre le menu

   Renvoie le menu ainsi qu'une fonction permettant de mettre � jour l'option
   courante et une seconde fonction mettant � jour l'option courante et qui
   appelle la fonction [func_select] en plus :
   [(option_menu, set_option, set_option_and_activate)]
 *)
val create_optionmenu :
  (string * 'a) list ->
  ('a -> bool) ->
  ('a -> unit) -> (GObj.widget -> unit) ->
  GMenu.option_menu * ('a -> unit) * ('a -> unit)

(** [separateur dans un menu] *)
val menu_separator : string * (unit -> unit)

(** [gtk_tools_create_simple_menu menu lst_items] cr�e un menu attach� � [menu]
   et d�fini par [lst_items]. [lst_items] est une liste d'�l�ments du type
   [(texte_menu, action)] d�finissant les �l�ments du menu � cr�er *)
val create_simple_menu :
  #GMenu.menu_shell -> (string * (unit -> unit)) list -> unit

(** [gtk_tools_create_menu menus nb_menus lst_items] : identique � la fonction
   pr�c�dente sauf que [menus] d�signe un tableau de menus et [nb_menus] la r�f�rence
   sur une variable indiquant le menu courant dans ce tableau *)
val create_menu :
  #GMenu.menu_shell array ->
  int ref -> (string * (unit -> unit)) list -> unit

(** Initialise la variable de stockage des menus (permet de les activer ou de les
   desactiver) *)
val init_menus_sens : unit -> (string, (string*GMenu.menu_item) list) Hashtbl.t

(** [gtk_tools_create_simple_menu_sens menu lst_items] cr�e un menu dont les sous-menus
   peuvent etre activ�s ou d�sactiv�s *)
val create_simple_menu_sens : #GMenu.menu_shell -> GToolbox.menu_entry list ->
  (string * GMenu.menu_item) list

(** [gtk_tools_create_menu_sens menus tab_menus_names store_menus nb_menus lst_items] cr�� un menu
   dont les sous-menus peuvent etre rendus actifs ou inactifs. [menus] d�signe le tableau des menus,
   [tab_menus_names] est un tableau contenant les noms des ces menus, [store_menus] contient la
   variable de stockage cr��e avec {!Gtk_tools.gtk_tools_init_menus_sens}, nb_menus est une r�f�rence
   sur la variable contenant le menu en cours de cr�ation. *)
val create_menu_sens : #GMenu.menu_shell array ->
  string array -> (string, (string*GMenu.menu_item) list) Hashtbl.t ->
	int ref -> GToolbox.menu_entry list -> unit

(** [gtk_tools_set_sub_menu_sensitive store_menus menu_name sub_menu_name sensitive] active ou
   d�sactive (suivant la valeur de [sensitive]) le sous-menu de nom [sub_menu_name] dans le
   menu de nom [menu_name] *)
val set_sub_menu_sensitive :
	(string, (string*GMenu.menu_item) list) Hashtbl.t -> string -> string -> bool -> unit


(** {6 Pixmaps} *)


(** pixmap d'ouverture d'un fichier *)
val open_file_pixmap : string array

(** [gtk_tools_pixmap_from_file filename window] cr�ation d'un [GDraw.pixmap] �
   partir d'un fichier xpm *)
val pixmap_from_file : string -> GWindow.window -> GDraw.pixmap

(** [gtk_tools_create_pixmap window width height] cr�e une pixmap de taille
   [width]*[height] o� [window] d�signe la fenetre m�re de la pixmap.
   En retour, un couple [(pix, pixmap)] o� [pix] sert � mettre la pixmap dans
   une zone de dessin (par ex.) et [pixmap] sert au dessin *)
val create_pixmap :
  GWindow.window -> int -> int -> Gdk.pixmap * GDraw.pixmap

(** [gtk_tools_create_d_pixmap window width height] cr�e un drawable de taille
   [width]*[height] o� [window] d�signe la fenetre m�re du drawable.
   En retour, un couple [(pix, pixmap)] o� [pix] sert � mettre le drawable dans
   une zone de dessin (par ex.) et [pixmap] sert au dessin *)
val create_d_pixmap :
  GWindow.window -> int -> int -> Gdk.pixmap * GDraw.drawable

(** [gtk_tools_create_stipple_pixmap_from_data data width height] cr�e une pixmap
   utilisable pour faire un stipple a partir de [data] qui est une liste d'entiers *)
val create_stipple_pixmap_from_data : int list -> int -> int -> Gdk.pixmap

(** [gtk_tools_rectangle_pixmap window color width height] cr�e une pixmap
   rectangulaire de taille [width]*[height] et de couleur [color] *)
val rectangle_pixmap : GWindow.window -> GDraw.color -> int -> int ->
   GDraw.pixmap


(** {6 Fenetres} *)


(** [gtk_tools_create_window title width height] cr�e une fenetre contenant une
   boite verticale. Si [width] et [height] sont nuls, la fenetre n'a pas de
   taille par d�faut *)
val create_window :
  string -> int -> int -> GWindow.window * GPack.box

(** [gtk_tools_create_window_on_top title width height window] *)
val create_window_on_top :
   string -> int -> int -> GWindow.window -> GWindow.window * GPack.box

(** [gtk_tools_create_window_on_top2 title width height window] *)
val create_window_on_top2 :
   string -> int -> int -> GWindow.window option -> GWindow.window * GPack.box

(** [gtk_tools_create_modal_window title width height] est identique � la fonction
   pr�c�dente sauf que la fenetre est modale *)
val create_modal_window :
  string -> int -> int -> GWindow.window * GPack.box

(** [gtk_tools_create_modal_window_on_top title width height window] *)
val create_modal_window_on_top :
   string -> int -> int -> GWindow.window -> GWindow.window * GPack.box

(** [gtk_tools_create_modal_window_on_top2 title width height window] *)
val create_modal_window_on_top2 :
   string -> int -> int -> GWindow.window option -> GWindow.window * GPack.box

(** [gtk_tools_create_window_with_menubar title width height menubar_items] cr�e
   une fenetre contenant une barre de menus *)
val create_window_with_menubar :
  string ->
  int ->
  int ->
  string list ->
  GWindow.window * GPack.box * GMenu.menu_shell GMenu.factory *
  Gtk.accel_group * GMenu.menu array

(** [gtk_tools_create_window_with_menubar_help title width height menubar_items]
   cr�e une fenetre avec une barre de menus et un menu d'aide � gauche de
   cette barre *)
val create_window_with_menubar_help :
  string ->
  int ->
  int ->
  string list ->
  GWindow.window * GPack.box * GMenu.menu_shell GMenu.factory *
  Gtk.accel_group * GMenu.menu array * GMenu.menu

(** [gtk_tools_window_set_front window] met la fenetre [window] en avant plan *)
val window_set_front : GWindow.window -> unit

(** [gtk_tools_get_window_geometry window] renvoie la position et la taille de
   la fenetre sous la forme [((x, y), (largeur, hauteur))] *)
val get_window_geometry :
  GWindow.window -> (int * int) * (int * int)

(** set_window_position window (x, y) d�place la fenetre pour que son
   coin superieur � gauche soit � la position [(x, y)] *)
val set_window_position : GWindow.window -> int * int -> unit

(** [gtk_tools_window_modify_connect window callback] connection d'un callback
   appel� lors du deplacement ou du changement de taille de la fenetre [window].
   Le callback re�oit en param�tres la position et la taille de la fenetre *)
val window_modify_connect :
  GWindow.window -> ((int * int) * (int * int) -> 'a) -> GtkSignal.id

(** [gtk_tools_connect_win_focus_change window focus_in focus_out] connecte les
   callbacks correspondants aux �v�nements focus_in et focus_out � une fenetre *)
val connect_win_focus_change :
  GWindow.window -> (unit -> 'a) option -> (unit -> 'b) option -> unit



(** {6 Zones de dessin (Drawing Areas)} *)


(** [gtk_tools_create_draw_area_simple width height pack_method pix_expose] cr�e
   une zone de dessin simple o� [pix_expose] d�signe la pixmap � utiliser pour
   redessiner la zone apr�s un event expose. En retour, un couple contenant
   la zone cr��e et la fonction de mise � jour du dessin est renvoy� *)
val create_draw_area_simple :
  int ->
  int ->
  (GObj.widget -> unit) -> Gdk.pixmap -> GMisc.drawing_area * (unit -> unit)

(** [gtk_tools_area_mouse_connect area mouse_press mouse_move mouse_release]
   connecte les �v�nements souris � la zone de dessin [area] *)
val area_mouse_connect :
  GMisc.drawing_area ->
  (GdkEvent.Button.t -> bool) ->
  (GdkEvent.Motion.t -> bool) -> (GdkEvent.Button.t -> bool) -> unit

(** [gtk_tools_area_key_connect area key_press key_release] connecte les
   �v�nements claviers � la zone de dessin [area] *)
val area_key_connect :
  GMisc.drawing_area -> (Gdk.keysym -> bool) -> (Gdk.keysym -> bool) -> unit

(** [gtk_tools_create_draw_area width height pack_method pix_expose
   mouse_press mouse_move mouse_release] cr�e une zone de dessin et connecte
   les �v�nements souris *)
val create_draw_area :
  int ->
  int ->
  (GObj.widget -> unit) ->
  Gdk.pixmap ->
  (GdkEvent.Button.t -> bool) ->
  (GdkEvent.Motion.t -> bool) -> (GdkEvent.Button.t -> bool) -> unit -> unit


(** {6 S�lection de couleurs} *)


(** [gtk_tools_select_color update_func] cr�e une boite de selection de couleur.
   La fonction [update_func] est appel�e apr�s s�lection avec en param�tre la
   couleur choisie *)
val select_color : ([> `RGB of int * int * int] -> unit) -> unit

(** [gtk_tools_create_color_selection_button window taille_x taille_y color
	pack_method callback] cr�e un bouton color� permettant le choix d'une couleur.
   - [window] d�signe la fenetre m�re
   - [taille_x] largeur du bouton
   - [taille_y] hauteur du bouton
   - [color] couleur initiale du bouton
   - [pack_method] indique o� mettre le bouton
   - [callback] fonction appel�e lorsqu'une nouvelle couleur est selectionn�e.
   Cette fonction re�oit en param�tre la nouvelle couleur

   Lors du choix d'une nouvelle couleur, la couleur du bouton n'est pas mise � jour
 *)
val create_color_selection_button :
  < misc : #GDraw.misc_ops; .. > ->
  int ->
  int ->
  GDraw.color ->
  (GObj.widget -> unit) ->
  ([> `RGB of int * int * int] -> unit) -> GButton.button

(** [gtk_tools_create_color_selection_button2 window taille_x taille_y color
	pack_method callback] identique � la fonction pr�c�dente sauf que la couleur
   selectionnee est mise � jour dans le bouton *)
val create_color_selection_button2 :
  < misc : #GDraw.misc_ops; .. > ->
  int ->
  int ->
  GDraw.color ->
  (GObj.widget -> unit) -> (GDraw.color -> unit) -> GButton.button

(** [gtk_tools_select_colors_widget window colors tooltips update_func vbox] cr�e
   un widget de selection de plusieurs couleurs. [colors] est une liste d'�l�ments
   au format [(nom_frame, (label, couleur ref, couleur_defaut) list)] *)
val select_colors_widget :
  GWindow.window ->
  (string * (string * GDraw.color ref * GDraw.color) list) list ->
  GData.tooltips option -> (unit -> unit) -> GPack.box -> unit

(** [gtk_tools_select_colors title width height colors tooltips update_func] cr�e
   une fenetre de s�lection de plusieurs couleurs *)
val select_colors :
  string ->
  int ->
  int ->
  (string * (string * GDraw.color ref * GDraw.color) list) list ->
  GData.tooltips option -> (unit -> unit) -> unit




(** {6 S�lection de valeurs enti�res} *)


(** [gtk_tools_create_int_spinner_simple label lab_width init_value min_value
	max_value value_width step_incr page_incr tip tooltips pack_method] cr�e un
   widget de s�lection d'une valeur enti�re *)
val create_int_spinner_simple :
  string ->
  int ->
  int ->
  int ->
  int ->
  int ->
  int ->
  int ->
  string -> GData.tooltips -> (GObj.widget -> unit) -> GEdit.spin_button

(** [gtk_tools_int_spinner_connect sp callback] connecte le callback � un widget de
   s�lection de valeur enti�re. Le callback est appel� avec la valeur selectionn�e
   � chaque fois que celle-ci change *)
val int_spinner_connect :	GEdit.spin_button -> (int -> unit) -> unit

(** [gtk_tools_create_int_spinner label lab_width init_value min_value max_value
	value_width step_incr page_incr tip tooltips pack_method callback] cr�e un
   widget de s�lection de valeur enti�re avec callback *)
val create_int_spinner :
  string ->
  int ->
  int ->
  int ->
  int ->
  int ->
  int ->
  int ->
  string ->
  GData.tooltips ->
  (GObj.widget -> unit) -> (int -> unit) -> GEdit.spin_button

(** [gtk_tools_create_vslider_simple init_val min_val max_val step page draw_val
   pack_method] cr�ation d'un slider vertical de s�lection d'une valeur enti�re *)
val create_vslider_simple :
  int ->
  int ->
  int ->
  int ->
  int -> bool -> (GObj.widget -> unit) -> GData.adjustment * GRange.scale

(** [gtk_tools_create_hslider_simple init_val min_val max_val step page draw_val
   pack_method] cr�ation d'un slider horizontal de s�lection d'une valeur enti�re *)
val create_hslider_simple :
  int ->
  int ->
  int ->
  int ->
  int -> bool -> (GObj.widget -> unit) -> GData.adjustment * GRange.scale

(** [gtk_tools_slider_connect slider callback] connection d'un callback de
   modification d'un slider de valeur enti�re *)
val slider_connect :
  GData.adjustment -> (int -> unit) -> GtkSignal.id

(** [gtk_tools_create_vslider init_val min_val max_val step page draw_val
	pack_method callback] cr�ation d'un slider vertical de s�lection d'une valeur
   enti�re avec callback *)
val create_vslider :
  int ->
  int ->
  int ->
  int ->
  int ->
  bool ->
  (GObj.widget -> unit) -> (int -> unit) -> GData.adjustment * GRange.scale

(** [gtk_tools_create_hslider init_val min_val max_val step page draw_val
	pack_method callback] cr�ation d'un slider horizontal de s�lection d'une valeur
   enti�re avec callback *)
val create_hslider :
  int ->
  int ->
  int ->
  int ->
  int ->
  bool ->
  (GObj.widget -> unit) -> (int -> unit) -> GData.adjustment * GRange.scale


(** {6 S�lection de valeurs flottantes} *)


(** [gtk_tools_create_float_spinner_simple label lab_width init_value min_value
   max_value value_width nb_digits step_incr page_incr tip tooltips pack_method]
   cr�e un widget de s�lection d'une valeur flottante *)
val create_float_spinner_simple :
  string ->
  int ->
  float ->
  float ->
  float ->
  int ->
  int ->
  float ->
  float ->
  string -> GData.tooltips -> (GObj.widget -> unit) -> GEdit.spin_button

(** [gtk_tools_float_spinner_connect sp callback] connecte le callback � un widget de
   s�lection de valeur flottante. Le callback est appel� avec la valeur selectionn�e
   � chaque fois que celle-ci change *)
val float_spinner_connect : GEdit.spin_button -> (float -> unit) -> unit

(** [gtk_tools_create_float_spinner label lab_width init_value min_value max_value
	value_width nb_digits step_incr page_incr tip tooltips pack_method callback]
   cr�e un widget de s�lection de valeur flottante avec callback *)
val create_float_spinner :
  string ->
  int ->
  float ->
  float ->
  float ->
  int ->
  int ->
  float ->
  float ->
  string ->
  GData.tooltips ->
  (GObj.widget -> unit) -> (float -> unit) -> GEdit.spin_button


(** {6 Zones de texte} *)


(** [gtk_tools_create_text_entry_simple label lab_width init_value value_width
	tip tooltips pack_method] : zone de s�lection de texte. Renvoie le label et
   la zone de s�lection de texte *)
val create_text_entry_simple :
  string ->
  int ->
  string ->
  int ->
  string ->
  GData.tooltips -> (GObj.widget -> unit) -> GMisc.label * GEdit.entry

(** [gtk_tools_text_entry_connect entry callback] connecte un callback li� �
   l'appui sur la touche entr�e dans la zone [entry] *)
val text_entry_connect :
  GEdit.entry -> (string -> unit) -> GtkSignal.id

(** [gtk_tools_text_entry_connect_modify entry callback] connecte un callback
   appel� � chaque fois que le texte de la zone [entry] est modifi�. Le callback
   re�oit la chaine contenue dans la zone en majuscules *)
val text_entry_connect_modify :
  GEdit.entry -> (string -> unit) -> GtkSignal.id

(** [gtk_tools_create_text_entry label lab_width init_value value_width
	tip tooltips pack_method callback] zone de s�lection de texte avec callback
   li� � la modification du texte dans la zone *)
val create_text_entry :
  string ->
  int ->
  string ->
  int ->
  string ->
  GData.tooltips ->
  (GObj.widget -> unit) -> (string -> unit) -> GMisc.label * GEdit.entry

(** [gtk_tools_text_entry_select_text entry] selectionne le texte pr�sent dans
   la zone de texte *)
val text_entry_select_text : GEdit.entry -> unit

(** [gtk_tools_create_text_edit editable with_vert_scroll with_hor_scroll pack_method]
   cr�e une zone de texte multiligne (editeur) avec �ventuellement des barres de
   d�filement ([with_vert_scroll] et [with_hor_scroll]). [editable] indique si
   la zone cr��e est �ditable par l'utilisateur *)
val create_text_edit : bool -> bool -> bool -> (GObj.widget -> unit)
	-> GText.view

(** [gtk_tools_text_edit_clear edit] efface le contenu d'une zone de texte *)
val text_edit_clear : GText.view -> unit

(** [gtk_tools_text_edit_get_text edit] renvoie l'int�gralit� du texte contenu
   dans [edit] *)
val text_edit_get_text : GText.view -> string

(** [gtk_tools_text_edit_get_lines edit] identique � la fonction pr�c�dente sauf
   que le texte contenu dans le widget est renvoy� sous la forme d'une liste de
   chaines de caract�res, chacune d'elles correspondant � une ligne dans la
   zone de texte *)
val text_edit_get_lines : GText.view -> string list

(** [gtk_tools_text_edit_set_text_list edit text_lst] ins�re la liste de chaines
   de caract�res dans la zone de texte *)
val text_edit_set_text_list : GText.view -> string list -> unit

(** [gtk_tools_text_edit_set_text edit text] ins�re le texte indiqu� dans la
   zone de texte *)
val text_edit_set_text : GText.view -> string -> unit


(** {6 Fenetres enregistr�es} *)


(** Type pour les fenetres enregistr�es *)
type registered_win = {
  reg_win_id : int;
  mutable reg_win_handle : GWindow.window option;
  reg_win_build : unit -> GWindow.window;
} 

(** Exception lev�e lors de l'appel � un num�ro de fenetre non enregistr�e *)
exception GTK_TOOLS_UNREGISTERED_WINDOW of int

(** [gtk_tools_register_window build_window_func] enregistre une fenetre.
   [build_window_func] est la fonction de cr�ation de la fenetre en question *)
val register_window : (unit -> GWindow.window) -> int

(** [gtk_tools_show_registered_window id] cr�e la fenetre enregistr�e design�e par
   [id]. Si la fenetre existe d�j� elle est mise en avant plan *)
val show_registered_window : int -> unit

(** [gtk_tools_hide_registered_window id] d�truit la fenetre enregistr�e si elle
   existe *)
val hide_registered_window : int -> unit

(** [gtk_tools_get_registered_window id] renvoie la fenetre enregistr�e
   correspondant � l'identifiant [id] *)
val get_registered_window : int -> GWindow.window option


(** {6 Listes} *)


(** [gtk_tools_create_list lst_titles (sortable_titles, first_sort) pack_method]
   cr�e une liste :
   - [lst_titles] liste des titres des colonnes
   - [sortable_titles] les titres sont-ils s�lectionnables pour trier la liste ?
   - [first_sort] indique quelle est la colonne qui sert de tri initialement
   - [pack_method] o� mettre la liste *)
val create_list :
  string list -> bool * int -> (GObj.widget -> unit) -> string GList.clist

(** [gtk_tools_create_list_with_hor_scroll lst_titles
   (sortable_titles, first_sort) pack_method] cr�e une liste avec une barre de
   scroll horizontale *)
val create_list_with_hor_scroll :
  string list -> bool * int -> (GObj.widget -> unit) -> string GList.clist

(** [gtk_tools_set_columns_sizes list sizes] met � jour la taille des colonnes
   de la liste [list] *)
val set_columns_sizes : string GList.clist -> int list -> unit

(** [gtk_tools_list_connect clist
   callback_select callback_deselect callback_select_column] connecte les
   �v�nements s�lection/d�s�lection et s�lection d'un titre de colonne. Les
   callbacks [callback_select] et [callback_deselect] re�oivent en param�tres
   la ligne et la colonne (d�)s�lectionn�es. [callback_select_column] re�oit le
   num�ro de la colonne *)
val list_connect :
  string GList.clist ->
  (int -> int -> unit) option ->
  (int -> int -> unit) option -> (int -> unit) option -> unit

(** [gtk_tools_list_connect_check_dbl_click clist
	callback_select callback_deselect callback_select_column] meme chose que la
   fonction pr�c�dente sauf que l'on teste s'il y a double click. Ici,
   [callback_select] et [callback_deselect] re�oivent la ligne, la colonne et
   un booleen indiquant s'il y a eu double click *)
val list_connect_check_dbl_click :
  string GList.clist ->
  (int -> int -> bool -> unit) option ->
  (int -> int -> bool -> unit) option -> (int -> unit) option -> unit

(** [gtk_tools_list_connect_up_down_keys clist callback_up callback_down]
   connecte les callbacks li�s � l'appui sur les touches flech�es haut et bas *)
val list_connect_up_down_keys :
  string GList.clist -> (unit -> 'a) -> (unit -> 'b) -> unit

(** [gtk_tools_create_managed_list titles_sizes pack_method] cr�e une liste manag�e.
   [titles_sizes] est une liste du type [(nom, taille)] indiquant le titre
   ainsi que la largeur des diff�rentes colonnes. Cet objet contient en plus
   un label indiquant le nombre d'�l�ments contenus dans la liste.

   En retour, la liste et le label sont renvoyes *)
val create_managed_list :
  (string * int) list ->
  (GObj.widget -> unit) -> string GList.clist * GMisc.label

(** [gtk_tools_connect_managed_list (lst, lab) item_column selection_callback
   (name, female, cap)] connecte le callback de (d�)s�lection � une liste
   manag�e, les callbacks de selection avec les touches flech�es et indique le
   format du label de titre :
   - [(lst, lab)] = la liste et le label renvoy�s par la fonction pr�c�dente
   - [item_column] = num�ro de la colonne contenant l'item de r�f�rence
   - [selection_callback] = la fonction appel�e lors d'une (d�)s�lection.
   Elle appel�e avec en param�tres : l'�l�ment s�lectionn� (i.e �l�ment de la ligne
   s�lectionn�e et dans la colonne [item_column]), un triplet [(ligne, colonne,
   double_ckick)] et un booleen valant vrai si s�lection et faux si d�s�lection
   - [(name, female, cap)] indique le format � utiliser pour afficher le nombre
   d'�l�ments de la liste (voir [eval_string])

   En retour est renvoy�e la fonction permettant de mettre � jour le contenu de
   la liste. Cett fonction prend en param�tres :
   - l'identifiant de la ligne � s�lectionner par defaut ("" si pas de
   s�lection initiale)
   - une liste contenant des listes correspondant aux diff�rentes lignes *)
val connect_managed_list :
  string GList.clist * GMisc.label ->
  int ->
  (string -> int * int * bool -> bool -> unit) ->
  string * bool * bool -> string -> string list list -> unit


(** {6 Widget Lat/Lon} *)


(** Type contenant un widget de s�lection de coordonn�es lat/lon *)
type latlon = {
  latlon_lat_val : float ref;
  latlon_lon_val : float ref;
  latlon_update : float -> float -> unit;
  latlon_change_callback : (unit -> unit) option ref;
} 

(** [gtk_tools_create_latlon_selection (lat, lon) pack_method tooltips] cr�e un
   widget de s�lection de coordonn�es g�ographiques lat/lon *)
val create_latlon_selection :
  float * float ->
  (GObj.widget -> unit) -> GData.tooltips -> latlon

(** [gtk_tools_update_latlon_selection latlon_widget new_lat new_lon] met � jour
   les coordonn�es dans un widget de s�lection lat/lon *)
val update_latlon_selection :
  latlon -> float -> float -> unit

(** [gtk_tools_latlon_selection_get latlon_widget] recup�re les coordonn�es
   selectionn�es dans le widget *)
val latlon_selection_get : latlon -> float * float

(** [gtk_tools_latlon_selection_change latlon_widget callback] connecte un
   callback appel� lors de la modification des coordonn�es. Il ne prend pas de
   param�tre : pour avoir connaitre la valeur des coordonn�es, il faut utiliser
   {!Gtk_tools.gtk_tools_latlon_selection_get} *)
val latlon_selection_change :
  latlon -> (unit -> unit) -> unit


(** {6 Fenetre de Log} *)

(** Exception lev�e lors de l'ajout de texte dans la fenetre de log alors que
   celle-ci n'a pas encore ete cr��e *)
exception GTK_TOOLS_NO_LOG_WIN

(** renvoie la zone de texte de la fenetre de log si cette derniere a ete cr��e.
   Si ce n'est pas le cas alors l'exception {!Gtk_tools.GTK_TOOLS_NO_LOG_WIN}
   est lev�e *)
val get_log_wid : unit -> GText.view

(** [gtk_tools_add_log text level] ajoute un texte dans la fenetre de log
   si [level]<[log_verbose_level]*)
val add_log : string -> int -> unit

(** [gtk_tools_add_log_with_color text level color] meme chose que la
   fonction pr�c�dente sauf que [color] indique la couleur du texte � ajouter *)
val add_log_with_color : string -> int -> GDraw.color -> unit

(** efface le contenu de la fenetre de log *)
val clear_log : unit -> unit

(** [gtk_tools_create_log tooltips] cr�e la fenetre de log *)
val create_log : GData.tooltips -> unit

(** force l'affichage de la fenetre de log *)
val show_log : unit -> unit

(** d�truit la fenetre de log *)
val hide_log : unit -> unit

(** [gtk_tools_set_log_verbose_level level] met � jour le niveau de verbose
   dans la fenetre de log *)
val set_log_verbose_level : int -> unit


(** {6 Barres de progression} *)


(** [gtk_tools_create_progress_bar_win title] cr�e une barre de progression
   dans une fenetre externe. En sortie, la fonction de mise � jour de la barre de progression
   est renvoy�e. Cette fonction prend en param�tre un flottant compris entre
   0.0 et 1.0, lorsqu'on lui passe 1.0, la fenetre est ferm�e *)
val create_progress_bar_win : string -> float -> unit

(** [gtk_tools_create_progress_bar pack_method] creation d'une barre de
   progression continue et sans fenetre (donc diff�rente de
   {!Gtk_tools.gtk_tools_create_progress_bar_win}.
   La fonction de mise � jour de la progression est renvoy�e et prend en
   param�tre un flottant compris entre 0.0 et 1.0 *)
val create_progress_bar : (GObj.widget -> unit) -> float -> unit


(** {6 Widget de selection d'op�rateur de comparaison} *)


(** Op�rateurs de comparaison *)
type t_ops_compare = T_EQ | T_L | T_LEQ | T_G | T_GEQ

(** [gtk_tools_create_ops_compare variable callback_modified pack_method] cr�e un
   widget de s�lection d'op�rateur de comparaison.
   - [variable] est une r�f�rence sur l'op�rateur en cours
   - [callback_modified] est appel� lorsque l'op�rateur est modifi�. Cette fonction
   est optionnelle. Si elle est utilis�e alors elle prend en param�tre la
   valeur courante de l'op�rateur de comparaison
   - [pack_method] indique o� mettre le widget de s�lection
 *)
val create_ops_compare :
  t_ops_compare ref ->
  (t_ops_compare -> unit) option -> (GObj.widget -> unit) -> unit


(** {6 Widget de s�lection d'une heure} *)


(** [gtk_tools_create_time_select variable callback_modified pack_method] cr�e un
   widget de s�lection d'heure. [variable] est une r�f�rence sur un entier
   contenant l'heure en secondes *)
val create_time_select :
  int ref -> (int -> unit) option -> (GObj.widget -> unit) -> unit


(** {6 Fenetre d'affichage d'infos} *)


(** [gtk_tools_create_infos_win title width height] cr�e une fenetre d'affichage
   d'informations sous forme de labels.

   En retour est renvoy� un couple contenant la fonction d'ajout d'un nouveau texte
   ainsi que la fonction de fermeture de la fenetre *)
val create_infos_win :
  string -> int -> int -> (string -> unit) * (unit -> unit)


(** {6 Widget affichant le contenu d'un fichier texte} *)


(** [gtk_tools_display_file filename title width height tooltips font] affiche
   le contenu d'un fichier dans une fenetre *)
val display_file :
  string -> string -> int -> int -> GData.tooltips -> string option -> unit


(** {6 Combo box} *)


(** [gtk_tools_create_combo lst_items pack_method] cr�e une combo box *)
val create_combo_simple :
	string list -> (GObj.widget -> unit) -> GEdit.entry

(** [gtk_tools_combo_connect entry lst_items callback] connecte [callback] qui est
   appel� lors de la modification de la valeur dans la combo box *)
val combo_connect : GEdit.entry -> (string*'a) list -> ('a->unit) -> unit


(** {6 Widget calendrier} *)

(** [gtk_tools_calendar lst_dates callback_select only_available_dates_selectable
	init_with_last_available_date tooltips win pack_method] cr�e un widget
   calendrier permettant de choisir une date. Les param�tres sont :

   - [lst_dates] contient (�ventuellement) la liste des dates autoris�es sous
   la forme d'un entier (ex. : 20030721)
   - [callback_select] d�signe la fonction appel�e apr�s s�lection. La date choisie
   est pass�e en param�tre
   - [only_available_dates_selectable] indique si celles les dates autoris�es sont
   selectionnables (ainsi, seules ces derni�res peuvent appeler [callback_select])
   - [init_with_last_available_date] sert � l'initialisation du calendrier.
   Si cette valeur vaut vrai, le calendrier affiche le mois et l'ann�e correspondant
   � la date la plus tardive parmi les dates autoris�es. Sinon, le mois courant
   est affich�
   - [tooltips] d�signe le syst�me d'aide contextuelle
   - [win] correspond � la fenetre m�re
   - [pack_method] indique o� mettre le widget
 *)
val calendar : int list -> (int -> unit) -> bool -> bool ->
  GData.tooltips -> GWindow.window -> (GObj.widget -> unit) -> unit

(** [gtk_tools_calendar_window lst_dates callback_select only_available_dates_selectable
   init_with_last_available_date is_modal tooltips] cr�e une boite de dialogue
   affichant un calendrier et permettant de choisir une date.

   Les param�tres utilis�s sont les suivants :

   - [lst_dates] contient (�ventuellement) la liste des dates autoris�es sous
   la forme d'un entier (ex. : 20030721)
   - [callback_select] d�signe la fonction appel�e apr�s s�lection. La date choisie
   est pass�e en param�tre
   - [only_available_dates_selectable] indique si celles les dates autoris�es sont
   selectionnables (ainsi, seules ces derni�res peuvent appeler [callback_select])
   - [init_with_last_available_date] sert � l'initialisation du calendrier.
   Si cette valeur vaut vrai, le calendrier affiche le mois et l'ann�e correspondant
   � la date la plus tardive parmi les dates autoris�es. Sinon, le mois courant
   est affich�
   - [is_modal] indique si la fenetre doit etre modale
 *)
val calendar_window : int list -> (int -> unit) -> bool -> bool -> bool ->
  GData.tooltips -> unit
