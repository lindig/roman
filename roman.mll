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

    let concat digits = String.concat "" @@ List.rev digits

    let rec ones digits = function
    | n when n  = 9    -> concat    ("ix" :: digits)
    | n when n >= 5    -> ones      ("v"  :: digits) (n-5)
    | n when n  = 4    -> concat    ("iv" :: digits)
    | n when n >= 1    -> ones      ("i"  :: digits) (n-1)
    | _                -> concat    digits

    let rec tens digits = function
    | n when n >= 90   -> ones      ("xc" :: digits) (n-90)
    | n when n >= 50   -> tens      ("l"  :: digits) (n-50)
    | n when n >= 40   -> ones      ("xl" :: digits) (n-40)
    | n when n >= 10   -> tens      ("x"  :: digits) (n-10)
    | n                -> ones      digits            n 

    let rec hundreds digits = function
    | n when n >= 900  -> tens      ("cm" :: digits) (n-900)
    | n when n >= 500  -> hundreds  ("d"  :: digits) (n-500)
    | n when n >= 400  -> tens      ("cd" :: digits) (n-400)
    | n when n >= 100  -> hundreds  ("c"  :: digits) (n-100)
    | n                -> tens      digits            n 

    let rec thousands = function
    | n when n >= 4000 -> error "can't represent %d" n
    | n when n >= 3000 -> hundreds ["mmm"]  (n-3000)
    | n when n >= 2000 -> hundreds ["mm"]   (n-2000)
    | n when n >= 1000 -> hundreds ["m"]    (n-1000)
    | n                -> hundreds []        n

    let of_int n =
        if n <= 0 || n > 3889 
        then error "can't represent %d as a roman numeral" n 
        else thousands n 

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
