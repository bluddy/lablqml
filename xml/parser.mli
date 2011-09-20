val ( |> ) : 'a -> ('a -> 'b) -> 'b
val (%<) : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b

val startswith : prefix:string -> string -> bool
val endswith : postfix:string -> string -> bool

type cpptype = { t_name:string; t_is_const:bool; t_indirections:int; t_is_ref:bool; t_params: cpptype list } 
and meth = {
  m_res : cpptype;
  m_name : string;
  m_args : func_arg list;
  m_declared : string;
  m_out_name : string;
  m_access : [ `Private | `Protected | `Public ];
  m_modif : [ `Abstract | `Normal | `Static ];
}
and func_arg = cpptype * string option (* type and default value *)

val void_type : cpptype
val skip_meth : classname:string -> string -> bool
val unreference : cpptype -> cpptype
val string_of_type : cpptype -> string
val string_of_meth : meth -> string
module MethSet :
  sig
    type elt = meth
    type t
    type sexpable = t
    val sexp_of_t : sexpable -> Sexplib.Sexp.t
    val t_of_sexp : Sexplib.Sexp.t -> sexpable
    val empty : t
    val is_empty : t -> bool
    val mem : t -> elt -> bool
    val map : f:(elt -> elt) -> t -> t
    val add : t -> elt -> t
    val singleton : elt -> t
    val remove : t -> elt -> t
    val remove_set : base:t -> t-> t
    val union : t -> t -> t
    val union_list : t list -> t
    val inter : t -> t -> t
    val diff : t -> t -> t
    val compare : t -> t -> int
    val equal : t -> t -> bool
    val subset : t -> t -> bool
    val iter : t -> f:(elt -> unit) -> unit
    val fold : t -> init:'a -> f:(elt -> 'a -> 'a) -> 'a
    val for_all : t -> f:(elt -> bool) -> bool
    val exists : t -> f:(elt -> bool) -> bool
    val filter : t -> f:(elt -> bool) -> t
    val partition : t -> f:(elt -> bool) -> t * t
    val cardinal : t -> int
    val elements : t -> elt list
    val min_elt : t -> elt option
    val min_elt_exn : t -> elt
    val max_elt : t -> elt option
    val max_elt_exn : t -> elt
    val choose : t -> elt option
    val choose_exn : t -> elt
    val of_list : elt list -> t
    val to_list : t -> elt list
    val of_array : elt array -> t
    val to_array : t -> elt array
    val split : elt -> t -> t * bool * t
    val group_by : t -> equiv:(elt -> elt -> bool) -> t list
    val compare_items : elt -> elt -> int
    val length : t -> int
  end

type clas = { 
  c_inherits: string list;
  c_props: prop list;
  c_sigs: sgnl list;
  c_slots: MethSet.t;
  c_meths: MethSet.t; 
  c_enums: enum list;
  c_constrs: constr list;
  c_name: string
}
and namespace = { ns_name:string; ns_classes:clas list; ns_enums:enum list; ns_ns: namespace list }
and enum = {
  e_flag_name : string;
  e_name : string;
  e_items : string list;
  e_access : [ `Private | `Protected | `Public ];
}
and constr = func_arg list
and slt = meth
and sgnl = string * (func_arg list)	
and prop = string * string option * string option	

val is_public: [`Public | `Protected| `Private] -> bool
val empty_namespace : namespace
val ptrtype_of_class : clas -> cpptype
val ptrtype_of_classname: string -> cpptype
val remove_defaults : meth -> meth
val headl : int -> 'a list -> 'a list * 'a list
val is_void_type : cpptype -> bool

val meth_of_constr : classname:string -> func_arg list -> meth
val string_of_constr : classname:string -> func_arg list -> string
(*
val isAbstractMeth : 'a * 'b * 'c * 'd * modifiers list -> bool
val unreference : cpptype -> cpptype
val skipNs : string -> bool
val isTemplateClass : string -> bool
val isInnerClass : string -> bool
val fixTemplateClassName : string -> string
val startswith : prefix:string -> string -> bool
val endswith : postfix:string -> string -> bool
val skipMeth : classname:string -> string -> bool
exception Break
val strip_dd : prefix:string -> string -> string
val attrib_opt : 'a -> ('a * 'b) list -> 'b option
val xname : Simplexmlparser.xml -> string
val attrib : 'a -> ('a * 'b) list -> 'b
  *)
val build : Simplexmlparser.xml -> namespace

val str_replace : patt:(string * string) list -> string -> string
(** The same as fun n list -> (Core_list.take n list, Core_list.drop n list) *)
val headl: int -> 'a list -> 'a list * 'a list

