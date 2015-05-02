(** Simple command line tool to convert roman numerals to integers 
*)

(** [main] function - handles command line arguments and exit codes *)
let main () =
   let argv = Array.to_list Sys.argv in
   let args = List.tl argv in
   let this = List.hd argv |> Filename.basename in
   match args with
   | [str]  -> Printf.printf "%s = %d\n" str @@ Roman.to_int str; exit 0
   | _      -> Printf.eprintf "usage: %s <roman numeral>\n" this; exit 1

        
let () = main ()


