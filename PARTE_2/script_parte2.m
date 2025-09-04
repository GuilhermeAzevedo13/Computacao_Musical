% ==============================================================================
% SCRIPT PARA A PARTE 2
% ==============================================================================

clear; clc;
fs = 44100; % Frequência de amostragem

% --- As strings de percussão não serão executadas, mas estão aqui como no enunciado ---
string_ex1 = 'T2,Ip,Cn54F,Cn54f,Cn54f,Cn54f,Cn54F,Cn54f,Cn54f,Cn54f';
string_ex2 = 'T1,Ip,Cn22F,Cn24f,Cn84F,Cn52f,Cn22f,Cn24F,Cn54F,Cn82F';

% --- String base da melodia de Asa Branca ---
string_asa_branca = 'T1,Ic,Cn34f,Dn34f,En32f,Gn32F,Gn32f,En32f,Fn32f,Fn31F';


% --- Exemplo 1: Asa Branca com Corda ---
disp('--- Gerando Exemplo 1: Asa Branca com Corda ---');
som_ex3 = toca_string(string_asa_branca, fs);
disp('Tocando a versão com Corda...');
soundsc(som_ex3, fs);
audiowrite('asa_branca_corda.wav', som_ex3, fs);
pause(length(som_ex3)/fs + 1);


% --- Exemplo 2: Asa Branca com Sopro ---
disp('--- Gerando Exemplo 2: Asa Branca com Sopro ---');
string_asa_branca_sopro = strrep(string_asa_branca, 'Ic', 'Is');
som_ex4 = toca_string(string_asa_branca_sopro, fs);
disp('Tocando a versão com Sopro...');
soundsc(som_ex4, fs);
audiowrite('asa_branca_sopro.wav', som_ex4, fs);
pause(length(som_ex4)/fs + 1);

% --- EXEMPLO 3: Asa Branca com Batida Aguda ---
disp('--- Gerando Exemplo 3: Asa Branca com Batida Aguda ---');
% 1. Muda o instrumento para 'Ip' (percussão)
string_asa_branca_bate = strrep(string_asa_branca, 'Ic', 'Ip');
% 2. Muda a oitava de 3 para 4 em todas as notas para o som ficar mais AGUDO
string_asa_branca_bate_agudo = strrep(string_asa_branca_bate, 'n3', 'n4');

som_ex5 = toca_string(string_asa_branca_bate_agudo, fs);
disp('Tocando a versão com Batida Aguda...');
soundsc(som_ex5, fs);
audiowrite('asa_branca_batida_aguda.wav', som_ex5, fs);
pause(length(som_ex5)/fs + 1);


disp('--- Todos os testes finalizados! ---');
