function y = fm_sopro(frequencia, duracao, f_amostragem)
    % Parâmetros atualizados para um timbre de sopro/metal
    f_port = frequencia;
    % Relação 2:1 (modulante:portadora) cria um som com mais harmônicos ímpares
    f_mod = 2 * frequencia;
    % Índice de brilho mais baixo para um som menos estridente
    indice_brilho = 3;
    
    % Envelope com ataque mais rápido e curvas diferentes para soar mais natural
    attack_time = 0.1 * duracao;
    decay_time  = 0.9 * duracao;
    env_portadora = @(t) envelope(attack_time, decay_time, 3, 1.5, t);
    
    % O timbre (brilho) continua acompanhando a amplitude
    env_modulante = @(t) indice_brilho * env_portadora(t);
    
    % Chama a síntese FM
    y = fm_synth(f_port, f_mod, env_portadora, env_modulante, duracao, f_amostragem);
end