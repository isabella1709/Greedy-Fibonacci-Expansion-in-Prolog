% RA1 - Problemas Prolog
% Isabella, Michele e Yejin

%%%%%% Problema 1: Expansão Gulosa de Fibonacci %%%%%%
% FATOS: conjunto de pedras do jogo

% Verifica se X ou Y é um inteiro positivo
inteiro_positivo(X) :- 
    integer(X), 
    X > 0.

% Predicado para divisão de dois termos
divisao(X, Y, Decimal) :-
    Y \= 0,
    Decimal is X / Y.

% MDC: calcula o máximo divisor comum
mdc(X, 0, X) :- !. %Se o segundo número for 0, o mdc é o primeiro número
mdc(X, Y, R) :-
    Y > 0,
    R1 is X mod Y,
    mdc(Y, R1, R).

% MMC: calcula o mínimo múltiplo comum
mmc(X, Y, R) :-
    mdc(X, Y, R1),
    R is abs(X * Y) // R1.

% Calcula a subtração de frações 
subtracao_fracao(X1, Y1, X2, Y2, X3, Y3) :-
    mmc(Y1, Y2, R),
    Numerador1 is (X1 * R) // Y1,
    Numerador2 is (X2 * R) // Y2,
    X3 is Numerador1 - Numerador2,
    Y3 is R.

% Função principal para encontrar a expansão gulosa de Fibonacci
gananciosa(X, Y, EG) :- 
    ((Y > 100000) ->  
        false
    ;
    (X > Y) ->  
    	false
    ;   
    \+ inteiro_positivo(X) ->
    	false
    ;   
    \+ inteiro_positivo(Y) ->  
    	false
    ;   
    gananciosa_recursivo(X, Y, [], EG)
    ).

% Função recursiva de gananciosa
gananciosa_recursivo(X, Y, Lista, EG_final) :-
    divisao(X, Y, Decimal),
    (
        % Se chegar a zero, para o loop e retorna a lista EG
        Decimal =< 0 ->  
            EG_final = Lista          
    ;
        % Ceiling arredonda um número para cima
    	% EX: fração 3/7 -> 7/3 = 2.333... -> F = 3
        F is ceiling(Y / X),
      
        % Subtrai a fração X/Y - 1/F = X_resultado/Y_resultado
        subtracao_fracao(X, Y, 1, F, X_resultado, Y_resultado),

        % Adiciona o denominador F na lista
        append(Lista, [F], NovaEG), % Adiciona o denominador F à Lista, criando uma nova lista NovaEG.
             
        % Recursivamente, pega o resultado da subtração e continua as operações
        gananciosa_recursivo(X_resultado, Y_resultado, NovaEG, EG_final)
    ).
