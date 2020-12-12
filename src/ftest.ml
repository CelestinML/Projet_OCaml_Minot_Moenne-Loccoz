open Gfile
open Tools
open Graph
open Ford_fulkerson

(***************************************************************************)
(*************Tests ford_fulkerson avec le graph de base********************)
(***************************************************************************)

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (* On convertit le graphe en int graph pour pouvoir appliquer ford_fulkerson *)
  let graph = gmap graph (fun lbl -> (int_of_string lbl)) in

  (* On applique ford fulkerson au graphe entre les nodes 0 et 5 *)
  let graph = ford_fulkerson graph 0 5 in
  
  (* On reconvertit le graphe en string graphe pour l'afficher avec dot *)
  let graph = gmap graph (fun lbl -> string_of_int(lbl)) in

  (* On exporte le graphe sous un format lisible par dot, dans outfile *)
  let () = export outfile graph in

  ()
  



  
(***************************************************************************)
(*************************Tests money sharing*******************************)
(***************************************************************************)

  (*
  open Money_sharing

  let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = "Comptes"
  (* outfile sera ici utilisé pour stocker le graphe et l'afficher avec dot *)
  and outfile = Sys.argv.(4)
  and dettes = "Sommes_dues"

  
  in

  (* On lit le fichier Comptes pour récupérer les dépenses *)
  let list = lire_comptes infile in
  (* On calcule les sommes dues par tous *)
  let list = calculer_sommes_dues list in
  (* On applique ford_fulkerson au graphe obtenu à partir de cette liste pour répartir les dettes *)
  let graph = repartir_dettes list in
  (* On écrit les dettes finales dans un fichier (en l'occurence Sommes_dues) *)
  ecrire_dettes dettes graph list;
  (* On convertit le graphe en string graph pour l'exporter en un format lisible par dot *)
  let graph = gmap graph (fun lbl -> string_of_int(lbl)) in
  (* On exporte le graphe dans outfile en un format lisible par dot *)
  let () = export outfile graph in

  ()
  *)