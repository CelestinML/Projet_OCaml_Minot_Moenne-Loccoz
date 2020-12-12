open Graph 
open Ford_fulkerson
open Printf

type path = string

let read id list line =
  try Scanf.sscanf line "%s : %d" (fun nom depense -> List.append list [(id, nom, depense)])
  with e ->
    printf "Cannot read node in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

let lire_comptes path =

  let infile = open_in path in

  let rec loop n list =
    try
      let line = input_line infile in

      let line = String.trim line in

      let (n2, list2) =
        if line = "" then (n, list)

        else (n+1, read n list line)

      in
      loop n2 list2

    with End_of_file -> list
  in

  let final_list = loop 1 [] in

  close_in infile ;
  final_list

  let calculer_sommes_dues list =
    let total_amount_paid = List.fold_left (fun acc (_,_,money)-> acc + money ) 0 list in
    let duePerPerson = total_amount_paid / (List.length list) in
    List.map (fun (id,name,money)-> (id,name, money-duePerPerson)) list

  let rec creer_noeuds graph list = match list with
    | [] -> graph
    | (id,_,_)::rest -> creer_noeuds (new_node graph id) rest 

  let creer_arcs_infinis graph list =
    let rec loop1 graph1 list1 = match list1 with
      | [] -> graph1
      | (id1,_,_)::rest1 -> 
      let rec loop2 graph2 list2 = match list2 with
        | [] -> loop1 graph2 rest1
        | (id2,_,_)::rest2 -> if id1 = id2 then loop2 graph2 rest2 else loop2 (new_arc graph2 id1 id2 max_int) rest2
      in loop2 graph1 list
    in loop1 graph list

  let ajout_noeuds_deb_fin graph list =
    let final_graph = new_node graph 0 in
    let final_graph = new_node final_graph ((List.length list) + 1) in
    let rec loop graph1 list1 = match list1 with
      | [] -> graph1
      | (id,_,money)::rest -> if money < 0 then loop (new_arc graph1 0 id (abs money)) rest
                              else if money > 0 then loop (new_arc graph1 id ((List.length list) + 1) money) rest 
                              else loop graph1 rest
    in loop final_graph list

  let init_graph list = 
    let graph = empty_graph in 
    let graph = creer_noeuds graph list in
    let graph = creer_arcs_infinis graph list in
    ajout_noeuds_deb_fin graph list

  let remove_some value = match value with
    | None -> 0
    | Some(x) -> x 

  let clean_graph graph list =
    let rec loop1 graph1 list1 = match list1 with
      | [] -> graph1
      | (id1,_,_)::rest1 -> 
      let rec loop2 graph2 list2 = match list2 with
        | [] -> loop1 graph2 rest1
        | (id2,_,_)::rest2 -> if id1 = id2 then loop2 graph2 rest2 else loop2 (new_arc graph2 id1 id2 ((remove_some (find_arc graph2 id1 id2)) - max_int)) rest2
      in loop2 graph1 list
    in loop1 graph list

  let repartir_dettes list =
    let graph = init_graph list in
    let graph = ford_fulkerson graph 0 ((List.length list)+1) in
    clean_graph graph list

  let extraire_nom (_,name,_) = name

  let ecrire_dettes path graph list =
    
    (* Open a write-file. *)
    let ff = open_out path in

    let rec loop1 list1 = match list1 with
      | [] -> close_out ff; ()
      | (id1,name,_)::rest1 ->
        let arcs1 = out_arcs graph id1 in
        let rec loop2 arcs2 = match arcs2 with
          | [] -> loop1 rest1
          | (id2, money)::rest2 -> if (money < 0) && (List.exists (fun (id,_,_) -> id = id2) list) then 
          (fprintf ff "%s doit %d à %s\n" name (abs money) (extraire_nom (List.find (fun (id,_,_) -> id = id2) list)));
          loop2 rest2
        in loop2 arcs1
    in loop1 list