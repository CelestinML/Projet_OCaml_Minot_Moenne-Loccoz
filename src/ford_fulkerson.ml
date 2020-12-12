open Graph

type path = id list

let rec find_valid_dest list_arcs forbidden = match list_arcs with
| [] -> None
| (ndest, cap)::rest -> if ((cap > 0) && (not (List.exists (fun x -> x = ndest) forbidden))) then Some(ndest) else find_valid_dest rest forbidden

let rec find_path1 graph forbidden src dest = 
  if src = dest then [src] else
    let next_node = find_valid_dest (out_arcs graph src) forbidden in
    match next_node with
    | None -> []
    | Some(next) -> src::(find_path1 graph (next::forbidden) next dest)

let find_path graph forbidden src dest =
  let path = find_path1 graph forbidden src dest in
  if (List.exists (fun x -> x = dest) path) then Some(path) else None

let max_flow graph path_option = match path_option with
  | None -> 0
  | Some path -> let rec loop graph path max = match path with
    | [] -> max  
    | node1::rest1 ->  match rest1 with
      | [] -> max
      | node2::rest2 -> match (find_arc graph node1 node2) with
        | None -> max (*Ce cas ne devrait pas arriver, on le met pour que le compilateur ne râle pas*)
        | Some cap -> if cap < max then loop graph rest1 cap else loop graph rest1 max
    in loop graph path max_int (*max_int est contenu dans Int et correspond au plus grand entier géré par Ocaml*)

let decrease_capa graph path_option flow = match path_option with
  | None -> graph
  | Some path -> let rec loop graph path = match path with
    | [] -> graph
    | node1::rest1 ->  match rest1 with
      | [] -> graph
      | node2::rest2 -> match (find_arc graph node1 node2) with
        | None -> graph (*Ce cas ne devrait pas arriver, on le met pour que le compilateur ne râle pas*)
        | Some cap -> match find_arc graph node2 node1 with
          | None ->  let graph2 = new_arc graph node2 node1 flow in
          loop (new_arc graph2 node1 node2 (cap-flow)) rest1
          | Some cap2 -> let graph2 = new_arc graph node2 node1 (flow+cap2) in
          loop (new_arc graph2 node1 node2 (cap-flow)) rest1          
    in loop graph path

let rec ford_fulkerson graph nsrc ndest = 
  let path = find_path graph [nsrc] nsrc ndest in
  match path with
    | None -> graph
    | _ -> let flow = max_flow graph path in
    ford_fulkerson (decrease_capa graph path flow) nsrc ndest