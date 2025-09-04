function frequencia = nota_para_freq(nota_string)
% Converte uma string de nota (ex: 'Cs4') para sua frequência em Hz.
% A referência usada é A1 = 55 Hz.

    % --- 1. Definir a referência e constantes ---
    FREQ_REF = 55; % Frequência de A1 em Hz
    NOME_REF = 'A';
    OITAVA_REF = 1;

    % --- 2. Extrair as partes da string da nota ---
    nome_nota = nota_string(1);
    acidente = nota_string(2);
    oitava = str2double(nota_string(3));

    % --- 3. Calcular a distância em semitons a partir da referência A1 ---
    distancia_total_semitons = 0;

    % 3.1 Distância pela oitava
    distancia_total_semitons = distancia_total_semitons + (oitava - OITAVA_REF) * 12;

    % 3.2 Distância pelo nome da nota (distância de A até a nota)
    switch upper(nome_nota)
        case 'A', distancia_nota = 0;
        case 'B', distancia_nota = 2; % A -> B = 2 semitons
        case 'C', distancia_nota = 3; % A -> B -> C = 2 + 1 = 3 semitons
        case 'D', distancia_nota = 5; % ...e assim por diante
        case 'E', distancia_nota = 7;
        case 'F', distancia_nota = 8;
        case 'G', distancia_nota = 10;
        otherwise, distancia_nota = 0;
    end
    distancia_total_semitons = distancia_total_semitons + distancia_nota;

    % 3.3 Ajuste pelo acidente (sustenido ou bemol)
    switch acidente
        case 's', distancia_total_semitons = distancia_total_semitons + 1; % sobe 1 semitom
        case 'b', distancia_total_semitons = distancia_total_semitons - 1; % desce 1 semitom
        % case 'n' não faz nada
    end

    % --- 4. Calcular a frequência final usando a fórmula ---
    k = distancia_total_semitons;
    frequencia = FREQ_REF * (2^(k/12));
end
