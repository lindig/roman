(** Simple command line tool to convert roman numerals to integers 
*)

exception Error of string
let error fmt = Printf.kprintf (fun msg -> raise (Error msg)) fmt

let syntax =
    [ "xxxx"
    ; "im"
    ; "abc"
    ; "xcc"  
    ; "ic"
    ; "imm"
    ; "mxm"
    ; "viiii"
    ; "ivi"
    ]

let fail str =
    try 
        ( Roman.from_roman str |> ignore
        ; false
        )
    with 
        Roman.Error _ -> true

let idem i =
    let r  = Roman.as_roman i  in
    let i' = Roman.from_roman r  in
    let r' = Roman.as_roman i' in
    r = r' && i = i' 

let test () =
    let rec loop = function
        | 0 -> true
        | n -> idem n && loop (n-1)
    in
        loop 3999 && List.for_all fail syntax

let integer str =
    try int_of_string str
    with Failure _ -> error "not an integer: %s" str

let usage () =
    List.iter prerr_endline
    [ "usage: roman mmxv        convert mmxv to integer"
    ; "       roman 123         convert 123 to roman"
    ; "       roman -test       run internal tests using 1 .. 3999" 
    ; "       roman -test 123   run internal test using 123"
    ; ""
    ; "(c) 2015 Christian Lindig <lindig@gmail.com>"
    ; "https://github.com/lindig/roman"
    ]

(** [main] function - handles command line arguments and exit codes *)
let main () =
   let argv = Array.to_list Sys.argv in
   let args = List.tl argv in
   match args with
   | ["-test"] -> if test () 
                  then (Printf.printf "passed\n"; exit 0)
                  else (Printf.printf "failed\n"; exit 1)
   | ["-test";n] ->
                  if idem @@ integer n then
                  ( Printf.printf "passed\n"
                  ; exit 0
                  ) else
                  ( Printf.printf "failed\n"
                  ; exit 1
                  )
   |  "-h"::_  -> (usage (); exit 0)
   | [str]     -> ( ( match Roman.scan str with
                    | Roman.Decimal(d) -> 
                        Printf.printf "%s\n" @@ Roman.as_roman d
                    | Roman.Roman(r) ->
                        Printf.printf "%d\n" @@ Roman.from_roman r
                    )
                  ; exit 0
                  )
   | _         -> ( usage ()
                  ; exit 1
                  )
        
let () = 
    try main () with 
    | Roman.Error msg -> Printf.eprintf "%s\n" msg; exit 1


