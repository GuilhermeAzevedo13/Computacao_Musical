% ==============================================================================
% SCRIPT DE TESTE PARA A PARTE 3 - EFEITOS SONOROS
% ==============================================================================

clear; clc;
fs = 44100;

disp('--- Testando Efeitos Sonoros da Parte 3 ---');

% --- 1. Geração dos Sons Originais ---
dur_bate = 0.8; % Duração um pouco maior para ouvir melhor o tremolo
freq_grave = 60;  % Frequência para a batida grave
freq_aguda = 440; % Frequência para a batida aguda

disp('Gerando sons de batida (grave e aguda)...');
som_grave = fm_bate(freq_grave, dur_bate, fs);
som_agudo = fm_bate(freq_aguda, dur_bate, fs);

% Normaliza os sons para evitar clipping antes dos efeitos
som_grave = som_grave / max(abs(som_grave));
som_agudo = som_agudo / max(abs(som_agudo));

% --- 2. Aplicação e Reprodução dos Efeitos ---

% --- OVERDRIVE ---
disp('--- Aplicando Overdrive ---');
som_grave_od = overdrive(som_grave, 5);
som_agudo_od = overdrive(som_agudo, 5);

disp('Tocando Batida Grave com Overdrive...');
soundsc(som_grave_od, fs); pause(dur_bate + 0.2);

disp('Tocando Batida Aguda com Overdrive...');
soundsc(som_agudo_od, fs); pause(dur_bate + 0.5);

% --- DISTORÇÃO ---
disp('--- Aplicando Distorção ---');
som_grave_dist = distorcao(som_grave, 15);
som_agudo_dist = distorcao(som_agudo, 15);

disp('Tocando Batida Grave com Distorção...');
soundsc(som_grave_dist, fs); pause(dur_bate + 0.2);

disp('Tocando Batida Aguda com Distorção...');
soundsc(som_agudo_dist, fs); pause(dur_bate + 0.5);

% --- TREMOLO ---
disp('--- Aplicando Tremolo ---');
som_grave_trem = tremolo(som_grave, fs);
som_agudo_trem = tremolo(som_agudo, fs);

disp('Tocando Batida Grave com Tremolo...');
soundsc(som_grave_trem, fs); pause(dur_bate + 0.2);

disp('Tocando Batida Aguda com Tremolo...');
soundsc(som_agudo_trem, fs); pause(dur_bate + 0.5);


disp('--- Testes da Parte 3 finalizados ---');
