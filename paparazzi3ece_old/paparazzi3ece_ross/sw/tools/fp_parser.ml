type token =
  | INT of (int)
  | FLOAT of (float)
  | IDENT of (string)
  | EOF
  | COMMA
  | SEMICOLON
  | LP
  | RP
  | LC
  | RC
  | LB
  | RB
  | AND
  | COLON
  | OR
  | EQ
  | GT
  | ASSIGN
  | GEQ
  | NOT
  | PLUS
  | MINUS
  | MULT
  | DIV

open Parsing;;
# 3 "fp_parser.mly"
open Fp_syntax
# 31 "fp_parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  260 (* COMMA *);
  261 (* SEMICOLON *);
  262 (* LP *);
  263 (* RP *);
  264 (* LC *);
  265 (* RC *);
  266 (* LB *);
  267 (* RB *);
  268 (* AND *);
  269 (* COLON *);
  270 (* OR *);
  271 (* EQ *);
  272 (* GT *);
  273 (* ASSIGN *);
  274 (* GEQ *);
  275 (* NOT *);
  276 (* PLUS *);
  277 (* MINUS *);
  278 (* MULT *);
  279 (* DIV *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* FLOAT *);
  259 (* IDENT *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\002\000\002\000\003\000\003\000\000\000"

let yylen = "\002\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\002\000\002\000\001\000\001\000\001\000\004\000\003\000\
\004\000\000\000\002\000\000\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\012\000\013\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\011\000\010\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\016\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\008\000\009\000\000\000\019\000\015\000\017\000\
\000\000\021\000"

let yydgoto = "\002\000\
\009\000\025\000\038\000"

let yysindex = "\255\255\
\021\255\000\000\000\000\000\000\255\254\021\255\021\255\021\255\
\077\255\021\255\021\255\051\255\000\000\000\000\021\255\021\255\
\021\255\021\255\021\255\021\255\021\255\021\255\021\255\034\255\
\001\255\064\255\000\000\086\255\086\255\008\255\008\255\008\255\
\003\255\003\255\000\000\000\000\021\255\000\000\000\000\000\000\
\034\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\
\010\000\013\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\025\255\
\000\000\000\000\000\000\090\000\096\000\051\000\064\000\077\000\
\021\000\036\000\000\000\000\000\000\000\000\000\000\000\000\000\
\025\255\000\000"

let yygindex = "\000\000\
\252\255\000\000\249\255"

let yytablesize = 366
let yytable = "\001\000\
\014\000\012\000\013\000\014\000\010\000\024\000\026\000\039\000\
\011\000\022\000\028\000\029\000\030\000\031\000\032\000\033\000\
\034\000\035\000\036\000\018\000\006\000\003\000\004\000\005\000\
\022\000\023\000\006\000\020\000\021\000\022\000\023\000\020\000\
\041\000\042\000\000\000\007\000\000\000\037\000\000\000\007\000\
\000\000\008\000\000\000\000\000\000\000\015\000\000\000\016\000\
\017\000\018\000\003\000\019\000\000\000\020\000\021\000\022\000\
\023\000\027\000\000\000\000\000\000\000\000\000\015\000\001\000\
\016\000\017\000\018\000\000\000\019\000\000\000\020\000\021\000\
\022\000\023\000\040\000\015\000\002\000\016\000\017\000\018\000\
\000\000\019\000\000\000\020\000\021\000\022\000\023\000\000\000\
\015\000\004\000\016\000\017\000\018\000\000\000\019\000\005\000\
\020\000\021\000\022\000\023\000\017\000\018\000\000\000\019\000\
\000\000\020\000\021\000\022\000\023\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\014\000\000\000\000\000\014\000\
\000\000\000\000\000\000\014\000\014\000\000\000\014\000\014\000\
\014\000\000\000\014\000\000\000\014\000\014\000\014\000\014\000\
\006\000\000\000\000\000\006\000\000\000\000\000\000\000\006\000\
\006\000\000\000\006\000\006\000\006\000\000\000\006\000\007\000\
\006\000\006\000\007\000\000\000\000\000\000\000\007\000\007\000\
\000\000\007\000\007\000\007\000\000\000\007\000\003\000\007\000\
\007\000\003\000\000\000\000\000\000\000\003\000\003\000\000\000\
\003\000\003\000\003\000\001\000\003\000\000\000\001\000\000\000\
\000\000\000\000\001\000\001\000\000\000\001\000\001\000\001\000\
\002\000\001\000\000\000\002\000\000\000\000\000\000\000\002\000\
\002\000\000\000\002\000\002\000\002\000\004\000\002\000\000\000\
\004\000\000\000\000\000\005\000\004\000\004\000\005\000\004\000\
\000\000\000\000\005\000\005\000\000\000\005\000"

let yycheck = "\001\000\
\000\000\006\000\007\000\008\000\006\001\010\000\011\000\007\001\
\010\001\000\000\015\000\016\000\017\000\018\000\019\000\020\000\
\021\000\022\000\023\000\007\001\000\000\001\001\002\001\003\001\
\022\001\023\001\006\001\020\001\021\001\022\001\023\001\007\001\
\037\000\041\000\255\255\000\000\255\255\004\001\255\255\019\001\
\255\255\021\001\255\255\255\255\255\255\012\001\255\255\014\001\
\015\001\016\001\000\000\018\001\255\255\020\001\021\001\022\001\
\023\001\007\001\255\255\255\255\255\255\255\255\012\001\000\000\
\014\001\015\001\016\001\255\255\018\001\255\255\020\001\021\001\
\022\001\023\001\011\001\012\001\000\000\014\001\015\001\016\001\
\255\255\018\001\255\255\020\001\021\001\022\001\023\001\255\255\
\012\001\000\000\014\001\015\001\016\001\255\255\018\001\000\000\
\020\001\021\001\022\001\023\001\015\001\016\001\255\255\018\001\
\255\255\020\001\021\001\022\001\023\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\004\001\255\255\255\255\007\001\
\255\255\255\255\255\255\011\001\012\001\255\255\014\001\015\001\
\016\001\255\255\018\001\255\255\020\001\021\001\022\001\023\001\
\004\001\255\255\255\255\007\001\255\255\255\255\255\255\011\001\
\012\001\255\255\014\001\015\001\016\001\255\255\018\001\004\001\
\020\001\021\001\007\001\255\255\255\255\255\255\011\001\012\001\
\255\255\014\001\015\001\016\001\255\255\018\001\004\001\020\001\
\021\001\007\001\255\255\255\255\255\255\011\001\012\001\255\255\
\014\001\015\001\016\001\004\001\018\001\255\255\007\001\255\255\
\255\255\255\255\011\001\012\001\255\255\014\001\015\001\016\001\
\004\001\018\001\255\255\007\001\255\255\255\255\255\255\011\001\
\012\001\255\255\014\001\015\001\016\001\004\001\018\001\255\255\
\007\001\255\255\255\255\004\001\011\001\012\001\007\001\014\001\
\255\255\255\255\011\001\012\001\255\255\014\001"

let yynames_const = "\
  EOF\000\
  COMMA\000\
  SEMICOLON\000\
  LP\000\
  RP\000\
  LC\000\
  RC\000\
  LB\000\
  RB\000\
  AND\000\
  COLON\000\
  OR\000\
  EQ\000\
  GT\000\
  ASSIGN\000\
  GEQ\000\
  NOT\000\
  PLUS\000\
  MINUS\000\
  MULT\000\
  DIV\000\
  "

let yynames_block = "\
  INT\000\
  FLOAT\000\
  IDENT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Fp_syntax.expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 28 "fp_parser.mly"
                             ( CallOperator (">",[_1;_3]) )
# 237 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Fp_syntax.expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 29 "fp_parser.mly"
                              ( CallOperator (">=",[_1;_3]) )
# 245 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Fp_syntax.expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 30 "fp_parser.mly"
                             ( CallOperator ("==",[_1;_3]) )
# 253 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Fp_syntax.expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 31 "fp_parser.mly"
                              ( CallOperator ("&&",[_1;_3]) )
# 261 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Fp_syntax.expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 32 "fp_parser.mly"
                             ( CallOperator ("||",[_1;_3]) )
# 269 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Fp_syntax.expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 33 "fp_parser.mly"
                               ( CallOperator ("+",[_1;_3]) )
# 277 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Fp_syntax.expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 34 "fp_parser.mly"
                                ( CallOperator ("-",[_1;_3]) )
# 285 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Fp_syntax.expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 35 "fp_parser.mly"
                               ( CallOperator ("*",[_1;_3]) )
# 293 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Fp_syntax.expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 36 "fp_parser.mly"
                              ( CallOperator ("/",[_1;_3]) )
# 301 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 37 "fp_parser.mly"
                                  ( CallOperator ("-",[_2]) )
# 308 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Fp_syntax.expression) in
    Obj.repr(
# 38 "fp_parser.mly"
                   ( CallOperator ("!",[_2]) )
# 315 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 39 "fp_parser.mly"
        ( Int _1 )
# 322 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 40 "fp_parser.mly"
          ( Float _1 )
# 329 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 41 "fp_parser.mly"
          ( Ident _1 )
# 336 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'Args) in
    Obj.repr(
# 42 "fp_parser.mly"
                     ( Call (_1, _3) )
# 344 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Fp_syntax.expression) in
    Obj.repr(
# 43 "fp_parser.mly"
                     ( _2 )
# 351 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Fp_syntax.expression) in
    Obj.repr(
# 44 "fp_parser.mly"
                           ( Index (_1, _3) )
# 359 "fp_parser.ml"
               : Fp_syntax.expression))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "fp_parser.mly"
      ( [] )
# 365 "fp_parser.ml"
               : 'Args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Fp_syntax.expression) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'NextArgs) in
    Obj.repr(
# 48 "fp_parser.mly"
                        ( _1::_2 )
# 373 "fp_parser.ml"
               : 'Args))
; (fun __caml_parser_env ->
    Obj.repr(
# 51 "fp_parser.mly"
          ( [] )
# 379 "fp_parser.ml"
               : 'NextArgs))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Fp_syntax.expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'NextArgs) in
    Obj.repr(
# 52 "fp_parser.mly"
                              ( _2::_3 )
# 387 "fp_parser.ml"
               : 'NextArgs))
(* Entry expression *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let expression (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Fp_syntax.expression)
