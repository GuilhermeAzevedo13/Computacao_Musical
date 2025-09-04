function som_final = toca_string(string_musical, fs)
% Processa uma string musical e gera o áudio correspondente.

    % --- 1. Inicialização de Parâmetros ---
    duracao_padrao = 1.0; % Duração padrão em segundos
    instrumento_atual = @fm_corda; % Instrumento padrão
    som_final = []; % Vetor de áudio de saída, inicialmente vazio

    % --- 2. Processamento da String ---
    % Divide a string em blocos, usando a vírgula como separador
    blocos = strsplit(string_musical, ',');

    % Itera sobre cada bloco de comando ou nota
    for i = 1:length(blocos)
        bloco_atual = strtrim(blocos{i}); % Remove espaços em branco

        if isempty(bloco_atual)
            continue; % Pula blocos vazios
        end

        % --- 3. Interpretação dos Blocos ---

        % Se o bloco define a DURAÇÃO (inicia com 'T')
        if startsWith(bloco_atual, 'T')
            duracao_padrao = str2double(bloco_atual(2:end));
            fprintf('Duração padrão definida para: %.2f segundos\n', duracao_padrao);

        % Se o bloco define o INSTRUMENTO (inicia com 'I')
        elseif startsWith(bloco_atual, 'I')
            switch bloco_atual(2)
                case 'c'
                    instrumento_atual = @fm_corda;
                    disp('Instrumento alterado para: Corda');
                case 's'
                    instrumento_atual = @fm_sopro;
                    disp('Instrumento alterado para: Sopro');
                case 'p'
                    instrumento_atual = @fm_bate;
                    disp('Instrumento alterado para: Percussão');
            end

        % Se não for 'T' nem 'I', é uma NOTA
        else
            nota_str = bloco_atual;
            disp(['Processando nota: ', nota_str]);

            % Extrai os parâmetros da nota
            frequencia = nota_para_freq(nota_str(1:3));
            denominador_dur = str2double(nota_str(4));
            intensidade_char = nota_str(5);

            % Calcula a duração da nota
            if isequal(instrumento_atual, @fm_bate)
                % Para percussão, a duração é a padrão (ignora o denominador)
                duracao_nota = duracao_padrao;
            else
                duracao_nota = duracao_padrao / denominador_dur;
            end

            % Define a amplitude
            if intensidade_char == 'F'
                amplitude = 1.0;
            else % 'f'
                amplitude = 0.5;
            end

            % Gera o som da nota usando o instrumento atual
            nota_gerada = instrumento_atual(frequencia, duracao_nota, fs);

            % Aplica a amplitude e anexa ao som final
            som_final = [som_final; nota_gerada * amplitude];
        end
    end
    disp('Processamento da string finalizado.');
end
