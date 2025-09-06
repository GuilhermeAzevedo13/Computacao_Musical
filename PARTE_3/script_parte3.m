% ==============================================================================
% SCRIPT DE TESTE PARA A PARTE 3 - EFEITOS SONOROS (COM BATIDA E SOPRO)
% ==============================================================================

clear; clc;
fs = 44100;

disp('--- Testando Efeitos Sonoros da Parte 3 ---');

% --- 1. Geração dos Sons Originais ---
% Parâmetros para os sons
dur_bate = 0.8;
dur_sopro = 2.0; % Duração maior para o sopro
freq_grave = 60;
freq_aguda = 440;

disp('Gerando sons originais (batida grave, batida aguda e sopro)...');
som_grave = fm_bate(freq_grave, dur_bate, fs);
som_agudo = fm_bate(freq_aguda, dur_bate, fs);
som_sopro = fm_sopro(freq_aguda, dur_sopro, fs); % Gera o som de sopro

% Normaliza os sons para evitar clipping antes dos efeitos
som_grave = som_grave / max(abs(som_grave));
som_agudo = som_agudo / max(abs(som_agudo));
som_sopro = som_sopro / max(abs(som_sopro));

% --- 2. Aplicação e Reprodução dos Efeitos ---

% --- OVERDRIVE ---
disp('--- Aplicando Overdrive ---');
som_grave_od = overdrive(som_grave, 5);
som_agudo_od = overdrive(som_agudo, 5);
som_sopro_od = overdrive(som_sopro, 5); % Aplica no sopro

disp('Tocando Batida Grave com Overdrive...');
soundsc(som_grave_od, fs); pause(dur_bate + 0.2);
disp('Tocando Batida Aguda com Overdrive...');
soundsc(som_agudo_od, fs); pause(dur_bate + 0.2);
disp('Tocando Sopro com Overdrive...');
soundsc(som_sopro_od, fs); pause(dur_sopro + 0.5);

% --- DISTORÇÃO ---
disp('--- Aplicando Distorção ---');
som_grave_dist = distorcao(som_grave, 15);
som_agudo_dist = distorcao(som_agudo, 15);
som_sopro_dist = distorcao(som_sopro, 15); % Aplica no sopro

disp('Tocando Batida Grave com Distorção...');
soundsc(som_grave_dist, fs); pause(dur_bate + 0.2);
disp('Tocando Batida Aguda com Distorção...');
soundsc(som_agudo_dist, fs); pause(dur_bate + 0.2);
disp('Tocando Sopro com Distorção...');
soundsc(som_sopro_dist, fs); pause(dur_sopro + 0.5);

% --- TREMOLO ---
disp('--- Aplicando Tremolo ---');
som_grave_trem = tremolo(som_grave, fs);
som_agudo_trem = tremolo(som_agudo, fs);
som_sopro_trem = tremolo(som_sopro, fs); % Aplica no sopro

disp('Tocando Batida Grave com Tremolo...');
soundsc(som_grave_trem, fs); pause(dur_bate + 0.2);
disp('Tocando Batida Aguda com Tremolo...');
soundsc(som_agudo_trem, fs); pause(dur_bate + 0.2);
disp('Tocando Sopro com Tremolo...');
soundsc(som_sopro_trem, fs); pause(dur_sopro + 0.5);

% --- ALIASING ---
disp('--- Aplicando Aliasing ---');
som_grave_alias = aplicar_aliasing(som_grave, fs);
som_agudo_alias = aplicar_aliasing(som_agudo, fs);
som_sopro_alias = aplicar_aliasing(som_sopro, fs); % Aplica no sopro

disp('Tocando Batida Grave com Aliasing...');
soundsc(som_grave_alias, fs); pause(dur_bate + 0.2);
disp('Tocando Batida Aguda com Aliasing...');
soundsc(som_agudo_alias, fs); pause(dur_bate + 0.2);
disp('Tocando Sopro com Aliasing...');
soundsc(som_sopro_alias, fs); pause(dur_sopro + 0.5);

disp('--- Testes da Parte 3 finalizados ---');
