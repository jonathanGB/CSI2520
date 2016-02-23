%% Personnes => Jules, Gilles, Jean, Joe, Ghislain
%% Metiers => platrier, menuisier, macon, ferblantier, couvreur
%% resultats => 64 a 84, pair

%% Ghislain => 72
%% Couvreur => 74
%% Gilles => 82
%% Macon => 70
%% Ferblantier => Joe - 4 --- ferblantier smallest
%% Jules => Menuisier - 8 --- jules is not the best, therefore not ferblantier

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
player(ghislain, M, 72) :- !, metier(M), M \= couvreur, M \= macon, M \= ferblantier.
player(gilles, M, 82) :- !, metier(M), M \= couvreur, M \= macon, M \= ferblantier.
player(_, M, P) :- metier(M), between(32, 42, Pdouble), P is Pdouble * 2.


% Question 1b) --> ajouter contraintes
contrainteCouvreur(player(_, M, _)) :- M \= couvreur, !.
contrainteCouvreur(player(_, couvreur, 74)).

contrainteMacon(player(_, M, _)) :- M \= macon, !.
contrainteMacon(player(_, macon, 70)).

contrainteMenuisier(player(_, M, _), player(jules, _, _)) :- M \= menuisier, !.
contrainteMenuisier(player(_, menuisier, P), player(jules, _, P2)) :- P =:= P2 + 8.

contrainteFerblantier(player(_, M, _), player(joe, _, _)) :- M \= ferblantier, !.
contrainteFerblantier(player(_, ferblantier, P), player(joe, _, P2)) :- P =:= P2 - 4.

allDifferent([]) :- !.
allDifferent([_]) :- !.
allDifferent([H|T]) :- not(member(H, T)), allDifferent(T).

getSmallest(CurrSm, [], CurrSm) :- !.
getSmallest(CurrSm, [H|T], Sm) :- CurrSm < H, getSmallest(CurrSm, T, Sm), !.
getSmallest(CurrSm, [H|T], Sm) :- CurrSm > H, getSmallest(H, T, Sm), !.
getSmallest([H|T], Sm) :- getSmallest(H, T, Sm).

smallestFerblantier([[M|[P|[]]]|_], Sm) :- M == ferblantier, P =:= Sm, !.
smallestFerblantier([[M|[_|[]]]|T], Sm) :- M \= ferblantier, smallestFerblantier(T, Sm).

contrainteGagnant([M1, P1], [M2, P2], [M3, P3], [M4, P4], [M5, P5]) :- getSmallest([P1, P2, P3, P4, P5], Sm), smallestFerblantier([[M1, P1], [M2, P2], [M3, P3], [M4, P4], [M5, P5]], Sm), !.


% Question 1c)
scores(player(jules,M1,P1), player(jean,M2,P2), player(gilles,M3,P3), player(joe,M4,P4), player(ghislain,M5,P5)) :-
	player(jules, M1, P1), M1 \= menuisier, M1 \= ferblantier, P1 >= 66, P1 =< 76, contrainteCouvreur(player(jules, M1, P1)), contrainteMacon(player(jules, M1, P1)),
	player(joe, M4, P4), M4 \= ferblantier, P4 >= 68, P4 =< 72, contrainteCouvreur(player(joe, M4, P4)), contrainteMacon(player(joe, M4, P4)), contrainteMenuisier(player(joe, M4, P4), player(jules, M1, P1)),
	player(jean, M2, P2), contrainteCouvreur(player(jean, M2, P2)), contrainteMacon(player(jean, M2, P2)), contrainteMenuisier(player(jean, M2, P2), player(jules, M1, P1)), contrainteFerblantier(player(jean, M2, P2), player(joe, M4, P4)),
	player(gilles, M3, P3), contrainteMenuisier(player(gilles, M3, P3), player(jules, M1, P1)),
	player(ghislain, M5, P5), contrainteMenuisier(player(ghislain, M5, P5), player(jules, M1, P1)),
	allDifferent([M1, M2, M3, M4, M5]) , allDifferent([P1, P2, P3, P4, P5]), contrainteGagnant([M1, P1], [M2, P2], [M3, P3], [M4, P4], [M5, P5]), !.
