open Graph

(* A path is a list of nodes. *)
type path = id list

(*
Fonction qui renvoie un chemin quelconque valide entre l'origine
et la destination
*)
val find_path: int graph -> id list -> id -> id -> path option

(*
Calcule la capacité maximum que l'on peut faire passer
dans le chemin précédemment établi
*)
val max_flow: int graph -> path option -> int

(*
Renvoie un nouveau graphe avec la capacité diminuée sur le chemin
parcouru 
*)
val decrease_capa: int graph -> path option -> int -> int graph

(*
Se sert de toutes les fonctions préalablement décrites pour
renvoyer un nouveau graphe de flot maximal entre l'origine et
la destination
*)
val ford_fulkerson: int graph -> int -> int -> int graph