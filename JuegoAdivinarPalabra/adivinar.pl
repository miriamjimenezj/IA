% Palabra secreta
palabra_secreta(['i', 'n', 't', 'e', 'l', 'i', 'g', 'e', 'n', 'c', 'i', 'a']).

% Letras adivinadas
:- dynamic letras_adivinadas/1.
letras_adivinadas([]).

% Intentos restantes
:- dynamic intentos_restantes/1.
intentos_restantes(10).

% Regla para adivinar una letra
adivinar(Letra) :-
intentos_restantes(Intentos),
    (Intentos > 0 ->
        (palabra_secreta(Palabra),
        (member(Letra, Palabra) ->
            (retract(letras_adivinadas(Letras)),
            append(Letras, [Letra], NuevasLetras),
            assert(letras_adivinadas(NuevasLetras)),
            writeln('¡Correcto!'));
            writeln('Incorrecto, intenta de nuevo.')),
        decrementar_intentos,
        mostrar_intentos,
        mostrar_palabra);
        writeln('Has agotado todos tus intentos. Fin del juego.')).

% Regla para decrementar los intentos
decrementar_intentos :-
    retract(intentos_restantes(Intentos)),
    NuevosIntentos is Intentos - 1,
    assert(intentos_restantes(NuevosIntentos)).

% Regla para mostrar la palabra secreta
mostrar_palabra :-
    palabra_secreta(Palabra),
    letras_adivinadas(Letras),
    mostrar_palabra(Palabra, Letras).

mostrar_palabra([], _) :-
    nl.
mostrar_palabra([Letra|Resto], Letras) :-
    (member(Letra, Letras) ->
        write(Letra);
        write('_')),
    write(' '),
    mostrar_palabra(Resto, Letras).

% Regla para mostrar los intentos restantes
mostrar_intentos :-
    intentos_restantes(Intentos),
    write('Intentos restantes: '),
    writeln(Intentos).

% Regla para iniciar el juego
iniciar_juego :-
    writeln('Bienvenido al juego de adivinar la palabra secreta.'),
    writeln('Ingresa "adivinar(Letra)." para adivinar una letra.'),
    mostrar_palabra.

