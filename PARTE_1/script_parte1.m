% SCRIPT DE TESTE PARA A PARTE 1 - SÍNTESE DE INSTRUMENTOS

clear;
clc;
fs = 44100;
freq_teste = 440; % Nota Lá 4 (A4)
dur_teste = 2;

disp('--- Testando Instrumentos da Parte 1 ---');

% a) Teste do Sopro
disp('Tocando som de Sopro...');
som_sopro = fm_sopro(freq_teste, dur_teste, fs);
soundsc(som_sopro, fs);
pause(dur_teste + 0.5);

% b) Teste da Corda
disp('Tocando som de Corda...');
som_corda = fm_corda(freq_teste, dur_teste, fs);
soundsc(som_corda, fs);
pause(dur_teste + 0.5);

% c) Teste da Batida Aguda
disp('Tocando som de Batida (Aguda)...');
som_bate_agudo = fm_bate(freq_teste, 0.5, fs); % Duração curta para percussão
soundsc(som_bate_agudo, fs);
pause(1);

% --- Teste da Batida Grave (Adicionado) ---
disp('Tocando som de Batida (Grave)...');
freq_grave = 60; % Frequência baixa para um som de bumbo
som_bate_grave = fm_bate(freq_grave, 0.5, fs); % Usa a mesma duração curta
soundsc(som_bate_grave, fs);
pause(1);

disp('--- Testes da Parte 1 finalizados ---');
