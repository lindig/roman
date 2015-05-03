
(** raised in case of error *)
exception Error of string

(** [of_int n] returns the representation of [n] as a roman numeral.
val of_int: int -> string (* raises Error *)

(** [to_int str] takes a roman numeral [str] and computes its value 
    as an integer. [to_int] is case insensitive and accepts the modern 
    syntax for roman numerals as described in 
    http://en.wikipedia.org/wiki/Roman_numerals *)

val to_int: string -> int (* raises Error *)


