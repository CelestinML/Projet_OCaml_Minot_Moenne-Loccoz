open Graph 

type path = string

(*
On lit le fichier et on obtient une liste qui contient pour 
chaque personne son id et l'argent qu'elle a dépensé
*)
val lire_comptes: path -> (int*string*int) list

(*
On va convertir la liste obtenue pour ne plus avoir la somme dépensée, mais la somme due
Si la somme due est négative, la personne doit de l'argent
Si la somme due est positive, on doit de l'argent à la personne
*)
val calculer_sommes_dues: (int*string*int) list -> (int*string*int) list

val init_graph: (int*string*int) list -> int graph

val repartir_dettes: (int*string*int) list -> int graph

val ecrire_dettes: path -> int graph -> (int*string*int) list -> unit