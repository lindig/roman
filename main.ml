(** Simple command line tool to convert roman numerals to integers 
*)

let tests =     
    [ "i"       ,1
    ; "iv"      ,4
    ; "II"      ,2
    ; "mdc"     ,1600
    ; "cmxlix"  ,949
    ; "ix"      ,9
    ; "xxix"    ,29
    ; "lxvi"    ,66
    ]

let test () = 
    List.for_all (fun (left,right) -> Roman.to_int left = right) tests

(** [main] function - handles command line arguments and exit codes *)
let main () =
   let argv = Array.to_list Sys.argv in
   let args = List.tl argv in
   let this = List.hd argv |> Filename.basename in
   match args with
   | ["-test"] -> if test () 
                  then (Printf.printf "passed\n"; exit 0)
                  else (Printf.printf "failed\n"; exit 1)
   | [str]     -> Printf.printf "%d\n" @@ Roman.to_int str; exit 0
   | _         -> Printf.eprintf "usage: %s <roman numeral>\n" this; exit 1



        
let () = 
    try main () with 
    | Roman.Error msg -> Printf.eprintf "%s\n" msg; exit 1


