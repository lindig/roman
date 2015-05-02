{
    (**
    Command line tool to convert roman numerals to decimal. For the
    syntax of roman numerals see Wikipedia. This tool implements
    the subtraction rule, for example:

    ix = 9
    cm = 900
    cd = 400
    
    (c) 2015 Christian Lindig <lindig@gmail.com>
    *)

    exception Error of string
    let error fmt = Printf.kprintf (fun msg -> raise (Error msg)) fmt
}

rule syntax = parse (* check syntax *)
    ( "M" | "MM" | "MMM" )? (* could use "M"* to avoid limit *)
    ( "D"? ( "C" | "CC" | "CCC" )? | "CD" | "CM" )? 
    ( "L"? ( "X" | "XX" | "XXX" )? | "XL" | "XC" )?
    ( "V"? ( "I" | "II" | "III" )? | "IV" | "IX" )?
    eof { true }

and digit = parse (* return value of roman digit *)
    | "M"       { 1000 }
    | "CM"      { 900  }
    | "D"       { 500  }
    | "CD"      { 400  }
    | "C"       { 100  }
    | "XC"      { 90   }
    | "L"       { 50   }
    | "XL"      { 40   }
    | "X"       { 10   }
    | "IX"      { 9    }
    | "V"       { 5    }
    | "IV"      { 4    }
    | "I"       { 1    }
    | eof       { 0    }
    | _         { error "not a roman digit: %s" @@ Lexing.lexeme lexbuf }

{

(** [is_wellformed str] is true, iff [str] is a roman numeral.
    [is_wellformed] is case insensitive. *)
let is_wellformed str =
    try  syntax @@ Lexing.from_string str 
    with Failure _ -> false

(** [scan str] computes the integer value of roman numeral [str]. An empty
    string has value zero. [scan] assumes that [str] has the correct 
    syntax and does not check for it. *)
let scan str =
    let state = Lexing.from_string str in
    let rec loop sum = match digit state with
        | 0 -> sum
        | n -> loop (sum + n)
    in
        loop 0

(** [to_int str] returns integer value of roman numeral [str]. The function
    is case insensitive and validates the syntax of [str]. In case of an
    error it raises [Error msg]. *)
let to_int str =
    let str = String.uppercase str in
    if is_wellformed str 
    then scan str
    else error "not a roman numeral: %s" str

}
