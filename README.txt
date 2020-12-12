Ce qu'on a réussi à faire :
- Les préalables au projet
- La partie 1 du projet : Notre ford fulkerson semble fonctionner plutôt bien, même si le
graphe obtenu n'est pas très esthétique...
- La partie 2: nous avons choisi le use-case du "money sharing" qui consiste à répartir
équitablement et efficacement les dettes entre plusieurs personnes à l'aide de ford fulkerson

Ce que nous n'avons pas réussi à faire:
- La partie 3: Nous avons manqué de temps

Mode d'emploi pour utiliser ford fulkerson:
- dans ftest, éxecuter make demo (la partie ford fulkerson doit être décommentée, et la partie
money sharing doit être commentée)
- Vérifier le résultat obtenu dans le fichier graph.svg
On peut constater que les 3 arcs sortants du noeud origine (0) ont tous une capacité de 0
et que le débit maximal a donc bien été atteint dans ce graphe.

Mode d'emploi pour le money sharing:
- écrire dans le fichier Comptes les dépenses effectuées (de la forme <nom> : <dépense> avec un
retour à la ligne)
- exécuter la commande make demo (en prenant soin de commenter la première partie de ftest
qui concerne exclusivement ford fulkerson -la partie 1- et de décommenter le reste )
- Pour vérifier: ouvrir le fichier graph.svg et le fichier Sommes_dues, comparer les valeurs
On peut voir qu'au final tout le monde paye une somme égale.