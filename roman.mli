(** 
    Convert between a Roman Numeral and an integer. 

    (c) 2015 Christian Lindig <lindig@gmail.com>
    Covered by the BSD 2-clause license.
*)

(** raised in case of error *)
exception Error of string
type number =
    | Roman     of string
    | Decimal   of int

(** [as_roman n] returns the representation of [n] as a roman numeral. *)
val as_roman: int -> string (* raises Error *)

(** [from_roman] takes a roman numeral [str] and computes its value 
    as an integer. [to_int] is case insensitive and accepts the modern 
    syntax for roman numerals as described in 
    http://en.wikipedia.org/wiki/Roman_numerals *)
val from_roman: string -> int (* raises Error *)


(** [scan str] reads a string that is either a roman numeral or an integer
    and returns it *)
val scan: string -> number

