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
        ( Roman.to_int str |> ignore
        ; false
        )
    with 
        Roman.Error _ -> true

let test () =
    let rec loop i =
        if i = 0 then true else
            let r  = Roman.of_int i  in
            let i' = Roman.to_int r  in
            let r' = Roman.of_int i' in
            r = r' && i = i' && loop (i-1)
    in
        loop 3999 && List.for_all fail syntax

let integer str =
    try int_of_string str
    with Failure _ -> error "not an integer: %s" str

let usage () =
    List.iter prerr_endline
[ "usage: roman mmxv"
; "       roman -i 123"
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
                  let i  = integer n in
                  let r  = Roman.of_int i  in
                  let i' = Roman.to_int r  in
                  let r' = Roman.of_int i' in
                  if i = i' && r = r' then
                  ( Printf.printf "passed (%s)\n" r
                  ; exit 0
                  ) else
                  ( Printf.printf "failed (%d = %s = %s = %d)\n" i r r' i'
                  ; exit 1
                  )
   |  "-h"::_  -> (usage (); exit 0)
   | [str]     -> ( Printf.printf "%d\n"  (Roman.to_int str)
                  ; exit 0
                  )
   | ["-i";n]  -> ( Printf.printf "%s\n" (Roman.of_int @@ integer n)
                  ; exit 0
                  )
   | _         -> ( usage ()
                  ; exit 1
                  )
        
let () = 
    try main () with 
    | Roman.Error msg -> Printf.eprintf "%s\n" msg; exit 1


