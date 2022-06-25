/*
Los precios son:
codos: $5.
caños: $3 el metro.
canillas: las triangulares $20, del resto $12 hasta 5 cm de ancho,
 $15 si son de más de 5 cm.
*/
precio(codo( _ ), 5).
precio(canio( _ , Longitud), Precio):-
    Precio is Longitud * 3.
precio(canilla(triangular, _ , _ ), 20).
precio(canilla(Tipo, _ , Ancho), 12):-
    Tipo \= triangular,
    Ancho =< 5.
precio(canilla(Tipo, _ , Ancho), 15):-
    Tipo \= triangular,
    Ancho > 5.
precio(Canieria, Precio):-
    precios(Canieria, Precios),
    sum_list(Precios, Precio).

/* ¡¡Esto es un map!! */
precios([], []).
precios([Pieza | Piezas], [Precio | Precios]):-
    precio(Pieza, Precio),
    precios(Piezas, Precios).


% 2 puedoEnchufar/2
color(codo( Color ), Color).
color(canio( Color , _ ), Color).
color(canilla( _ , Color , _ ), Color).

coloresEnchufables(rojo, negro).
coloresEnchufables(azul, rojo).
coloresEnchufables(Color, Color).

puedoEnchufar(Pieza1, Pieza2):- 
    color(Pieza1, Color1),
    color(Pieza2, Color2),
    coloresEnchufables(Color1, Color2).
%3 Modificamos puedoEnchufar/2 para que se banque cañerías
puedoEnchufar(Canieria1, CanieriaOPieza):- 
    last(Canieria1, Pieza1),
    puedoEnchufar(Pieza1, CanieriaOPieza).

puedoEnchufar(CanieriaOPieza, [Pieza2 | _ ]):- 
    puedoEnchufar(CanieriaOPieza, Pieza2).




:- begin_tests(puedoEnchufarPiezas).
test(piezas_del_mismo_color_son_enchufables, nondet):-
    puedoEnchufar(codo(rojo), canio(rojo, 5)).
test(piezas_son_enchufables_si_tienen_colores_enchufables, nondet):-
    puedoEnchufar(codo(rojo), canio(negro, 5)).
:- end_tests(puedoEnchufarPiezas).

:- begin_tests(puedoEnchufarCanierias).
test(canieria_izquierda_terminada_rojo_con_pieza_roja_puede_enchufarse, nondet):-
    puedoEnchufar([canilla(redonda, blanco, 5), codo(rojo)], canio(rojo, 5)).
test(canieria_derecha_empieza_negro_con_pieza_roja_puede_enchufarse, nondet):-
    puedoEnchufar(codo(rojo), [canio(negro, 5), canilla(redonda, blanco, 5)]).
test(canieria_izq_roja_con_canieria_der_negra, nondet):-
    puedoEnchufar(
        [canilla(redonda, blanco, 5), codo(rojo)], 
        [canio(negro, 5), canilla(redonda, blanco, 5)]
    ).
:- end_tests(puedoEnchufarCanierias).

