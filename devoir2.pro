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
player(ghislain, M, 72) :- metier(M), M \= couvreur, M \= macon, !.
player(gilles, M, 82) :- metier(M), M \= couvreur, M \= macon, !.
player(N, M, P) :- nom(N), metier(M), between(32, 42, Pdouble), P is Pdouble * 2.


% Question 1b) --> ajouter contraintes
	% contrainteCouvreur(player(N, couvreur, 74)).
contrainteCouvreur(player(N, M, P)) :- (M \= couvreur, true; player(N, couvreur, 74)).
	%contrainteMacon(player(N, macon, 70)).
contrainteMacon(player(N, M, P)) :- (M \= macon, true; player(N, macon, 70)).
contrainteMenuisier(player(N, M, P), player(jules, M2, P2)) :- (M \= menuisier, true; P is P2 + 8).
	%contrainteFerblantier(player(N, ferblantier, P)) :- nom(N), N \= joe, player(joe, M2, P2), M2 \= ferblantier, P is P2 - 4, P >= 64, P =< 72.
contrainteFerblantier(player(N, M, P), player(joe, M2, P2)) :- (M \= ferblantier, true; P is P2 - 4).
contrainteGagnant(P1, P2, P3, P4, P5, LowestP) :- .

% Question 1c)
scores(player(jules,M1,P1), player(jean,M2,P2), player(gilles,M3,P3), player(joe,M4,P4), player(ghislain,M5,P5)) :-
	player(jules, M1, P1), M1 \= menuisier, M1 \= ferblantier, P1 >= 66, contrainteCouvreur(player(jules, M1, P1)), contrainteMacon(player(jules, M1, P1)),
	player(joe, M4, P4), M4 \= ferblantier, P1 >= 66, contrainteCouvreur(player(joe, M4, P4)), contrainteMacon(player(joe, M4, P4)), contrainteMenuisier(player(joe, M4, P4), player(jules, M1, P1)),
	player(jean, M2, P2), contrainteCouvreur(player(jean, M2, P2)), contrainteMacon(player(jean, M2, P2)), contrainteMenuisier(player(jean, M2, P2), player(jules, M1, P1)), contrainteFerblantier(player(jean, M2, P2), player(joe, M4, P4)),
	player(gilles, M3, P3), %finir ligne
	%autre ligne pour ghislain

	%ajouter contrainteMenuisier(player(jules, M1, P1))


/* player(ghislain, M, 72) :- metier(M).
%% player(N, couvreur, 74) :- nom(N).
%% player(gilles, M, 82) :- metier(M).
%% player(N, macon, 70) :- nom(N).
%% player(N, ferblantier, P) :- nom(N), N \= joe, player(joe, M2, P2), M2 \= ferblantier, P is P2 - 4.
%% player(jules, M, P) :- metier(M), M \= menuisier, player(N2, menuisier, P2), N2 \= jules, P is P2 - 8.
*/
