(* Yes, we have to repeat open Graph. *)
open Graph

let clone_nodes gr =  n_fold gr (fun nv_graph id -> new_node nv_graph id) empty_graph

let rec gmap gr f = 
  let nodes = clone_nodes gr in
  e_fold gr (fun nv_graph id1 id2 lbl -> new_arc nv_graph id1 id2 (f lbl)) nodes
  
let add_arc gr id1 id2 lbl = match (find_arc gr id1 id2) with
 | Some x -> new_arc gr id1 id2 (lbl+x)
 | None -> new_arc gr id1 id2 lbl