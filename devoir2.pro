%% Personnes => Jules, Gilles, Jean, Joe, Ghislain
%% Metiers => platrier, menuisier, macon, ferblantier, couvreur
%% resultats => 64 a 84, pair

%% Ghislain => 72
%% Couvreur => 74
%% Gilles => 82
%% Macon => 70
%% Ferblantier => Joe - 4 et plus petit
%% Jules => Menuisier - 8, pas plus 

nom(ghislain).
nom(jules).
nom(gilles).
nom(jean).
nom(joe).

metier(platrier).
metier(menuisier).
metier(macon).
metier(ferblantier).
metier(couvreur).

% Question 1a)
player(N, M, P) :- nom(N), metier(M), between(64, 84, P), Pmod is P mod 2, Pmod =:= 0.

% Question 1b) --> ajouter contraintes

/* player(ghislain, M, 72) :- metier(M).
%% player(N, couvreur, 74) :- nom(N).
%% player(gilles, M, 82) :- metier(M).
%% player(N, macon, 70) :- nom(N).
%% player(N, ferblantier, P) :- nom(N), N \= joe, player(joe, M2, P2), M2 \= ferblantier, P is P2 - 4.
%% player(jules, M, P) :- metier(M), M \= menuisier, player(N2, menuisier, P2), N2 \= jules, P is P2 - 8.
*/
